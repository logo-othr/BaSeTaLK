import 'dart:io';

import 'package:basetalk/file_extensions.dart';
import 'package:path/path.dart' as p;

class Media {
  final File file;

  Media(this.file);

  String get filename => file.name;

  String get extension => p.extension(file.path);
}
