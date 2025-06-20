class Country {
  final String name;
  final String flagUrl;
  final int population;
  final double area;
  final String region;
  final String subregion;
  final List<String> timezones;

  Country({
    required this.name,
    required this.flagUrl,
    required this.population,
    required this.area,
    required this.region,
    required this.subregion,
    required this.timezones,
  });

  factory Country.fromJson(Map<String, dynamic> json) {
    return Country(
      name: json['name']['common'] ?? '',
      flagUrl: json['flags']?['png'] ?? '',
      population: json['population'] ?? 0,
      area: (json['area'] ?? 0).toDouble(),
      region: json['region'] ?? '',
      subregion: json['subregion'] ?? '',
      timezones:
          (json['timezones'] as List?)?.map((e) => e.toString()).toList() ?? [],
    );
  }
}
