class MessageModel {
  final String content;
  final DateTime sendDate;

  MessageModel({this.content = '', DateTime? sendDate})
      : this.sendDate = sendDate ?? DateTime(1900);


}
