class UserProfileModel {
  final String profilePicture;
  final String firstName;
  final String lastName;
  final String userId;
  final String phone;
  final String workPosition;
  final String active;
  final int leftSide;
  final int rightSide;
  final int totalInvites;
  final int mastersCount;
  final int managersCount;
  final int liedersCount;
  final int captainsCount;
  final int baronsCount;
  final int governorsCount;
  final int supremesCount;
  final int bossCount;

  UserProfileModel({
    required this.profilePicture,
    required this.firstName,
    required this.lastName,
    required this.userId,
    required this.phone,
    required this.workPosition,
    required this.active,
    required this.leftSide,
    required this.rightSide,
    required this.totalInvites,
    required this.mastersCount,
    required this.managersCount,
    required this.liedersCount,
    required this.captainsCount,
    required this.baronsCount,
    required this.governorsCount,
    required this.supremesCount,
    required this.bossCount,
  });

  factory UserProfileModel.fromJson(Map<String, dynamic> json) {
    return UserProfileModel(
      profilePicture: json['profilePicture'] as String? ?? '',
      firstName: json['firstName'] as String? ?? '',
      lastName: json['lastName'] as String? ?? '',
      userId: json['userId'] as String? ?? '',
      phone: json['phone'] as String? ?? '',
      workPosition: json['workPosition'] as String? ?? '',
      active: json['active'] as String? ?? '',
      leftSide: json['leftSide'] as int? ?? 0,
      rightSide: json['rightSide'] as int? ?? 0,
      totalInvites: json['totalInvites'] as int? ?? 0,
      mastersCount: json['mastersCount'] as int? ?? 0,
      managersCount: json['managersCount'] as int? ?? 0,
      liedersCount: json['liedersCount'] as int? ?? 0,
      captainsCount: json['captainsCount'] as int? ?? 0,
      baronsCount: json['baronsCount'] as int? ?? 0,
      governorsCount: json['governorsCount'] as int? ?? 0,
      supremesCount: json['supremesCount'] as int? ?? 0,
      bossCount: json['bossCount'] as int? ?? 0,
    );
  }
}
