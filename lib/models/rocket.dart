class Rocket {
  final int id;
  final String rocketId;
  final String rocketName;
  final List<String> flickrImages;

  Rocket({
    required this.id,
    required this.rocketId,
    required this.rocketName,
    required this.flickrImages,
  });

  factory Rocket.fromJson(Map<String, dynamic> json) {
    return Rocket(
      id: json['id'] as int,
      rocketId: json['rocket_id'] as String,
      rocketName: json['rocket_name'] as String,
      flickrImages: (json['flickr_images'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
    );
  }
}
