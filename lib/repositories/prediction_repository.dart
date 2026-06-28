import 'package:ai_real_estate/models/prediction.dart';
import 'package:ai_real_estate/models/property_input.dart';
import 'package:ai_real_estate/services/ai_api_service.dart';
import 'package:ai_real_estate/services/local_storage_service.dart';
import 'package:hive/hive.dart';

class PredictionRepository {
  PredictionRepository(this._api, {Box<dynamic>? cache})
      : _cache = cache ?? Hive.box(LocalStorageService.predictionsBox) {
    _items.addAll(
      _cache.values
          .whereType<Map>()
          .map((item) => Prediction.fromJson(Map<String, dynamic>.from(item)))
          .toList()
        ..sort((a, b) => b.createdAt.compareTo(a.createdAt)),
    );
  }

  final AiApiService _api;
  final Box<dynamic> _cache;
  final List<Prediction> _items = [];

  List<Prediction> get items => List.unmodifiable(_items);
  List<Prediction> get favorites => _items.where((item) => item.favorite).toList(growable: false);

  Future<Prediction> predict(PropertyInput input) async {
    final prediction = await _api.predict(input);
    _items.insert(0, prediction);
    await _persist();
    return prediction;
  }

  Future<void> delete(String id) async {
    _items.removeWhere((item) => item.id == id);
    await _persist();
  }

  Future<void> toggleFavorite(String id) async {
    final index = _items.indexWhere((item) => item.id == id);
    if (index < 0) return;
    _items[index] = _items[index].copyWith(favorite: !_items[index].favorite);
    await _persist();
  }

  List<Prediction> search(String query) {
    final normalized = query.trim().toLowerCase();
    if (normalized.isEmpty) return items;
    return _items
        .where((item) =>
            item.input.location.toLowerCase().contains(normalized) ||
            item.input.propertyType.toLowerCase().contains(normalized) ||
            item.rating.toLowerCase().contains(normalized))
        .toList(growable: false);
  }

  Future<void> _persist() async {
    await _cache.clear();
    for (final item in _items) {
      await _cache.put(item.id, item.toJson());
    }
  }
}
