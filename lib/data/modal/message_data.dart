
import 'package:json_annotation/json_annotation.dart';

part 'message_data.g.dart';  

@JsonSerializable()
class MessageData {
  final String? message;
  final String? senderId;
  final String? recieverId;
  final String? timeStamp;
  final String? type;

  MessageData({
    this.message,
    this.senderId,
    this.recieverId,
    this.timeStamp,
    this.type,
  });
  factory MessageData.fromJson(Map<String, dynamic> json) => _$MessageDataFromJson(json);

  Map<String, dynamic> toJson() => _$MessageDataToJson(this);
}
