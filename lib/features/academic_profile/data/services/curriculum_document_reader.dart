// Signature: dev.tswicolly03

import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';

final curriculumDocumentReaderProvider = Provider<CurriculumDocumentReader>(
  (ref) => const CurriculumDocumentReader(),
);

class CurriculumDocumentReader {
  const CurriculumDocumentReader();

  Future<String> extractText({
    required Uint8List bytes,
    required String fileName,
  }) async {
    final extension = _extensionOf(fileName);
    if (extension == 'pdf') {
      return compute(
        _extractPdfTextInBackground,
        bytes,
        debugLabel: 'curriculum-pdf-reader',
      );
    }

    return _decodeText(bytes);
  }

  String _decodeText(List<int> bytes) {
    try {
      return const Utf8Decoder(allowMalformed: true).convert(bytes);
    } catch (_) {
      return latin1.decode(bytes, allowInvalid: true);
    }
  }

  String _extensionOf(String fileName) {
    final dotIndex = fileName.lastIndexOf('.');
    if (dotIndex == -1 || dotIndex == fileName.length - 1) {
      return '';
    }
    return fileName.substring(dotIndex + 1).toLowerCase();
  }
}

String _extractPdfTextInBackground(Uint8List bytes) {
  final document = PdfDocument(inputBytes: bytes);
  try {
    final extractor = PdfTextExtractor(document);
    final pageCount = document.pages.count;
    final firstChunkEnd = pageCount <= 40 ? pageCount - 1 : 39;
    final firstChunk = extractor.extractText(
      startPageIndex: 0,
      endPageIndex: firstChunkEnd,
    );
    if (_hasEnoughCurriculumSignals(firstChunk) || pageCount <= 40) {
      return firstChunk;
    }

    final secondChunkEnd = pageCount <= 70 ? pageCount - 1 : 69;
    final secondChunk = extractor.extractText(
      startPageIndex: 0,
      endPageIndex: secondChunkEnd,
    );
    if (_hasEnoughCurriculumSignals(secondChunk) || pageCount <= 70) {
      return secondChunk;
    }

    return extractor.extractText();
  } finally {
    document.dispose();
  }
}

bool _hasEnoughCurriculumSignals(String text) {
  if (_shouldUseExpandedCurriculumSignals(text)) {
    final normalized = _normalizeForSignals(text);
    final hasMatrixAnchor =
        normalized.contains('matriz curricular') ||
        normalized.contains('estrutura curricular') ||
        normalized.contains('quadro dos componentes curriculares');
    final hasAcademicLoad =
        normalized.contains('carga horaria total') ||
        normalized.contains('carga horaria obrigatoria') ||
        normalized.contains('pre-requisito');
    final hasRows =
        normalized.contains('disciplinas obrigatorias') ||
        normalized.contains('disciplinas optativas') ||
        normalized.contains('1o periodo') ||
        normalized.contains('i semestre') ||
        normalized.contains('1o semestre');
    return hasMatrixAnchor && hasAcademicLoad && hasRows;
  }

  final normalized = _normalizeForSignals(text);
  return normalized.contains('matriz curricular') &&
      normalized.contains('carga horaria total') &&
      (normalized.contains('disciplinas obrigatorias') ||
          normalized.contains('disciplinas optativas'));
}

String _normalizeForSignals(String input) {
  if (_shouldUseExpandedCurriculumSignals(input)) {
    const replacements = {
      'á': 'a',
      'à': 'a',
      'â': 'a',
      'ã': 'a',
      'ä': 'a',
      'é': 'e',
      'è': 'e',
      'ê': 'e',
      'ë': 'e',
      'í': 'i',
      'ì': 'i',
      'î': 'i',
      'ï': 'i',
      'ó': 'o',
      'ò': 'o',
      'ô': 'o',
      'õ': 'o',
      'ö': 'o',
      'ú': 'u',
      'ù': 'u',
      'û': 'u',
      'ü': 'u',
      'ç': 'c',
      'ñ': 'n',
      'º': 'o',
      '°': 'o',
      'Ã¡': 'a',
      'Ã ': 'a',
      'Ã¢': 'a',
      'Ã£': 'a',
      'Ã¤': 'a',
      'Ã©': 'e',
      'Ãª': 'e',
      'Ã¨': 'e',
      'Ã­': 'i',
      'Ã¬': 'i',
      'Ã³': 'o',
      'Ã²': 'o',
      'Ã´': 'o',
      'Ãµ': 'o',
      'Ã¶': 'o',
      'Ãº': 'u',
      'Ã¹': 'u',
      'Ã¼': 'u',
      'Ã§': 'c',
      'Ã±': 'n',
      'Âº': 'o',
      'Â°': 'o',
    };

    var normalizedValue = input.toLowerCase();
    replacements.forEach((source, target) {
      normalizedValue = normalizedValue.replaceAll(source, target);
    });
    return normalizedValue.replaceAll(RegExp(r'\s+'), ' ').trim();
  }

  const replacements = {
    'a': 'áàâãä',
    'e': 'éèêë',
    'i': 'íìîï',
    'o': 'óòôõö',
    'u': 'úùûü',
    'c': 'ç',
    'n': 'ñ',
  };

  var normalized = input.toLowerCase();
  replacements.forEach((ascii, chars) {
    for (final char in chars.split('')) {
      normalized = normalized.replaceAll(char, ascii);
    }
  });
  return normalized.replaceAll(RegExp(r'\s+'), ' ').trim();
}

bool _shouldUseExpandedCurriculumSignals(String input) => true;
