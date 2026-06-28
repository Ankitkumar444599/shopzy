class PropertyInput {
  const PropertyInput({
    required this.area,
    required this.bedrooms,
    required this.bathrooms,
    required this.floors,
    required this.age,
    required this.parking,
    required this.location,
    required this.propertyType,
  });

  final double area;
  final int bedrooms;
  final int bathrooms;
  final int floors;
  final int age;
  final int parking;
  final String location;
  final String propertyType;

  double get priceRelevantScore =>
      area + bedrooms * 120 + bathrooms * 90 + floors * 50 + parking * 45 - age * 12;

  Map<String, dynamic> toJson() => {
        'area': area,
        'bedrooms': bedrooms,
        'bathrooms': bathrooms,
        'floors': floors,
        'age': age,
        'parking': parking,
        'location': location,
        'property_type': propertyType,
      };

  factory PropertyInput.fromJson(Map<String, dynamic> json) => PropertyInput(
        area: (json['area'] as num).toDouble(),
        bedrooms: (json['bedrooms'] as num).toInt(),
        bathrooms: (json['bathrooms'] as num).toInt(),
        floors: (json['floors'] as num).toInt(),
        age: (json['age'] as num).toInt(),
        parking: (json['parking'] as num).toInt(),
        location: json['location'] as String,
        propertyType: (json['property_type'] ?? json['propertyType']) as String,
      );
}
