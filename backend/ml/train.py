from pathlib import Path
import joblib
import pandas as pd
from sklearn.ensemble import RandomForestRegressor
from sklearn.metrics import mean_absolute_error, r2_score
from sklearn.model_selection import train_test_split

ROOT = Path(__file__).resolve().parents[1]
DATA = ROOT / 'data' / 'sample_properties.csv'
MODEL = ROOT / 'ml' / 'model.joblib'

def main() -> None:
    df = pd.read_csv(DATA)
    features = ['area', 'bedrooms', 'bathrooms', 'floors', 'age', 'parking']
    X = df[features]
    y = df['price']
    X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.2, random_state=42)
    model = RandomForestRegressor(n_estimators=250, random_state=42, min_samples_leaf=2)
    model.fit(X_train, y_train)
    predictions = model.predict(X_test)
    metrics = {'mae': mean_absolute_error(y_test, predictions), 'r2': r2_score(y_test, predictions)}
    importance = dict(zip(features, model.feature_importances_))
    joblib.dump({'model': model, 'metrics': metrics, 'feature_importance': importance}, MODEL)
    print({'metrics': metrics, 'feature_importance': importance, 'saved_to': str(MODEL)})

if __name__ == '__main__':
    main()
