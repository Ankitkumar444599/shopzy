# AI Real Estate

AI Real Estate is a production-oriented Flutter + Firebase + FastAPI starter for intelligent property valuation, market analytics, reports, maps, and prediction history.

## Features

- Flutter Material 3 UI with responsive cards, light and dark themes.
- Riverpod state management and GoRouter navigation.
- Firebase Authentication service for Google, email/password, registration, password reset, logout, and profile-ready flows.
- FastAPI backend exposing prediction, history, deletion, market trends, and comparison endpoints.
- Random Forest Regressor training pipeline with preprocessing-friendly sample data, evaluation metrics, feature importance, and Joblib model export.
- Prediction workflow showing price, confidence score, range, market rating, and AI recommendation.
- Analytics dashboard powered by `fl_chart`.
- Google Maps location intelligence placeholders for schools, hospitals, parks, and shopping malls.
- PDF report generation with `pdf` and `printing` plus local notifications.
- Hive-backed local persistence for prediction history, favorites, and user settings.

## Folder Structure

```text
lib/
  app/             Router and app bootstrap
  constants/       App constants and environment values
  models/          Property and prediction models
  services/        Firebase, API, storage, notification services
  repositories/    Data access abstractions
  providers/       Riverpod state controllers
  screens/         Feature screens
  widgets/         Shared UI components
  themes/          Material 3 theme definitions
  utils/           Formatting helpers
backend/
  app/             FastAPI application
  data/            Sample development dataset
  ml/              Training script and saved model output
assets/            Images and icons
```

## Flutter Setup

1. Install the latest stable Flutter SDK.
2. Configure Firebase for Android, iOS, Web, and desktop as needed:
   ```bash
   dart pub global activate flutterfire_cli
   flutterfire configure
   ```
3. Install packages:
   ```bash
   flutter pub get
   ```
4. Run the app with a backend URL:
   ```bash
   flutter run --dart-define=API_BASE_URL=http://localhost:8000
   ```

## Python Backend Setup

```bash
cd backend
python -m venv .venv
source .venv/bin/activate
pip install -r requirements.txt
python ml/train.py
uvicorn app.main:app --reload
```

## API Endpoints

- `POST /predict` — returns predicted price, confidence, range, market rating, and recommendation.
- `GET /history` — returns in-memory prediction history for development.
- `DELETE /history/{id}` — deletes a prediction from development history.
- `GET /market-trends` — returns monthly trend data.
- `GET /property-comparison` — returns a comparison summary.

## Firebase Configuration

Enable these Firebase products:

- Authentication providers: Email/Password and Google.
- Cloud Firestore for persistent user prediction history.
- Firebase Storage for generated reports and profile images.

Security rules should scope user data by authenticated `uid` before production deployment.

## Deployment

- Flutter: deploy to Google Play, App Store, Firebase Hosting, or static web hosting.
- Backend: deploy FastAPI with Cloud Run, Docker, Fly.io, Render, or Kubernetes.
- ML: retrain on scheduled pipelines and version model artifacts.

## Screenshots

Add screenshots in `docs/screenshots/`:

- Home dashboard
- Prediction result
- Analytics dashboard
- Comparison
- PDF report
- Map selection

## Future Improvements

- Persist prediction history to Firestore for cross-device sync.
- Add generated Hive adapters or Isar for typed offline storage.
- Add real Google Places nearby search.
- Add localization files for multiple languages.
- Add CI for Flutter analyze/tests and backend pytest.
- Add authentication route guards and role-based admin dashboards.
