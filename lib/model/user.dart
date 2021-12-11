class User {
  final String avatarUrl;
  final String name;
  final DateTime joinedSince;
  final bool batteryStatus;

  User({
    required this.avatarUrl,
    required this.name,
    required this.joinedSince,
    required this.batteryStatus,
  });
}
