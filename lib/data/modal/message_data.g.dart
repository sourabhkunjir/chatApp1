// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MessageData _$MessageDataFromJson(Map<String, dynamic> json) => MessageData(
      message: json['message'] as String?,
      senderId: json['senderId'] as String?,
      recieverId: json['recieverId'] as String?,
      timeStamp: json['timeStamp'] as String?,
      type: json['type'] as String?,
    );

Map<String, dynamic> _$MessageDataToJson(MessageData instance) =>
    <String, dynamic>{
      'message': instance.message,
      'senderId': instance.senderId,
      'recieverId': instance.recieverId,
      'timeStamp': instance.timeStamp,
      'type': instance.type,
    };
