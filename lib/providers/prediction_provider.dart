import 'package:ai_real_estate/models/prediction.dart';
import 'package:ai_real_estate/models/property_input.dart';
import 'package:ai_real_estate/repositories/prediction_repository.dart';
import 'package:ai_real_estate/services/ai_api_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final predictionRepositoryProvider = Provider(
  (ref) => PredictionRepository(const AiApiService()),
);

final predictionControllerProvider =
    StateNotifierProvider<PredictionController, AsyncValue<List<Prediction>>>(
  (ref) => PredictionController(ref.watch(predictionRepositoryProvider)),
);

class PredictionController extends StateNotifier<AsyncValue<List<Prediction>>> {
  PredictionController(this._repo) : super(AsyncData(_repo.items));

  final PredictionRepository _repo;

  Future<Prediction> predict(PropertyInput input) async {
    state = const AsyncLoading();
    try {
      final result = await _repo.predict(input);
      state = AsyncData(_repo.items);
      return result;
    } catch (error, stackTrace) {
      state = AsyncError(error, stackTrace);
      rethrow;
    }
  }

  Future<void> delete(String id) async {
    await _repo.delete(id);
    state = AsyncData(_repo.items);
  }

  Future<void> favorite(String id) async {
    await _repo.toggleFavorite(id);
    state = AsyncData(_repo.items);
  }

  List<Prediction> search(String query) => _repo.search(query);
}
