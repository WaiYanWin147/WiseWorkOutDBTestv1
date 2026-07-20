class UserProfile {
  final String id;
  final String fullName;
  final String email;
  final String gender;
  final String userType;
  final String status;
  final DateTime? createdAt;

  const UserProfile({
    required this.id,
    required this.fullName,
    required this.email,
    required this.gender,
    required this.userType,
    required this.status,
    required this.createdAt,
  });

  UserProfile copyWith({
    String? fullName,
    String? email,
    String? gender,
    String? userType,
    String? status,
  }) {
    return UserProfile(
      id: id,
      fullName: fullName ?? this.fullName,
      email: email ?? this.email,
      gender: gender ?? this.gender,
      userType: userType ?? this.userType,
      status: status ?? this.status,
      createdAt: createdAt,
    );
  }
}
