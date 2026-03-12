// Signature: dev.tswicolly03

import 'dart:io';

import 'package:open_filex/open_filex.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';

import 'attachment_file_result.dart';

Future<AttachmentOpenResult> openPlatformAttachmentBytes({
  required String fileName,
  required List<int> bytes,
  String? mimeType,
}) async {
  try {
    final directory = await getTemporaryDirectory();
    final safeName = path.basename(fileName);
    final targetDirectory = Directory(path.join(directory.path, 'attachments'));
    if (!await targetDirectory.exists()) {
      await targetDirectory.create(recursive: true);
    }

    final filePath = path.join(
      targetDirectory.path,
      '${DateTime.now().millisecondsSinceEpoch}_$safeName',
    );
    final file = File(filePath);
    await file.writeAsBytes(bytes, flush: true);

    final result = await OpenFilex.open(file.path);
    return AttachmentOpenResult(
      success: result.type == ResultType.done,
      message: result.type == ResultType.done
          ? 'Arquivo aberto no app padrao do sistema.'
          : (result.message.isEmpty
              ? 'Nao foi possivel abrir o arquivo.'
              : result.message),
    );
  } catch (_) {
    return const AttachmentOpenResult(
      success: false,
      message: 'Nao foi possivel abrir o arquivo.',
    );
  }
}
