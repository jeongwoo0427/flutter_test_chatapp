class ChatroomModel {
  final String id;
  final String name;
  final String password;

  ChatroomModel({
    this.id = '',
    this.name = '',
    this.password = '',
  });

  factory ChatroomModel.fromMap(
      {required String id, required Map<String, dynamic> map}) {
    return ChatroomModel(
        id: id, name: map['name'] ?? '', password: map['password'] ?? '');
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> data = {};
    data['name'] = name;
    data['password'] = password;
    return data;
  }
}
