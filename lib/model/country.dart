class Country {
  final String name;
  final double latitude;
  final double longitude;
  final int userCount;

  Country({
    required this.name,
    required this.latitude,
    required this.longitude,
    required this.userCount,
  });

  factory Country.fromJson(Map<String, dynamic> json) {
    return Country(
      name: json['country'],
      latitude: 0.0,
      longitude: 0.0,
      userCount: json['count'],
    );
  }
}
