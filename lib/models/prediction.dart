import 'package:ai_real_estate/models/property_input.dart';

class Prediction {
  const Prediction({
    required this.id,
    required this.input,
    required this.price,
    required this.confidence,
    required this.low,
    required this.high,
    required this.rating,
    required this.recommendation,
    required this.createdAt,
    this.favorite = false,
  });

  final String id;
  final PropertyInput input;
  final double price;
  final double confidence;
  final double low;
  final double high;
  final String rating;
  final String recommendation;
  final DateTime createdAt;
  final bool favorite;

  double get pricePerSquareFoot => price / input.area;

  Prediction copyWith({bool? favorite}) => Prediction(
        id: id,
        input: input,
        price: price,
        confidence: confidence,
        low: low,
        high: high,
        rating: rating,
        recommendation: recommendation,
        createdAt: createdAt,
        favorite: favorite ?? this.favorite,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'input': input.toJson(),
        'predicted_price': price,
        'confidence': confidence,
        'price_range': {'low': low, 'high': high},
        'market_rating': rating,
        'recommendation': recommendation,
        'created_at': createdAt.toIso8601String(),
        'favorite': favorite,
      };

  factory Prediction.fromJson(Map<String, dynamic> json, [PropertyInput? input]) {
    final range = json['price_range'] as Map<String, dynamic>? ?? const {};
    return Prediction(
      id: (json['id'] ?? DateTime.now().microsecondsSinceEpoch).toString(),
      input: input ?? PropertyInput.fromJson(json['input'] as Map<String, dynamic>),
      price: (json['predicted_price'] as num).toDouble(),
      confidence: (json['confidence'] as num).toDouble(),
      low: (range['low'] as num).toDouble(),
      high: (range['high'] as num).toDouble(),
      rating: json['market_rating'] as String,
      recommendation: json['recommendation'] as String,
      createdAt: DateTime.tryParse((json['created_at'] ?? '') as String) ?? DateTime.now(),
      favorite: json['favorite'] as bool? ?? false,
    );
  }
}
