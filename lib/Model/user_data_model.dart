class UserDataModel {
  late int userId;
  late int id;
  String? title;
  String? body;

  UserDataModel({
    required this.userId,
    required this.id,
    this.title,
    this.body,
  });

  UserDataModel.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    id = json['id'];
    title = json['title'];
    body = json['body'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['userId'] = userId;
    data['id'] = id;
    data['title'] = title;
    data['body'] = body;
    return data;
  }

  Map<String, dynamic> toMap() => {
        "id": id,
        "userId": userId,
        "title": title,
        "body": body,
      };
}
