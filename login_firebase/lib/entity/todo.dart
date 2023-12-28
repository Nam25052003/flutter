class ToDo {
  String id;
  String content;
  String account;

  ToDo({required this.id, required this.content, required this.account});

  Map<String, dynamic> toJson() => {
        'id': id,
        'content': content,
        'account': account,
      };

  static ToDo fromJson(Map<String, dynamic> json) =>
      ToDo(id: json['id'], content: json['content'], account: json['account']);
}
