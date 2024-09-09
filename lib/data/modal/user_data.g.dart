// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserData _$UserDataFromJson(Map<String, dynamic> json) => UserData(
      uid: json['uid'] as String?,
      email: json['email'] as String?,
      name: json['name'] as String?,
      createdOn: json['createdOn'] as String?,
      bio: json['bio'] as String?,
      profilePicUrl: json['profilePicUrl'] as String?,
    );

Map<String, dynamic> _$UserDataToJson(UserData instance) => <String, dynamic>{
      'uid': instance.uid,
      'email': instance.email,
      'name': instance.name,
      'createdOn': instance.createdOn,
      'bio': instance.bio,
      'profilePicUrl': instance.profilePicUrl,
    };
