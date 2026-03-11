import 'attachment_file_result.dart';

Future<AttachmentOpenResult> openPlatformAttachmentBytes({
  required String fileName,
  required List<int> bytes,
  String? mimeType,
}) async {
  return const AttachmentOpenResult(
    success: false,
    message: 'Visualizacao de arquivos nao suportada nesta plataforma.',
  );
}
