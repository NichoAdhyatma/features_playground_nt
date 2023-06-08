class NoteModel {
  int id;
  int userId;
  String title;
  String content;
  DateTime createdAt;
  DateTime updatedAt;

  NoteModel(
      {required this.id,
      required this.userId,
      required this.title,
      required this.content,
      required this.createdAt,
      required this.updatedAt});

  NoteModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        userId = json['user_id'],
        title = json['title'],
        content = json['content'],
        createdAt = DateTime.parse(json['created_at']).toLocal(),
        updatedAt = DateTime.parse(json['updated_at']).toLocal();

  Map<String, dynamic> toJson() => {
        "id": id,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "user_id": userId,
        "title": title,
        "content": content,
      };
}
