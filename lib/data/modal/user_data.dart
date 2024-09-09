
import 'package:json_annotation/json_annotation.dart';

part 'user_data.g.dart';


@JsonSerializable()
class UserData {
  final String? uid;
  final String? email;
  final String? name;
  final String? createdOn;
  final String? bio;
  final String? profilePicUrl;

  UserData({
    this.uid,
    this.email,
    this.name,
    this.createdOn,
    this.bio,
    this.profilePicUrl,
  });

  factory UserData.fromJson(Map<String, dynamic> json) => _$UserDataFromJson(json);

  Map<String, dynamic> toJson() => _$UserDataToJson(this);
}

//dart run build_runner watch --delete-conflicting-outputs