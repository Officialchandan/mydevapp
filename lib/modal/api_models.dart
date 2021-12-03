import 'dart:convert';

DataFormUser dataFormUserFromJson(String str) =>
    DataFormUser.fromJson(json.decode(str));

String dataFormUserToJson(DataFormUser data) => json.encode(data.toJson());

class DataFormUser {
  DataFormUser({
    this.data,
  });

  Data? data;

  factory DataFormUser.fromJson(Map<String, dynamic> json) => DataFormUser(
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "data": data!.toJson(),
      };
}

class Data {
  Data({
    this.profilePic,
    this.name,
    this.emailId,
  });

  String? profilePic;
  String? name;
  String? emailId;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        profilePic: json["profile_pic"],
        name: json["name"],
        emailId: json["email_id"],
      );

  Map<String, dynamic> toJson() => {
        "profile_pic": profilePic,
        "name": name,
        "email_id": emailId,
      };
}
