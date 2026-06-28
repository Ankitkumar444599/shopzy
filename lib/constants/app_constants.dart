class AppConstants {
  static const apiBaseUrl = String.fromEnvironment('API_BASE_URL', defaultValue: 'http://localhost:8000');
  static const appName = 'AI Real Estate';
  static const propertyTypes = ['Apartment', 'Villa', 'Townhouse', 'Condo', 'Single Family'];
}
