class Launch {
  final int flightNumber;
  final String missionName;
  final DateTime launchDateUtc;
  final String launchSiteName;
  final String? wikipediaUrl;

  Launch({
    required this.flightNumber,
    required this.missionName,
    required this.launchDateUtc,
    required this.launchSiteName,
    this.wikipediaUrl,
  });

  factory Launch.fromJson(Map<String, dynamic> json) {
    return Launch(
      flightNumber: json['flight_number'] as int,
      missionName: json['mission_name'] as String,
      launchDateUtc: DateTime.parse(json['launch_date_utc'] as String),
      launchSiteName: json['launch_site']?['site_name_long'] as String? ?? 'Unknown',
      wikipediaUrl: json['links']?['wikipedia'] as String?,
    );
  }
}
