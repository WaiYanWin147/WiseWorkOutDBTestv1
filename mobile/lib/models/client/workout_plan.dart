class WorkoutPlan {
  final String title;
  final String duration;
  final String sessionLength;
  final List<String> tags;
  final bool active;
  final List<String> categories;
  final String createdBy;
  bool bookmarked;

  WorkoutPlan({
    required this.title,
    required this.duration,
    required this.sessionLength,
    required this.tags,
    this.active = false,
    this.categories = const [],
    this.createdBy = 'ShapeRush',
    this.bookmarked = false,
  });
}
