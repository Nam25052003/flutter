class ToDo {
  String id;
  String content;
  DateTime? date;
  String account;

  ToDo(
      {required this.id,
      required this.content,
      required this.date,
      required this.account});

  Map<String, dynamic> toJson() => {
        'id': id,
        'content': content,
        'date': date,
        'account': account,
      };

  static ToDo fromJson(Map<String, dynamic> json) => ToDo(
      id: json['id'],
      content: json['content'],
      date: json['date'],
      account: json['account']);
}

class InitialToDoState extends ToDo {
  InitialToDoState(
      {required super.id,
      required super.content,
      required super.date,
      required super.account});
}

class CurrentToDoState extends ToDo {
  CurrentToDoState(
      {required super.id,
      required super.content,
      required super.date,
      required super.account});
}
