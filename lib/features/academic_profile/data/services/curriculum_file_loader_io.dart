// Signature: dev.tswicolly03

import 'dart:io';
import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';

Future<Uint8List> readCurriculumFileBytesImpl(PlatformFile file) async {
  final path = file.path;
  if (path != null && path.isNotEmpty) {
    return File(path).readAsBytes();
  }

  final bytes = file.bytes;
  if (bytes != null && bytes.isNotEmpty) {
    return bytes;
  }

  throw const FileSystemException(
    'Nao foi possivel acessar o arquivo selecionado.',
  );
}
