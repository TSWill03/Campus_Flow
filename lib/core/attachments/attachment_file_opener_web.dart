// ignore_for_file: avoid_web_libraries_in_flutter, deprecated_member_use

import 'dart:html' as html;
import 'dart:typed_data';

import 'attachment_file_result.dart';

Future<AttachmentOpenResult> openPlatformAttachmentBytes({
  required String fileName,
  required List<int> bytes,
  String? mimeType,
}) async {
  final blob = html.Blob(
    [Uint8List.fromList(bytes)],
    mimeType ?? 'application/octet-stream',
  );
  final url = html.Url.createObjectUrlFromBlob(blob);
  html.window.open(url, '_blank');

  return const AttachmentOpenResult(
    success: true,
    message: 'Arquivo aberto ou enviado para download pelo navegador.',
  );
}
