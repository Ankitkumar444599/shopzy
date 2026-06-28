from pathlib import Path
from statistics import mean
from uuid import uuid4

import joblib
from fastapi import FastAPI, HTTPException
from fastapi.middleware.cors import CORSMiddleware
from pydantic import BaseModel, Field

MODEL_PATH = Path(__file__).resolve().parents[1] / 'ml' / 'model.joblib'

app = FastAPI(title='AI Real Estate API', version='1.0.0')
app.add_middleware(
    CORSMiddleware,
    allow_origins=['*'],
    allow_credentials=True,
    allow_methods=['*'],
    allow_headers=['*'],
)

history: list[dict] = []


class PropertyInput(BaseModel):
    area: float = Field(gt=0)
    bedrooms: int = Field(ge=0)
    bathrooms: int = Field(ge=0)
    floors: int = Field(ge=0)
    age: int = Field(ge=0)
    parking: int = Field(ge=0)
    location: str = Field(min_length=2)
    property_type: str = Field(min_length=2)


class PredictionResponse(BaseModel):
    id: str
    predicted_price: float
    confidence: float
    price_range: dict[str, float]
    market_rating: str
    recommendation: str


def baseline_price(payload: PropertyInput) -> float:
    location_multiplier = {
        'downtown': 1.22,
        'suburb': 0.92,
        'waterfront': 1.35,
        'midtown': 1.12,
    }.get(payload.location.strip().lower(), 1.0)
    type_multiplier = {
        'villa': 1.18,
        'condo': 1.06,
        'apartment': 0.94,
        'townhouse': 1.08,
        'single family': 1.12,
    }.get(payload.property_type.strip().lower(), 1.0)
    base = (
        payload.area * 410
        + payload.bedrooms * 18_000
        + payload.bathrooms * 12_000
        + payload.floors * 8_500
        + payload.parking * 7_000
        - payload.age * 2_500
    )
    return max(base * location_multiplier * type_multiplier, 50_000)


def recommendation(price: float, area: float) -> tuple[str, str]:
    per_sqft = price / area
    if per_sqft < 320:
        return 'Excellent', 'This property is priced below market average. Good investment opportunity.'
    if per_sqft > 520:
        return 'Premium', 'Price is higher than similar nearby properties. Negotiate or verify amenities.'
    return 'Fair', 'This property is aligned with current market comparables.'


def predict_price(payload: PropertyInput) -> float:
    if not MODEL_PATH.exists():
        return baseline_price(payload)
    bundle = joblib.load(MODEL_PATH)
    row = [[payload.area, payload.bedrooms, payload.bathrooms, payload.floors, payload.age, payload.parking]]
    return float(bundle['model'].predict(row)[0])


@app.post('/predict', response_model=PredictionResponse)
def predict(payload: PropertyInput):
    price = predict_price(payload)
    rating, advice = recommendation(price, payload.area)
    result = {
        'id': str(uuid4()),
        'predicted_price': round(price, 2),
        'confidence': 0.89 if MODEL_PATH.exists() else 0.74,
        'price_range': {'low': round(price * 0.92, 2), 'high': round(price * 1.08, 2)},
        'market_rating': rating,
        'recommendation': advice,
    }
    history.append({'input': payload.model_dump(), **result})
    return result


@app.get('/history')
def get_history():
    return history


@app.delete('/history/{item_id}')
def delete_history(item_id: str):
    before = len(history)
    history[:] = [item for item in history if item['id'] != item_id]
    if len(history) == before:
        raise HTTPException(status_code=404, detail='Prediction not found')
    return {'deleted': item_id}


@app.get('/market-trends')
def market_trends():
    return [
        {'month': month, 'median_price': price, 'inventory': inventory}
        for month, price, inventory in zip(
            ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun'],
            [420000, 435000, 440000, 462000, 470000, 481000],
            [188, 176, 164, 158, 149, 141],
        )
    ]


@app.get('/property-comparison')
def property_comparison():
    if len(history) >= 2:
        latest = history[-2:]
        values = [item['predicted_price'] / item['input']['area'] for item in latest]
        winner = latest[values.index(min(values))]['id']
        return {'winner': winner, 'average_price_per_sqft': round(mean(values), 2)}
    return {'winner': 'property_a', 'reason': 'Lower price per square foot and stronger investment score.'}
