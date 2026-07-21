class SocialFollow {
  final String followerId;
  final String followingId;
  final DateTime? createdAt;

  const SocialFollow({
    required this.followerId,
    required this.followingId,
    this.createdAt,
  });
}
