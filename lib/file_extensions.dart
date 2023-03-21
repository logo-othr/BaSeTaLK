import 'dart:io';

extension FileExtention on FileSystemEntity {
  String get filename {
    return this?.path?.split("/")?.last;
  }
}
