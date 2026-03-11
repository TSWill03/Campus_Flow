import 'attachment_file_opener_stub.dart'
    if (dart.library.html) 'attachment_file_opener_web.dart'
    if (dart.library.io) 'attachment_file_opener_io.dart';
import 'attachment_file_result.dart';

Future<AttachmentOpenResult> openAttachmentBytes({
  required String fileName,
  required List<int> bytes,
  String? mimeType,
}) {
  return openPlatformAttachmentBytes(
    fileName: fileName,
    bytes: bytes,
    mimeType: mimeType,
  );
}
