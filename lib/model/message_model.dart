class MessageModel {
  final String content;

  MessageModel({this.content = '', DateTime? sendDate});

  factory MessageModel.fromMap(Map<String,dynamic> map){
    return MessageModel(
      content: map['content']??'',
    );
  }

}
