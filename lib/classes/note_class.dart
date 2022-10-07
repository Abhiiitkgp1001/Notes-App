class NoteClass {
  String title;
  int? id;
  int type;
  String description;
  NoteClass({
    this.id,
    this.type = 0,
    this.title = '',
    this.description = '',
  });

  factory NoteClass.fromJson(Map<String, dynamic> json) {
    return NoteClass(
      id: json["_id"],
      type : json['type'],
      title: json["title"],
      description: json["description"],
    );
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      '_id': id,
      'title': title,
      'type' : type,
      'description': description,
    };
    return map;
  }
}
