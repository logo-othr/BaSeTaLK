import 'package:json_annotation/json_annotation.dart';

part 'sftp_auth.g.dart';

@JsonSerializable()
class SFTPAuth {
  String host;
  String port;
  String username;
  String passwordOrKey;

  SFTPAuth(this.host, this.port, this.username, this.passwordOrKey);

  factory SFTPAuth.fromJson(Map<String, dynamic> json) =>
      _$SFTPAuthFromJson(json);

  Map<String, dynamic> toJson() => _$SFTPAuthToJson(this);
}
