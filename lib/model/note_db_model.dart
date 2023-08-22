class NoteDbModel {
  int? id;
  late String title, content, category, date, color;

  NoteDbModel(
      {required this.title,
      required this.content,
      required this.category,
      required this.date,
      required this.color});

  NoteDbModel.withId(
      {required this.id,
      required this.title,
      required this.content,
      required this.category,
      required this.date,
      required this.color});

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{};
    map["id"] = id;
    map["title"] = title;
    map["content"] = content;
    map["category"] = category;
    map["date"] = date;
    map["color"] = color;
    return map;
  }

  NoteDbModel.fromMap(Map<String, dynamic> map) {
    id = map["id"];
    title = map["title"];
    content = map["content"];
    category = map["category"];
    date = map["date"];
    color = map["color"];
  }
}
