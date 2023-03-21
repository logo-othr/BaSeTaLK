import 'dart:io';

extension FileExtension on FileSystemEntity {
  String get filename {
    return this?.path?.split("/")?.last;
  }
}
