class Note {
  const Note({
    required this.title,
    required this.content,
    required this.createdAt,
  });

  final String title;
  final String content;
  final DateTime createdAt;
}

String formatNoteDate(DateTime dateTime) {
  final String month = dateTime.month.toString().padLeft(2, '0');
  final String day = dateTime.day.toString().padLeft(2, '0');
  final String year = dateTime.year.toString();
  final String hour = dateTime.hour.toString().padLeft(2, '0');
  final String minute = dateTime.minute.toString().padLeft(2, '0');
  return '$month/$day/$year $hour:$minute';
}
