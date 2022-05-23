class ChatroomModel {
  final String id;
  final String name;
  final String password;
  String recentMessage;

  ChatroomModel({
    this.id = '',
    this.name = '',
    this.password = '',
    this.recentMessage= '',
  });

  factory ChatroomModel.fromMap(
      {required String id, required Map<String, dynamic> map}) {
    return ChatroomModel(
        id: id, name: map['name'] ?? '', password: map['password'] ?? '',recentMessage: map['recentMessage']??'');
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> data = {};
    data['name'] = name;
    data['password'] = password;
    data['recentMessage'] = recentMessage;
    return data;
  }
}
