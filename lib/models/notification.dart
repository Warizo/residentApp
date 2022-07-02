class AppNotification {
  final int id;
  final String text;
  final dynamic date;

  AppNotification({required this.id, required this.text, required this.date});

  factory AppNotification.fromJson(Map<String, dynamic> json) =>
      AppNotification(
        id: json.containsKey('id') ? json['id'] : '',
        text: json.containsKey('text') ? json['text'] : '',
        date: json.containsKey('date') ? json['date'] : '',
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'text': text,
        'date': date,
      };
}
