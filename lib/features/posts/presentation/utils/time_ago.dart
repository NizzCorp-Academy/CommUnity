String getTimeAgo(DateTime createdAt) {
  final now = DateTime.now();
  final difference = now.difference(createdAt);

  if (difference.inSeconds < 60) {
    return "${difference.inSeconds} second${difference.inSeconds == 1 ? '' : 's'} ago";
  } else if (difference.inMinutes < 60) {
    return "${difference.inMinutes} minute${difference.inMinutes == 1 ? '' : 's'} ago";
  } else if (difference.inHours < 24) {
    return "${difference.inHours} hour${difference.inHours == 1 ? '' : 's'} ago";
  } else {
    return "${difference.inDays} day${difference.inDays == 1 ? '' : 's'} ago";
  }
}
