import 'dart:convert';
import 'package:ai_real_estate/constants/app_constants.dart';
import 'package:ai_real_estate/models/prediction.dart';
import 'package:ai_real_estate/models/property_input.dart';
import 'package:http/http.dart' as http;

class AiApiService {
  const AiApiService({http.Client? client}) : _client = client;
  final http.Client? _client;
  Future<Prediction> predict(PropertyInput input) async {
    final client = _client ?? http.Client();
    final response = await client.post(Uri.parse('${AppConstants.apiBaseUrl}/predict'), headers: {'Content-Type': 'application/json'}, body: jsonEncode(input.toJson()));
    if (response.statusCode >= 400) throw Exception('Prediction failed: ${response.body}');
    return Prediction.fromJson(jsonDecode(response.body), input);
  }
  Future<List<Map<String, dynamic>>> marketTrends() async {
    final response = await (_client ?? http.Client()).get(Uri.parse('${AppConstants.apiBaseUrl}/market-trends'));
    if (response.statusCode >= 400) throw Exception('Unable to load trends');
    return List<Map<String, dynamic>>.from(jsonDecode(response.body));
  }
}
