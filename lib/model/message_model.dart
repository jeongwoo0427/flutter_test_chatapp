class MessageModel {
  final String content;

  MessageModel({this.content = '', DateTime? sendDate});

  //서버로부터 map형태의 자료를 MessageModel형태의 자료로 변환해주는 역할을 수행함.
  factory MessageModel.fromMap(Map<String,dynamic> map){
    return MessageModel(
      content: map['content']??'',
    );
  }

}
