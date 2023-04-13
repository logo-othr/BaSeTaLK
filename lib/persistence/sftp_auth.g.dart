// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sftp_auth.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SFTPAuth _$SFTPAuthFromJson(Map<String, dynamic> json) {
  return SFTPAuth(
    json['host'] as String,
    json['port'] as String,
    json['username'] as String,
    json['passwordOrKey'] as String,
  );
}

Map<String, dynamic> _$SFTPAuthToJson(SFTPAuth instance) => <String, dynamic>{
      'host': instance.host,
      'port': instance.port,
      'username': instance.username,
      'passwordOrKey': instance.passwordOrKey,
    };
