// Signature: dev.tswicolly03

import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';

import 'curriculum_file_loader_stub.dart'
    if (dart.library.html) 'curriculum_file_loader_web.dart'
    if (dart.library.io) 'curriculum_file_loader_io.dart';

Future<Uint8List> readCurriculumFileBytes(PlatformFile file) {
  return readCurriculumFileBytesImpl(file);
}
