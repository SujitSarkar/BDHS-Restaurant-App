String formatTimeDifference(DateTime dateTime) {
  DateTime now = DateTime.now();
  Duration difference = now.difference(dateTime);

  if (difference.inDays > 0) {
    return '${difference.inDays}\nday${difference.inDays == 1 ? '' : 's'} ago';
  } else if (difference.inHours > 0) {
    return '${difference.inHours}\nhour${difference.inHours == 1 ? '' : 's'} ago';
  } else if (difference.inMinutes > 0) {
    return '${difference.inMinutes}\nminute${difference.inMinutes == 1 ? '' : 's'} ago';
  } else {
    return 'Just now';
  }
}