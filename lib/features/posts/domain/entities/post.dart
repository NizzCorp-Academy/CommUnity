class Post {
  final String communityId;
  final String category;
  final List<String> comments;
  final String createdAt;
  final String description;
  final String title;
  final String imageUrl;
  Post({
    required this.imageUrl,
    required this.communityId,
    required this.category,
    required this.comments,
    required this.createdAt,
    required this.description,
    required this.title,
  });
}
