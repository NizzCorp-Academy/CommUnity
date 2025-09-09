class UserProfile {
  final String uid;
  final String fullName;
  final String email;
  final int postCount;
  final int commentCount;
  UserProfile({
    required this.postCount,
    required this.commentCount,
    required this.fullName,
    required this.email,
    required this.uid,
  });
}
