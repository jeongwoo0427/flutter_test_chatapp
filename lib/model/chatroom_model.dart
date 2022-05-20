
class ChatroomModel{
  final String id;
  final String name;

  ChatroomModel({
    this.id ='',
    this.name = '',
});

  factory ChatroomModel.fromMap(
      {required String id, required Map<String, dynamic> map}) {
    return ChatroomModel(id: id, name: map['name'] ?? '');
  }

  Map<String, dynamic> toMap(){
    Map<String,dynamic> data = {};
    data['name']=name;
    return data;
  }
}