// Signature: dev.tswicolly03

import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';

Future<Uint8List> readCurriculumFileBytesImpl(PlatformFile file) async {
  final bytes = file.bytes;
  if (bytes != null && bytes.isNotEmpty) {
    return bytes;
  }

  throw UnsupportedError(
    'A plataforma atual nao disponibiliza leitura de arquivo para importacao.',
  );
}
