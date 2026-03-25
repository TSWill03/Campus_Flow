// Signature: dev.tswicolly03

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/utils/id_generator.dart';
import '../../../../shared/enums/app_enums.dart';
import '../../domain/entities/curriculum_import_preview.dart';
import '../../domain/entities/curriculum_import_subject_draft.dart';

final curriculumImportParserProvider = Provider<CurriculumImportParser>(
  (ref) => const CurriculumImportParser(),
);

class CurriculumImportParser {
  const CurriculumImportParser();

  CurriculumImportPreview parse(String rawText) {
    _cleanRawText(rawText);
    final cleanedText = _cleanRawTextV2(rawText);
    final lines = cleanedText
        .split(RegExp(r'\r?\n'))
        .map(_cleanLine)
        .where((line) => line.isNotEmpty)
        .toList();
    final compactText = _compactText(cleanedText);
    final compactNormalized = _normalize(compactText);
    final curriculumWindows = _extractCurriculumWindows(lines);
    final curriculumWindowTexts = curriculumWindows
        .map((window) => window.join('\n'))
        .toList();

    final mandatorySection = _extractSection(
      compactText,
      compactNormalized,
      startNeedles: const [
        '1.1- matriz curricular de disciplinas obrigatorias',
        '1.1- matriz curricular',
        'matriz curricular de disciplinas obrigatorias',
      ],
      endNeedles: const ['1.2- disciplinas optativas', 'disciplinas optativas'],
    );
    final optativeSection = _extractSection(
      compactText,
      compactNormalized,
      startNeedles: const [
        '1.2- disciplinas optativas',
        'disciplinas optativas',
      ],
      endNeedles: const [
        '1.3- ementa',
        '1.4 - conteudos curriculares',
        'anexo i',
      ],
    );

    final tabularSubjectRows = [
      ..._extractTabularSubjects(mandatorySection),
      ..._extractTabularSubjects(
        optativeSection,
        forcedType: CourseSubjectType.elective,
      ),
      ..._extractStructuredSubjects(
        fullCompactText: compactText,
        curriculumWindows: curriculumWindows,
        curriculumWindowTexts: curriculumWindowTexts,
      ),
    ];
    final syllabusByNormalizedName = _extractSubjectSyllabusByNormalizedName(
      cleanedText,
    );
    final focusedLines = curriculumWindows.expand((window) => window).toList();
    final extractedSubjects =
        tabularSubjectRows.isNotEmpty
            ? _resolveTabularPrerequisites(tabularSubjectRows)
            : _mergeSubjects(
                _extractLineBasedSubjects(
                  focusedLines.isNotEmpty ? focusedLines : lines,
                ),
              );
    final subjects = _attachSyllabi(
      extractedSubjects.isNotEmpty
          ? extractedSubjects
          : _mergeSubjects(_extractLineBasedSubjects(lines)),
      syllabusByNormalizedName,
    );

    final institution =
        _extractInstitution(lines, compactText, compactNormalized) ?? '';
    final courseName =
        _extractCourseName(lines, compactText, compactNormalized) ?? '';
    final schoolName = _extractSchoolName(
      lines,
      compactText,
      compactNormalized,
    );
    final campus = _extractCampus(lines, compactText, compactNormalized);
    final degreeLabel = _extractDegreeLabel(
      lines,
      compactText,
      compactNormalized,
      courseName,
    );

    final totalCourseHours =
        _extractTotalCourseHours(compactNormalized) ??
        subjects.fold<int>(0, (sum, item) => sum + item.workloadHours);
    final complementaryHours =
        _extractComplementaryHours(compactNormalized) ?? 0;
    final extensionHours =
        _extractExtensionHours(compactNormalized) ??
        _sumHoursByType(subjects, CourseSubjectType.extension);
    final internshipHours =
        _extractInternshipHours(compactNormalized) ??
        _sumHoursByType(subjects, CourseSubjectType.internship);
    final semesterCount =
        _extractSemesterCount(compactNormalized) ??
        _maxSuggestedSemester(subjects) ??
        0;

    final notes = _buildParserNotes(
      subjects: subjects,
      totalCourseHours: totalCourseHours,
      semesterCount: semesterCount,
      institution: institution,
      courseName: courseName,
      compactNormalized: compactNormalized,
    );

    return CurriculumImportPreview(
      profileName: _buildProfileName(
        courseName: courseName,
        institution: institution,
      ),
      courseName: courseName,
      institution: institution,
      schoolName: schoolName,
      campus: campus,
      degreeLabel: degreeLabel,
      totalCourseHours: totalCourseHours,
      semesterCount: semesterCount,
      requiredComplementaryHours: complementaryHours,
      requiredInternshipHours: internshipHours,
      requiredExtensionHours: extensionHours,
      subjects: subjects,
      notes: notes,
      makeActive: true,
    );
  }

  String _cleanRawText(String rawText) {
    var normalized = rawText.replaceAll('\u00A0', ' ');
    normalized = normalized.replaceAll('\t', ' ');
    normalized = normalized.replaceAll(RegExp(r'<[^>]+>'), ' ');
    normalized = normalized.replaceAll(
      RegExp(r'&nbsp;', caseSensitive: false),
      ' ',
    );
    normalized = normalized.replaceAll(
      RegExp(r'&amp;', caseSensitive: false),
      '&',
    );
    normalized = normalized.replaceAll(
      RegExp(r'(?<=[a-záéíóúàèìòùâêîôûãõç])(?=[A-ZÁÉÍÓÚÀÈÌÒÙÂÊÎÔÛÃÕÇ])'),
      ' ',
    );
    normalized = _repairSplitWords(normalized);
    return normalized;
  }

  String _cleanRawTextV2(String rawText) {
    var normalized = _repairMojibake(rawText).replaceAll('\u00A0', ' ');
    normalized = normalized.replaceAll('\t', ' ');
    normalized = normalized.replaceAll(RegExp(r'<[^>]+>'), ' ');
    normalized = normalized.replaceAll(
      RegExp(r'&nbsp;', caseSensitive: false),
      ' ',
    );
    normalized = normalized.replaceAll(
      RegExp(r'&amp;', caseSensitive: false),
      '&',
    );
    normalized = normalized.replaceAllMapped(
      RegExp(r'(?<=[A-Za-zÀ-ÖØ-öø-ÿ])(?=[A-ZÀ-ÖØ-Þ][a-zà-öø-ÿ])'),
      (match) => ' ',
    );
    normalized = _repairSplitWords(normalized);
    return normalized;
  }

  String _compactText(String value) {
    return value.replaceAll(RegExp(r'\s+'), ' ').trim();
  }

  String _cleanLine(String line) {
    var value = line.trim();
    value = value.replaceAll(RegExp(r'^[\-\*\u2022\uf0b7]+\s*'), '');
    value = value.replaceAll(RegExp(r'\s+'), ' ');
    value = value.replaceAll(' ,', ',');
    value = value.replaceAll(' ;', ';');
    value = _repairSplitWords(value);
    return value.trim();
  }

  List<List<String>> _extractCurriculumWindows(List<String> lines) {
    if (lines.isEmpty) {
      return const [];
    }

    const startNeedles = [
      'anexo i estrutura curricular',
      'anexo i',
      'estrutura curricular',
      'matriz curricular',
      'organizacao da matriz curricular',
      'organizacao da matriz curricular',
      'quadro dos componentes curriculares',
      'matriz curricular do curso',
      '6.1 matriz curricular',
      '5.1.1 matriz curricular',
      '5.1.2 matriz curricular',
    ];
    const endNeedles = [
      'anexo ii',
      'bibliografia',
      'referencias',
      'politica e gestao do estagio',
      'trabalho de conclusao',
      'sistema de avaliacao',
      'fluxograma de formacao',
      'componentes da estrutura curricular',
      '6.2 sugestao de fluxo',
      '6.3 atividades complementares',
      '7 politica e gestao',
      '5.1.3 fluxograma',
    ];

    final candidates = <_ScoredLineWindow>[];
    for (var index = 0; index < lines.length; index++) {
      final normalizedLine = _normalize(lines[index]);
      if (!startNeedles.any(normalizedLine.contains)) {
        continue;
      }

      final endIndex = _findCurriculumWindowEnd(
        lines,
        startIndex: index,
        endNeedles: endNeedles,
      );
      final window = lines.sublist(index, endIndex);
      final score = _scoreCurriculumWindow(window);
      if (score <= 0) {
        continue;
      }
      candidates.add(
        _ScoredLineWindow(start: index, end: endIndex, score: score),
      );
    }

    candidates.sort((a, b) => b.score.compareTo(a.score));

    final selected = <_ScoredLineWindow>[];
    for (final candidate in candidates) {
      if (candidate.score < 6) {
        continue;
      }
      final overlapsExisting = selected.any(
        (existing) =>
            candidate.start <= existing.end && candidate.end >= existing.start,
      );
      if (!overlapsExisting) {
        selected.add(candidate);
      }
      if (selected.length == 3) {
        break;
      }
    }

    return selected
        .map((candidate) => lines.sublist(candidate.start, candidate.end))
        .toList();
  }

  int _findCurriculumWindowEnd(
    List<String> lines, {
    required int startIndex,
    required List<String> endNeedles,
  }) {
    final maxEnd = (startIndex + 220).clamp(0, lines.length);
    for (var index = startIndex + 3; index < maxEnd; index++) {
      final normalized = _normalize(lines[index]);
      if (endNeedles.any(normalized.contains)) {
        return index;
      }
    }
    return maxEnd;
  }

  int _scoreCurriculumWindow(List<String> window) {
    var score = 0;
    for (final line in window.take(160)) {
      final normalized = _normalize(line);
      if (normalized.contains('sumario')) {
        score -= 10;
      }
      if (normalized.contains('bibliografia') ||
          normalized.contains('referencias') ||
          normalized.contains('perfil do egresso')) {
        score -= 4;
      }
      if (_looksLikeSemesterHeader(line)) {
        score += 5;
      }
      if (normalized.contains('matriz curricular') ||
          normalized.contains('estrutura curricular') ||
          normalized.contains('componente curricular')) {
        score += 3;
      }
      if (normalized.contains('pre-requisito') ||
          normalized.contains('codigo') ||
          normalized.contains('carga horaria')) {
        score += 2;
      }
      if (_looksLikeLawSubjectRow(line) ||
          _looksLikePedagogySubjectRow(line) ||
          _looksLikeAdsSubjectRow(line) ||
          _looksLikeAdmSubjectRow(line) ||
          _looksLikeAgronomySubjectRow(line)) {
        score += 6;
      }
    }
    return score;
  }

  List<_TabularSubjectRow> _extractStructuredSubjects({
    required String fullCompactText,
    required List<List<String>> curriculumWindows,
    required List<String> curriculumWindowTexts,
  }) {
    _keepLegacyStructuredParsersReferenced();
    final sectionTexts = <String>[
      ...curriculumWindowTexts,
      ..._extractAnchoredCompactSections(fullCompactText),
    ];
    final rows = <_TabularSubjectRow>[
      for (final section in sectionTexts) ..._extractAdsStyleSubjectsFromSection(section),
      for (final section in sectionTexts) ..._extractAdmStyleSubjectsFromSection(section),
      for (final section in sectionTexts) ..._extractPedagogyStyleSubjectsFromSection(section),
      for (final section in sectionTexts) ..._extractAgronomyStyleSubjects(section),
      for (final window in curriculumWindows) ..._extractLawStyleSubjects(window),
      for (final window in curriculumWindows) ..._extractAdmStyleSubjects(window),
    ];

    final deduped = <_TabularSubjectRow>[];
    final seen = <String>{};
    for (final row in rows) {
      final key =
          '${_normalizedSubjectLookupKey(row.draft.name)}|${row.draft.suggestedSemester ?? 0}';
      if (seen.add(key)) {
        deduped.add(row);
      }
    }
    return deduped;
  }

  void _keepLegacyStructuredParsersReferenced() {
    _extractPedagogyStyleSubjects(const <String>[]);
    _extractAdsStyleSubjects(const <String>[]);
  }

  List<String> _extractAnchoredCompactSections(String fullCompactText) {
    final normalizedText = _normalize(fullCompactText);
    const startNeedles = [
      'anexo i estrutura curricular',
      '5.1.1 matriz curricular',
      '5.1.2 matriz curricular',
      'quadro 6',
      'quadro 7',
      '6.1 matriz curricular',
      'matriz curricular',
      'estrutura curricular',
      'quadro dos componentes curriculares',
    ];

    final sections = <String>[];
    final consumedRanges = <_ScoredLineWindow>[];
    for (final needle in startNeedles) {
      var searchStart = 0;
      final normalizedNeedle = _normalize(needle);
      while (true) {
        final index = normalizedText.indexOf(normalizedNeedle, searchStart);
        if (index == -1) {
          break;
        }
        final end = (index + 18000).clamp(0, fullCompactText.length);
        final overlapsExisting = consumedRanges.any(
          (range) => index <= range.end && end >= range.start,
        );
        if (!overlapsExisting) {
          sections.add(fullCompactText.substring(index, end));
          consumedRanges.add(_ScoredLineWindow(start: index, end: end, score: 0));
        }
        searchStart = index + normalizedNeedle.length;
        if (sections.length >= 4) {
          return sections;
        }
      }
    }
    return sections;
  }

  List<_TabularSubjectRow> _extractTabularSubjects(
    String section, {
    CourseSubjectType? forcedType,
  }) {
    if (section.isEmpty) {
      return const [];
    }

    final compactSection = _compactText(section);
    final normalizedSection = _normalize(compactSection);
    final looksLikeIfGoianoMatrix =
        normalizedSection.contains(' nc ') ||
        normalizedSection.contains(' ne ') ||
        normalizedSection.contains(' cb ') ||
        normalizedSection.contains(' csp ') ||
        normalizedSection.contains(' o ') ||
        RegExp(
          r'\d+\s+(?:-|[\d,\s]+)\s+.+?\s+(?:nc|ne|cb|csp|o)\s+\d{1,3}\s+\d{1,3}\s+\d{1,3}\s+\d{1,3}',
          caseSensitive: false,
        ).hasMatch(normalizedSection);
    if (!looksLikeIfGoianoMatrix) {
      return const [];
    }

    final semesterRegex = RegExp(
      r'(primeiro|segundo|terceiro|quarto|quinto|sexto|setimo|sétimo|oitavo|\d{1,2}\s*(?:o|º|°)?)\s+periodo',
      caseSensitive: false,
    );
    final semesterMatches = semesterRegex
        .allMatches(normalizedSection)
        .toList();

    if (semesterMatches.isEmpty) {
      return _extractRowsFromSegment(
        compactSection,
        forcedSemester: null,
        forcedType: forcedType,
      );
    }

    final subjects = <_TabularSubjectRow>[];
    for (var index = 0; index < semesterMatches.length; index++) {
      final current = semesterMatches[index];
      final nextStart = index + 1 < semesterMatches.length
          ? semesterMatches[index + 1].start
          : compactSection.length;
      final semester = _parseSemesterToken(current.group(1) ?? '');
      final segment = compactSection.substring(current.end, nextStart);
      subjects.addAll(
        _extractRowsFromSegment(
          segment,
          forcedSemester: semester,
          forcedType: forcedType,
        ),
      );
    }

    return subjects;
  }

  List<_TabularSubjectRow> _extractRowsFromSegment(
    String segment, {
    required int? forcedSemester,
    CourseSubjectType? forcedType,
  }) {
    final compactSegment = _compactText(segment);
    if (compactSegment.isEmpty) {
      return const [];
    }

    final prerequisiteAwareRowPattern = RegExp(
      r'(?:(?<=\s)|^)(\d+)\s+(-|[\d,\s]+)\s+(.+?)\s+(NC|NE|CB|CSP|O)\s+(\d{1,3})\s+(\d{1,3})\s+(\d{1,3})\s+(\d{1,3})(?=\s+\d+\s+(?:-|[\d,\s]+)\s+|\s+(?:PRIMEIRO|SEGUNDO|TERCEIRO|QUARTO|QUINTO|SEXTO|S[ÉE]TIMO|SETIMO|OITAVO|\d{1,2}\s*(?:o|º|°)?\s+PER[IÍ]ODO)|\s+\*|$)',
      caseSensitive: false,
    );
    final extractedRows = prerequisiteAwareRowPattern
        .allMatches(compactSegment)
        .map((match) {
          final rowNumber = int.tryParse(match.group(1) ?? '');
          final prerequisiteRowNumbers = _parsePrerequisiteRowNumbers(
            match.group(2) ?? '-',
          );
          final name = _cleanSubjectName(match.group(3) ?? '');
          final nucleus = (match.group(4) ?? '').toUpperCase();
          final type =
              forcedType ??
              _inferSubjectType(_normalize(name), nucleus: nucleus);
          return _TabularSubjectRow(
            rowNumber: rowNumber,
            prerequisiteRowNumbers: prerequisiteRowNumbers,
            draft: CurriculumImportSubjectDraft(
              localId: IdGenerator.generate(),
              name: name,
              code: null,
              workloadHours: int.tryParse(match.group(8) ?? '') ?? 0,
              suggestedSemester: forcedSemester,
              type: type,
              prerequisiteLocalIds: const <String>[],
              syllabus: null,
            ),
          );
        })
        .where((subject) => subject.draft.name.length >= 4)
        .toList();
    if (extractedRows.isNotEmpty) {
      return extractedRows;
    }

    final rowPattern = RegExp(
      r'(?:(?<=\s)|^)(\d+)\s+(?:-|[\d,\s]+)\s+(.+?)\s+(NC|NE|CB|CSP|O)\s+(\d{1,3})\s+(\d{1,3})\s+(\d{1,3})\s+(\d{1,3})(?=\s+\d+\s+(?:-|[\d,\s]+)\s+|\s+(?:PRIMEIRO|SEGUNDO|TERCEIRO|QUARTO|QUINTO|SEXTO|S[ÉE]TIMO|SETIMO|OITAVO|\d{1,2}\s*(?:o|º|°)?\s+PER[IÍ]ODO)|\s+\*|$)',
      caseSensitive: false,
    );

    return rowPattern
        .allMatches(compactSegment)
        .map((match) {
          final name = _cleanSubjectName(match.group(2) ?? '');
          final nucleus = (match.group(3) ?? '').toUpperCase();
          final type =
              forcedType ??
              _inferSubjectType(_normalize(name), nucleus: nucleus);
          return _TabularSubjectRow(
            rowNumber: int.tryParse(match.group(1) ?? ''),
            prerequisiteRowNumbers: const <int>[],
            draft: CurriculumImportSubjectDraft(
              localId: IdGenerator.generate(),
              name: name,
              code: null,
              workloadHours: int.tryParse(match.group(7) ?? '') ?? 0,
              suggestedSemester: forcedSemester,
              type: type,
              prerequisiteLocalIds: const <String>[],
              syllabus: null,
            ),
          );
        })
        .where((subject) => subject.draft.name.length >= 4)
        .toList();
  }

  List<_TabularSubjectRow> _extractLawStyleSubjects(List<String> lines) {
    final subjects = <_TabularSubjectRow>[];
    int? currentSemester;
    var currentType = CourseSubjectType.mandatory;

    for (final line in lines) {
      final normalized = _normalize(line);
      final semester = _extractSemesterFromHeader(line);
      if (semester != null && normalized.contains('semestre')) {
        currentSemester = semester;
      }
      if (normalized.contains('optativa')) {
        currentType = CourseSubjectType.elective;
      }
      if (normalized.contains('obrigatoria')) {
        currentType = CourseSubjectType.mandatory;
      }

      final match = RegExp(
        r'^(\d+(?:\+\d+)?)\s*[.\-–— ]+\s*([A-Z]{2,}\d{3,}[A-Z0-9]*)\s*[.\-–— ]+\s*(.+)$',
      ).firstMatch(line);
      if (match == null) {
        continue;
      }

      final name = _cleanSubjectName(match.group(3) ?? '');
      if (!_isLikelyImportedSubjectName(name)) {
        continue;
      }

      subjects.add(
        _TabularSubjectRow(
          draft: CurriculumImportSubjectDraft(
            localId: IdGenerator.generate(),
            name: name,
            code: match.group(2),
            workloadHours: _estimateLawRowHours(match.group(1) ?? ''),
            suggestedSemester: currentSemester,
            type: currentType,
            prerequisiteLocalIds: const <String>[],
            syllabus: null,
          ),
        ),
      );
    }

    return subjects;
  }

  List<_TabularSubjectRow> _extractPedagogyStyleSubjects(List<String> lines) {
    final subjects = <_TabularSubjectRow>[];

    for (final line in lines) {
      final match = RegExp(
        r'^(.+?)\s+[A-Z]{1,6}\s+(?:-+|[.]{3,})\s+(\d{1,3})\s+(\d{1,3})\s+(\d{1,3})\s+(Comum|Especifico|Específico|Obrigatorio|Obrigatória|Obrigatoria|Optativo|Livre)\b(?:\s+\d{1,3})?$',
        caseSensitive: false,
      ).firstMatch(line);
      if (match == null) {
        continue;
      }

      final name = _cleanSubjectName(match.group(1) ?? '');
      if (!_isLikelyImportedSubjectName(name)) {
        continue;
      }

      final normalizedTypeHint = _normalize(match.group(5) ?? '');
      final type = normalizedTypeHint.contains('optativo') ||
              normalizedTypeHint.contains('livre')
          ? CourseSubjectType.elective
          : _inferSubjectType(_normalize(name));

      subjects.add(
        _TabularSubjectRow(
          draft: CurriculumImportSubjectDraft(
            localId: IdGenerator.generate(),
            name: name,
            code: null,
            workloadHours: _parseNumber(match.group(4)) ?? 0,
            suggestedSemester: null,
            type: type,
            prerequisiteLocalIds: const <String>[],
            syllabus: null,
          ),
        ),
      );
    }

    return subjects;
  }

  List<_TabularSubjectRow> _extractAdsStyleSubjects(List<String> lines) {
    final subjects = <_TabularSubjectRow>[];
    int? currentSemester;
    var currentType = CourseSubjectType.mandatory;

    for (final line in lines) {
      final normalized = _normalize(line);
      final semesterFromHeader = _extractSemesterFromHeader(line);
      if (semesterFromHeader != null) {
        currentSemester = semesterFromHeader;
      }
      if (normalized.contains('curricularesoptativas') ||
          normalized.contains('disciplinas optativas') ||
          normalized.contains('optativas')) {
        currentType = CourseSubjectType.elective;
      } else if (normalized.contains('curricularobrigatorio') ||
          normalized.contains('obrigatorio')) {
        currentType = CourseSubjectType.mandatory;
      }

      final match = RegExp(
        r'^(?:(\d{1,2})\s*(?:o|º|°)\s+)?([A-Z]{2,}(?:\s+[IVX]+)?)\s+(.+?)\s+(\d{1,2})\s+(\d{1,3}|-)\s+(\d{1,3}|-)\s+(\d{1,3}|-)\s+(?:(\d{1,3}|-)\s+)?(?:(\d{1,3}|-)\s+)?(\d{1,3})\s+(.+)$',
        caseSensitive: false,
      ).firstMatch(line);
      if (match == null) {
        continue;
      }

      final name = _cleanSubjectName(match.group(3) ?? '');
      if (!_isLikelyImportedSubjectName(name)) {
        continue;
      }

      final prereqRaw = match.group(10)?.trim() ?? '-';
      subjects.add(
        _TabularSubjectRow(
          prerequisiteCodes: _parsePrerequisiteCodes(prereqRaw),
          draft: CurriculumImportSubjectDraft(
            localId: IdGenerator.generate(),
            name: name,
            code: match.group(2)?.trim(),
            workloadHours: _parseNumber(match.group(9)) ?? 0,
            suggestedSemester:
                _parseNumber(match.group(1)) ?? currentSemester,
            type: currentType == CourseSubjectType.elective
                ? CourseSubjectType.elective
                : _inferSubjectType(_normalize(name)),
            prerequisiteLocalIds: const <String>[],
            syllabus: null,
          ),
        ),
      );
    }

    return subjects;
  }

  List<_TabularSubjectRow> _extractAdmStyleSubjects(List<String> lines) {
    final subjects = <_TabularSubjectRow>[];
    int? currentSemester;

    for (final line in lines) {
      final semester = _extractSemesterFromHeader(line);
      if (semester != null) {
        currentSemester = semester;
      }

      final match = RegExp(
        r'^\d+\.\s+(.+?)\s+((?:\d{1,3}\s+){3,6}\d{1,3})(?:\s+[A-Z].*)?$',
      ).firstMatch(line);
      if (match == null) {
        continue;
      }

      final name = _cleanSubjectName(match.group(1) ?? '');
      if (!_isLikelyImportedSubjectName(name)) {
        continue;
      }

      final numbers = RegExp(
        r'\d{1,3}',
      ).allMatches(match.group(2) ?? '').map((item) => int.parse(item.group(0)!)).toList();
      final workloadHours = _pickWorkloadFromNumericColumns(numbers);
      if (workloadHours <= 0) {
        continue;
      }

      subjects.add(
        _TabularSubjectRow(
          draft: CurriculumImportSubjectDraft(
            localId: IdGenerator.generate(),
            name: name,
            code: null,
            workloadHours: workloadHours,
            suggestedSemester: currentSemester,
            type: _inferSubjectType(_normalize(name)),
            prerequisiteLocalIds: const <String>[],
            syllabus: null,
          ),
        ),
      );
    }

    return subjects;
  }

  List<_TabularSubjectRow> _extractAgronomyStyleSubjects(String section) {
    final compactSection = _compactText(section);
    if (compactSection.isEmpty) {
      return const [];
    }
    final normalizedSection = _normalize(compactSection);
    if (!normalizedSection.contains('co-requisito') &&
        !normalizedSection.contains('natureza') &&
        !normalizedSection.contains('curso de graduacao em agronomia')) {
      return const [];
    }

    final subjects = <_TabularSubjectRow>[];
    final matches = RegExp(
      r'(?:(?<=\s)|^)(\d{2})\s+(.+?)\s+[A-Z]{2,6}\s+(.+?)\s+-\s+(\d{2,3})\s+\d{1,3}\s+\d{1,3}\s+[A-Z]{2}\s+(Obr|Opt)(?=\s+\d{2}\s+[A-ZÁÀÂÃÉÊÍÓÔÕÚÇ]|$)',
      caseSensitive: false,
    ).allMatches(compactSection);

    for (final match in matches) {
      final name = _cleanSubjectName(match.group(2) ?? '');
      if (!_isLikelyImportedSubjectName(name)) {
        continue;
      }

      subjects.add(
        _TabularSubjectRow(
          prerequisiteNames: _parsePrerequisiteNames(match.group(3) ?? '-'),
          draft: CurriculumImportSubjectDraft(
            localId: IdGenerator.generate(),
            name: name,
            code: null,
            workloadHours: _parseNumber(match.group(4)) ?? 0,
            suggestedSemester: null,
            type: (match.group(5) ?? '').toLowerCase() == 'opt'
                ? CourseSubjectType.elective
                : _inferSubjectType(_normalize(name)),
            prerequisiteLocalIds: const <String>[],
            syllabus: null,
          ),
        ),
      );
    }

    return subjects;
  }

  List<_TabularSubjectRow> _extractAdsStyleSubjectsFromSection(String section) {
    final compactSection = _compactText(section);
    final normalizedSection = _normalize(compactSection);
    final preferCleanVariant =
        normalizedSection.contains('1 hora/aula = 60') ||
        normalizedSection.contains('matutinoouvespertino') ||
        normalizedSection.contains('quadro 6') ||
        normalizedSection.contains('quadro 7');
    final containsNightVariant =
        normalizedSection.contains('1 hora/aula = 50') ||
        normalizedSection.contains('quadro 4') ||
        normalizedSection.contains('quadro 5');
    if ((!normalizedSection.contains('analise e desenvolvimento de sistemas') &&
            !normalizedSection.contains('componente curricular')) ||
        !preferCleanVariant ||
        containsNightVariant) {
      return const [];
    }

    final subjects = <_TabularSubjectRow>[];
    final simplifiedPattern = RegExp(
      r'(?:(?<=\s)|^)([A-Z]{2,5}(?:\s+[IVX]+)?)\s+(.+?)\s+(\d{1,2})\s+(\d{1,3}|-)\s+(\d{1,3}|-)\s+(\d{1,3}|-)\s+(\d{1,3})\s+([A-Z]{2,5}(?:\s+[IVX]+)?|-)(?=\s+(?:[A-Z]{2,5}(?:\s+[IVX]+)?\s+[A-ZÁÀÂÃÉÊÍÓÔÕÚÇ]|Carga\s+Horaria\s+Parcial|Disciplinas\s+Optativas|Quadro|$))',
      caseSensitive: false,
    );
    final detailedPattern = RegExp(
      r'(?:(?<=\s)|^)([A-Z]{2,5}(?:\s+[IVX]+)?)\s+(.+?)\s+(\d{1,2})\s+(\d{1,3}|-)\s+(\d{1,3}|-)\s+(\d{1,3}|-)\s+(\d{1,3}|-)\s+(\d{1,3})\s+([A-Z]{2,5}(?:\s+[IVX]+)?|-)(?=\s+(?:[A-Z]{2,5}(?:\s+[IVX]+)?\s+[A-ZÁÀÂÃÉÊÍÓÔÕÚÇ]|Carga\s+Horaria\s+Parcial|Disciplinas\s+Optativas|Quadro|$))',
      caseSensitive: false,
    );
    const rowPattern = null;
    if (_shouldKeepLegacyRegex(compactSection)) {
      detailedPattern.allMatches('');
      rowPattern;
    }

    for (final segment in _splitSectionBySemester(compactSection)) {
      final type = _normalize(segment.text).contains('optativa')
          ? CourseSubjectType.elective
          : CourseSubjectType.mandatory;
      final matches = simplifiedPattern.allMatches(segment.text);

      for (final match in matches) {
        final name = _cleanSubjectName(match.group(2) ?? '');
        if (!_isLikelyImportedSubjectName(name)) {
          continue;
        }
        final workloadHours = _parseNumber(match.group(match.groupCount - 1)) ?? 0;
        if (workloadHours <= 0) {
          continue;
        }

        subjects.add(
          _TabularSubjectRow(
            prerequisiteCodes: _parsePrerequisiteCodes(match.group(match.groupCount) ?? '-'),
            draft: CurriculumImportSubjectDraft(
              localId: IdGenerator.generate(),
              name: name,
              code: match.group(1)?.trim(),
              workloadHours: workloadHours,
              suggestedSemester: segment.semester,
              type: type == CourseSubjectType.elective
                  ? CourseSubjectType.elective
                  : _inferSubjectType(_normalize(name)),
              prerequisiteLocalIds: const <String>[],
              syllabus: null,
            ),
          ),
        );
      }
    }

    return subjects;
  }

  List<_TabularSubjectRow> _extractAdmStyleSubjectsFromSection(String section) {
    final compactSection = _compactText(section);
    final normalizedSection = _normalize(compactSection);
    if (!normalizedSection.contains('matriz curricular curso de') &&
        !normalizedSection.contains('praticas extensionista')) {
      return const [];
    }

    final subjects = <_TabularSubjectRow>[];
    for (final segment in _splitSectionBySemester(compactSection)) {
      final matches = RegExp(
        r'(?:(?<=\s)|^)\d+\.\s+(.+?)\s+(\d{1,2})\s+(\d{1,3})\s+(\d{1,3})\s+(?:AACC|\d{1,3})\s+(\d{1,3})(?:\s+(\d{1,3}))?(?=\s+\d+\.\s+|\s+TOTAL|\s+\d{1,2}\s*(?:o|º|°)\s*PER[IÍ]ODO|$)',
        caseSensitive: false,
      ).allMatches(segment.text);

      for (final match in matches) {
        final name = _cleanSubjectName(match.group(1) ?? '');
        if (!_isLikelyImportedSubjectName(name)) {
          continue;
        }

        subjects.add(
          _TabularSubjectRow(
            draft: CurriculumImportSubjectDraft(
              localId: IdGenerator.generate(),
              name: name,
              code: null,
              workloadHours: _parseNumber(match.group(3)) ?? 0,
              suggestedSemester: segment.semester,
              type: _inferSubjectType(_normalize(name)),
              prerequisiteLocalIds: const <String>[],
              syllabus: null,
            ),
          ),
        );
      }
    }

    return subjects;
  }

  List<_TabularSubjectRow> _extractPedagogyStyleSubjectsFromSection(
    String section,
  ) {
    final compactSection = _compactText(section);
    final normalizedSection = _normalize(compactSection);
    if (!normalizedSection.contains('nucleo comum e especifico') &&
        !normalizedSection.contains('disciplina unidade respons')) {
      return const [];
    }

    final subjects = <_TabularSubjectRow>[];
    final matches = RegExp(
      r'(?:(?<=\s)|^)([A-ZÁÀÂÃÉÊÍÓÔÕÚÇ][^0-9]{4,}?)\s+[A-Z]{1,6}\s+(?:-+\s+){1,3}(\d{1,3})\s+(\d{1,3})\s+(\d{1,3})\s+(Comum|Especifico|Específico|Obrigatorio|Obrigatoria|Obrigatória|Optativo|Livre)\s+(\d{1,3})',
      caseSensitive: false,
    ).allMatches(compactSection);

    for (final match in matches) {
      final name = _cleanSubjectName(match.group(1) ?? '');
      if (!_isLikelyImportedSubjectName(name)) {
        continue;
      }

      final typeHint = _normalize(match.group(5) ?? '');
      subjects.add(
        _TabularSubjectRow(
          draft: CurriculumImportSubjectDraft(
            localId: IdGenerator.generate(),
            name: name,
            code: null,
            workloadHours: _parseNumber(match.group(4)) ?? 0,
            suggestedSemester: null,
            type: typeHint.contains('optativo') || typeHint.contains('livre')
                ? CourseSubjectType.elective
                : _inferSubjectType(_normalize(name)),
            prerequisiteLocalIds: const <String>[],
            syllabus: null,
          ),
        ),
      );
    }

    return subjects;
  }

  List<_SemesterSection> _splitSectionBySemester(String section) {
    final compactSection = _compactText(section);
    final headerPattern = RegExp(
      r'(?:^|\s)((?:\d{1,2}\s*(?:o|º|°)?|[IVXLCDM]+|primeiro|segundo|terceiro|quarto|quinto|sexto|setimo|sétimo|oitavo|nono|decimo)\s*(?:PER[IÍ]ODO|SEMESTRE))',
      caseSensitive: false,
    );
    final matches = headerPattern.allMatches(compactSection).toList();
    if (matches.isEmpty) {
      return [_SemesterSection(semester: null, text: section)];
    }

    final sections = <_SemesterSection>[];
    for (var index = 0; index < matches.length; index++) {
      final current = matches[index];
      final nextStart = index + 1 < matches.length
          ? matches[index + 1].start
          : compactSection.length;
      final semesterToken = current.group(1) ?? '';
      sections.add(
        _SemesterSection(
          semester: _extractSemesterFromHeader(semesterToken),
          text: compactSection.substring(current.end, nextStart).trim(),
        ),
      );
    }
    return sections;
  }

  List<CurriculumImportSubjectDraft> _resolveTabularPrerequisites(
    List<_TabularSubjectRow> rows,
  ) {
    final localIdByRowNumber = <int, String>{
      for (final row in rows)
        if (row.rowNumber != null) row.rowNumber!: row.draft.localId,
    };
    final localIdByCode = <String, String>{
      for (final row in rows)
        if (row.draft.code != null && row.draft.code!.trim().isNotEmpty)
          _normalizedSubjectLookupKey(row.draft.code!): row.draft.localId,
    };
    final localIdByName = <String, String>{
      for (final row in rows) _normalizedSubjectLookupKey(row.draft.name): row.draft.localId,
    };

    return rows
        .map((row) {
          final prerequisiteIds = <String>{
            ...row.prerequisiteRowNumbers
                .map((value) => localIdByRowNumber[value])
                .whereType<String>(),
            ...row.prerequisiteCodes
                .map((value) => localIdByCode[_normalizedSubjectLookupKey(value)])
                .whereType<String>(),
            ...row.prerequisiteNames
                .map((value) => localIdByName[_normalizedSubjectLookupKey(value)])
                .whereType<String>(),
          };

          prerequisiteIds.remove(row.draft.localId);
          return row.draft.copyWith(
            prerequisiteLocalIds: prerequisiteIds.toList(),
          );
        })
        .toList();
  }

  List<int> _parsePrerequisiteRowNumbers(String rawValue) {
    final trimmed = rawValue.trim();
    if (trimmed.isEmpty || trimmed == '-') {
      return const <int>[];
    }

    return trimmed
        .split(',')
        .map((token) => int.tryParse(token.trim()))
        .whereType<int>()
        .toList();
  }

  List<String> _parsePrerequisiteCodes(String rawValue) {
    final trimmed = rawValue.trim();
    if (trimmed.isEmpty || trimmed == '-') {
      return const <String>[];
    }

    return trimmed
        .split(RegExp(r'[,;/]'))
        .map((token) => _cleanSubjectName(token))
        .where((token) => token.isNotEmpty && token != '-')
        .toList();
  }

  List<String> _parsePrerequisiteNames(String rawValue) {
    final trimmed = rawValue.trim();
    if (trimmed.isEmpty || trimmed == '-') {
      return const <String>[];
    }

    return trimmed
        .split(';')
        .map((token) => _cleanSubjectName(token))
        .where(_isLikelyImportedSubjectName)
        .toList();
  }

  bool _looksLikeLawSubjectRow(String line) {
    return RegExp(
      r'^\d+(?:\+\d+)?\s*[.\-–— ]+\s*[A-Z]{2,}\d{3,}[A-Z0-9]*\s*[.\-–— ]+\s*.+$',
    ).hasMatch(line);
  }

  bool _looksLikePedagogySubjectRow(String line) {
    return RegExp(
      r'^.+\s+[A-Z]{1,6}\s+(?:-+|[.]{3,})\s+\d{1,3}\s+\d{1,3}\s+\d{1,3}\s+(Comum|Especifico|Específico|Optativo|Livre)\b',
      caseSensitive: false,
    ).hasMatch(line);
  }

  bool _looksLikeAdsSubjectRow(String line) {
    return RegExp(
      r'^(?:(\d{1,2})\s*(?:o|º|°)\s+)?[A-Z]{2,}(?:\s+[IVX]+)?\s+.+\s+\d{1,2}\s+(\d{1,3}|-)\s+(\d{1,3}|-)\s+(\d{1,3}|-)',
      caseSensitive: false,
    ).hasMatch(line);
  }

  bool _looksLikeAdmSubjectRow(String line) {
    return RegExp(r'^\d+\.\s+.+\s+(?:\d{1,3}\s+){3,6}\d{1,3}$').hasMatch(line);
  }

  bool _looksLikeAgronomySubjectRow(String line) {
    return RegExp(
      r'^\d{2}\s+.+\s+[A-Z]{2,6}\s+.+\s+-\s+\d{2,3}\s+\d{1,3}\s+\d{1,3}\s+[A-Z]{2}\s+(Obr|Opt)$',
      caseSensitive: false,
    ).hasMatch(line);
  }

  bool _isLikelyImportedSubjectName(String value) {
    final cleaned = _cleanSubjectName(value);
    if (cleaned.length < 4 || cleaned.length > 140) {
      return false;
    }

    final normalized = _normalize(cleaned);
    if (_isMetadataLine(normalized) || _looksLikeMetadataName(normalized)) {
      return false;
    }

    const blockedFragments = [
      'sumario',
      'bibliografia',
      'referencia',
      'carga horaria parcial',
      'carga horaria total',
      'componentes curriculares',
      'matriz curricular',
      'estrutura curricular',
      'quadro ',
      'figura ',
      'anexo ',
      'curricularobrigatorio',
      'curricularesoptativas',
      'disciplina unidade respons',
      'pre-requisito',
      'codigo',
      'campus',
      'universidade',
      'faculdade',
      'coordenador',
      'respons.',
    ];
    if (blockedFragments.any(normalized.contains)) {
      return false;
    }

    final letters = RegExp(r'[A-Za-zÀ-ÖØ-öø-ÿ]').allMatches(cleaned).length;
    final digits = RegExp(r'\d').allMatches(cleaned).length;
    if (letters < 4 || digits > letters) {
      return false;
    }

    return true;
  }

  int _estimateLawRowHours(String rawValue) {
    final parts = rawValue
        .split('+')
        .map((part) => int.tryParse(part.trim()) ?? 0)
        .where((value) => value > 0)
        .toList();
    if (parts.isEmpty) {
      return 0;
    }
    return parts.reduce((sum, value) => sum + value) * 15;
  }

  int _pickWorkloadFromNumericColumns(List<int> values) {
    if (values.isEmpty) {
      return 0;
    }

    for (var index = 2; index < values.length; index++) {
      final candidate = values[index];
      if (candidate == values[index - 1] + values[index - 2]) {
        return candidate;
      }
    }

    for (var index = 1; index < values.length; index++) {
      final candidate = values[index];
      if (candidate >= 30 && candidate <= 500) {
        return candidate;
      }
    }

    return values.firstWhere(
      (value) => value >= 30 && value <= 500,
      orElse: () => 0,
    );
  }

  List<CurriculumImportSubjectDraft> _extractLineBasedSubjects(
    List<String> lines,
  ) {
    final subjects = <CurriculumImportSubjectDraft>[];
    final seen = <String>{};
    int? currentSemester;

    for (final line in lines) {
      final semesterHeader = _extractSemesterFromHeader(line);
      if (semesterHeader != null && _looksLikeSemesterHeader(line)) {
        currentSemester = semesterHeader;
        continue;
      }

      final subject = _parseSubjectLine(line, currentSemester);
      if (subject == null) {
        continue;
      }

      final key =
          '${_normalize(subject.name)}|${subject.suggestedSemester ?? 0}';
      if (seen.add(key)) {
        subjects.add(subject);
      }
    }

    return subjects;
  }

  CurriculumImportSubjectDraft? _parseSubjectLine(
    String line,
    int? inheritedSemester,
  ) {
    if (line.length < 6 || line.length > 180) {
      return null;
    }

    final normalized = _normalize(line);
    if (_isMetadataLine(normalized)) {
      return null;
    }

    final hoursMatch = _findBestHourMatch(line);
    if (hoursMatch == null) {
      return null;
    }

    final codeMatch = RegExp(
      r'^\s*([A-Z]{2,}[-_.]?\d{2,}[A-Z0-9-_.]*)\b',
    ).firstMatch(line);
    final explicitSemester = _extractSemesterFromHeader(line);

    var working = line;
    if (codeMatch != null) {
      working = working.replaceFirst(codeMatch.group(0)!, '');
    }
    working = working.replaceFirst(hoursMatch.group(0)!, ' ');
    working = working.replaceAll(
      RegExp(
        r'\b\d{1,2}\s*(?:o|º|°)?\s*(?:periodo|periodos|semestre|semestres|fase|fases|modulo|modulos|ano|anos)\b',
        caseSensitive: false,
      ),
      ' ',
    );
    working = working.replaceAll(RegExp(r'\s*[\|\;\-]\s*'), ' ');
    working = _cleanSubjectName(working);

    if (!_isLikelyImportedSubjectName(working)) {
      return null;
    }

    return CurriculumImportSubjectDraft(
      localId: IdGenerator.generate(),
      name: working,
      code: codeMatch?.group(1),
      workloadHours: _parseNumber(hoursMatch.namedGroup('hours')) ?? 0,
      suggestedSemester: explicitSemester ?? inheritedSemester,
      type: _inferSubjectType(_normalize(working)),
      syllabus: null,
    );
  }

  RegExpMatch? _findBestHourMatch(String line) {
    final explicitMatches = RegExp(
      r'(?<hours>\d{2,4})(?:[.,]\d+)?\s*(?:h|hr|hrs|hora|horas|ch|c\/h|c\.h\.)\b',
      caseSensitive: false,
    ).allMatches(line);
    if (explicitMatches.isNotEmpty) {
      return explicitMatches.last;
    }

    final endMatches = RegExp(
      r'(?<hours>\d{2,4})(?!.*\d)',
      caseSensitive: false,
    ).allMatches(line);
    if (endMatches.isNotEmpty) {
      final candidate = endMatches.last;
      final parsed = _parseNumber(candidate.namedGroup('hours')) ?? 0;
      if (parsed >= 15 && parsed <= 1000) {
        return candidate;
      }
    }

    return null;
  }

  String? _extractInstitution(
    List<String> lines,
    String compactText,
    String compactNormalized,
  ) {
    for (final line in lines.take(80)) {
      final normalized = _normalize(line);
      if ((normalized.contains('universidade') ||
              normalized.contains('instituto federal') ||
              normalized.contains('centro universitario') ||
              normalized.contains('instituto federal do') ||
              normalized.contains('faculdade de direito da universidade')) &&
          !_isGenericLabelValue(line)) {
        return _titleCaseIfUpper(
          _stripLeadingLabel(
                line,
                labels: const ['instituicao', 'instituicao de ensino'],
              ) ??
              line,
        );
      }
    }

    final fromAnchors = _extractByPattern(
      compactText,
      compactNormalized,
      r'instituicao\s+(.+?)\s+data\s+da\s+publicacao',
    );
    if (fromAnchors != null &&
        fromAnchors.isNotEmpty &&
        !_isGenericLabelValue(fromAnchors)) {
      return fromAnchors;
    }

    final labeled = _extractLabeledValue(
      lines,
      labels: const ['instituicao', 'instituicao de ensino', 'universidade'],
    );
    if (labeled != null &&
        labeled.isNotEmpty &&
        !_isGenericLabelValue(labeled) &&
        (_normalize(labeled).contains('universidade') ||
            _normalize(labeled).contains('instituto') ||
            _normalize(labeled).contains('faculdade'))) {
      return _stripLeadingLabel(
        labeled,
        labels: const ['instituicao', 'instituicao de ensino'],
      );
    }

    return null;
  }

  String? _extractSchoolName(
    List<String> lines,
    String compactText,
    String compactNormalized,
  ) {
    final labeled = _extractLabeledValue(
      lines,
      labels: const ['faculdade', 'escola', 'unidade academica'],
    );
    if (labeled != null && labeled.isNotEmpty) {
      return labeled;
    }

    return _extractByPattern(
          compactText,
          compactNormalized,
          r'(?:faculdade|escola)\s+(.+?)\s+(?:campus|curso|unidade|inicio\s+do\s+curso)',
        ) ??
        _extractBetweenAnchors(
          compactText,
          compactNormalized,
          startNeedles: const ['faculdade ', 'escola '],
          endNeedles: const [
            'campus ',
            'curso ',
            'unidade ',
            'inicio do curso',
          ],
        );
  }

  String? _extractCampus(
    List<String> lines,
    String compactText,
    String compactNormalized,
  ) {
    final adjacent = _extractValueAfterLabelLine(
      lines,
      labels: const ['unidade', 'campus'],
    );
    if (adjacent != null &&
        adjacent.isNotEmpty &&
        adjacent.length <= 80 &&
        !_normalize(adjacent).contains('respons') &&
        !_normalize(adjacent).contains('desenvolvem')) {
      return adjacent;
    }

    final extracted = _extractByPattern(
          compactText,
          compactNormalized,
          r'(?:unidade|campus)\s+(.+?)\s+(?:inicio\s+do\s+curso|endereco|cidade)',
        ) ??
        _extractBetweenAnchors(
          compactText,
          compactNormalized,
          startNeedles: const ['unidade ', 'campus '],
          endNeedles: const ['inicio do curso', 'endereco', 'cidade'],
        ) ??
        _stripLeadingLabel(
          _extractLabeledValue(lines, labels: const ['campus', 'unidade']),
          labels: const ['campus', 'unidade'],
        );

    if (extracted == null || extracted.isEmpty) {
      return null;
    }

    final cleaned = extracted.trim();
    if (cleaned.length > 80 ||
        _normalize(cleaned).contains('consistiram') ||
        _normalize(cleaned).contains('desenvolvem') ||
        _normalize(cleaned).contains('respons')) {
      return null;
    }
    return cleaned;
  }

  String? _extractCourseName(
    List<String> lines,
    String compactText,
    String compactNormalized,
  ) {
    for (final line in lines.take(60)) {
      final normalizedLine = _normalize(line);
      if (normalizedLine.contains('curso de pedagogia')) {
        return 'Pedagogia';
      }
      if (normalizedLine.contains('curso de agronomia')) {
        return 'Agronomia';
      }
      if (normalizedLine.contains('curso de administracao')) {
        return 'Administracao';
      }
      if (normalizedLine.contains('curso de direito')) {
        return 'Direito';
      }
      if (normalizedLine.contains(
        'curso superior de tecnologia em analise e desenvolvimento de sistemas',
      )) {
        return 'Tecnologia em Analise e Desenvolvimento de Sistemas';
      }
    }

    final fromProjectTitle = _extractByPattern(
      compactText,
      compactNormalized,
      r'projeto\s+pedagogico(?:\s+do)?\s+curso(?:\s+superior\s+de\s+tecnologia)?\s+(?:de|em)?\s+(.+?)(?:\s+boa\s+viagem|\s+goiania|\s+go,\s+brasil|\s+introducao|\s+1\s+dados|\s+faculdade|\s+coordenacao)',
    );
    if (_looksLikeValidCourseName(fromProjectTitle)) {
      return _titleCaseIfUpper(fromProjectTitle!);
    }

    final byDenomination = _extractByPattern(
      compactText,
      compactNormalized,
      r'denominacao\s*[:\-]?\s*(.+?)\s+eixo\s+tecnologico',
    );
    if (_looksLikeValidCourseName(byDenomination)) {
      return _titleCaseIfUpper(byDenomination!);
    }

    final byMatrixTitle = _extractByPattern(
      compactText,
      compactNormalized,
      r'matriz\s+curricular\s+(?:do\s+)?curso(?:\s+superior\s+de\s+tecnologia)?\s*(?:de|em)?\s+(.+?)(?:\s+\(|\s+semestre|\s+periodo|\s+quadro)',
    );
    if (_looksLikeValidCourseName(byMatrixTitle)) {
      return _titleCaseIfUpper(byMatrixTitle!);
    }

    final byGraduationPattern = _extractByPattern(
      compactText,
      compactNormalized,
      r'curso\s+de\s+graduacao\s+em\s+(.+?)(?:\s+no\s+componente|\s+apresenta|\s+com\s+uma\s+estrutura)',
    );
    if (_looksLikeValidCourseName(byGraduationPattern)) {
      return _titleCaseIfUpper(byGraduationPattern!);
    }

    final fromAnchors = _extractByPattern(
      compactText,
      compactNormalized,
      r'identificacao\s+do\s+curso\s+curso\s+(.+?)\s+titulo\s+academico',
    );
    if (_looksLikeValidCourseName(fromAnchors)) {
      return _titleCaseIfUpper(fromAnchors!);
    }

    final fallbackAnchors = _extractByPattern(
      compactText,
      compactNormalized,
      r'curso\s+(.+?)\s+titulo\s+academico',
    );
    if (_looksLikeValidCourseName(fallbackAnchors)) {
      return _titleCaseIfUpper(
        _stripLeadingLabel(fallbackAnchors, labels: const ['curso']) ??
            fallbackAnchors!,
      );
    }

    final labeled = _extractLabeledValue(
      lines,
      labels: const [
        'curso',
        'graduacao',
        'graduacao em',
        'denominacao',
        'nome do curso',
      ],
    );
    final cleanedLabeled = _stripLeadingLabel(
      labeled,
      labels: const ['curso', 'denominacao', 'nome do curso'],
    );
    if (_looksLikeValidCourseName(cleanedLabeled)) {
      return cleanedLabeled;
    }

    for (final line in lines.take(40)) {
      final cleanedLine =
          _stripLeadingLabel(line, labels: const ['curso']) ?? line;
      final normalized = _normalize(cleanedLine);
      if (normalized.contains('bacharelado em') ||
          normalized.contains('licenciatura em') ||
          normalized.contains('tecnologo em') ||
          normalized.contains('mestrado em') ||
          normalized.contains('doutorado em') ||
          normalized.contains('mba em') ||
          normalized.contains('especializacao em')) {
        if (_looksLikeValidCourseName(cleanedLine)) {
          return cleanedLine;
        }
      }
    }

    return null;
  }

  String? _extractDegreeLabel(
    List<String> lines,
    String compactText,
    String compactNormalized,
    String courseName,
  ) {
    final fromAnchors = _extractByPattern(
      compactText,
      compactNormalized,
      r'identificacao\s+do\s+curso\s+curso\s+.+?\s+titulo\s+academico\s+(.+?)\s+area\s+do\s+conhecimento',
    );
    if (fromAnchors != null && fromAnchors.isNotEmpty) {
      return fromAnchors;
    }

    final fallbackAnchors = _extractByPattern(
      compactText,
      compactNormalized,
      r'titulo\s+academico\s+(.+?)\s+area\s+do\s+conhecimento',
    );
    if (fallbackAnchors != null && fallbackAnchors.isNotEmpty) {
      return fallbackAnchors;
    }

    final labeled = _extractLabeledValue(
      lines,
      labels: const [
        'nivel',
        'titulacao',
        'grau academico',
        'titulacao conferida',
      ],
    );
    final cleanedLabeled = _stripLeadingLabel(
      labeled,
      labels: const [
        'nivel',
        'titulacao',
        'grau academico',
        'titulacao conferida',
      ],
    );
    if (cleanedLabeled != null &&
        cleanedLabeled.isNotEmpty &&
        !_isGenericLabelValue(cleanedLabeled)) {
      return cleanedLabeled;
    }

    final normalizedCourse = _normalize(courseName);
    if (normalizedCourse.contains('bacharelado')) {
      return 'Bacharelado';
    }
    if (normalizedCourse.contains('licenciatura')) {
      return 'Licenciatura';
    }
    if (normalizedCourse.contains('tecnologo')) {
      return 'Tecnologo';
    }
    if (normalizedCourse.contains('mestrado')) {
      return 'Mestrado';
    }
    if (normalizedCourse.contains('doutorado')) {
      return 'Doutorado';
    }
    if (normalizedCourse.contains('mba')) {
      return 'MBA';
    }
    if (normalizedCourse.contains('especializacao')) {
      return 'Especializacao';
    }

    return null;
  }

  int? _extractTotalCourseHours(String compactNormalized) {
    return _extractNumberByPatterns(compactNormalized, const [
      r'carga\s*horaria\s*total\s*do\s*curso\s*[:\-]?\s*([\d.]+)',
      r'carga\s*horaria\s*total\s*[:\-]?\s*([\d.]+)',
      r'carga\s*horaria\s*obrigatoria\s*[:\-]?\s*([\d.]+)',
      r'carga\s*horaria\s*de\s*([\d.]+)\s*horas',
      r'corresponde\s*a\s*uma\s*carga\s*horaria\s*total\s*de\s*([\d.]+)',
      r'carga\s*horaria\s*minima\s*exigida\s*[:\-]?\s*([\d.]+)',
    ]);
  }

  int? _extractComplementaryHours(String compactNormalized) {
    return _extractNumberByPatterns(compactNormalized, const [
      r'c\.?h\.?\s*em\s*atividades\s*complementares\s*([\d.]+)',
      r'([\d.]+)\s*\([^)]+\)\s*horas\s*de\s*atividades\s*complementares',
      r'atividades\s*complementares\s*\(ac\)\s*([\d.]+)',
      r'carga\s*horaria\s*de\s*atividades\s*complementares\s*[:\-]?\s*([\d.]+)\s*(?:h|horas)?',
      r'atividades\s*complementares\s*[:\-]?\s*([\d.]+)\s*(?:h|horas)',
      r'horas\s*complementares\s*[:\-]?\s*([\d.]+)\s*(?:h|horas)?',
    ]);
  }

  int? _extractExtensionHours(String compactNormalized) {
    return _extractNumberByPatterns(compactNormalized, const [
      r'c\.?h\.?\s*em\s*atividades\s*extensionistas\s*([\d.]+)',
      r'([\d.]+)\s*\([^)]+\)\s*horas\s*de\s*atividades\s*extensionistas',
      r'carga\s*horaria\s*de\s*atividades\s*extensionistas\s*[:\-]?\s*([\d.]+)\s*(?:h|horas)?',
      r'horas\s*de\s*extensao\s*[:\-]?\s*([\d.]+)\s*(?:h|horas)?',
      r'atividades\s*extensionistas\s*[:\-]?\s*([\d.]+)\s*(?:h|horas)',
    ]);
  }

  int? _extractInternshipHours(String compactNormalized) {
    if (_internshipIsNonMandatory(compactNormalized)) {
      return 0;
    }

    return _extractNumberByPatterns(compactNormalized, const [
      r'estagio\s*supervisionado\s*[:\-]?\s*([\d.]+)\s*(?:h|horas)?',
      r'estagio\s*curricular\s*obrigatorio\s*[:\-]?\s*([\d.]+)\s*(?:h|horas)?',
      r'estagio\s*curricular\s*supervisionado\s*[:\-]?\s*([\d.]+)\s*(?:h|horas)?',
      r'horas\s*de\s*estagio\s*[:\-]?\s*([\d.]+)\s*(?:h|horas)?',
    ]);
  }

  bool _internshipIsNonMandatory(String compactNormalized) {
    return compactNormalized.contains(
          'estagio curricular supervisionado nao e obrigatorio',
        ) ||
        compactNormalized.contains(
          'no curso bacharelado em ciencia da computacao, o estagio curricular supervisionado nao e obrigatorio',
        );
  }

  int? _extractSemesterCount(String compactNormalized) {
    final direct = _extractNumberByPatterns(compactNormalized, const [
      r'define\s*(\d{1,2})\s*\([^)]+\)\s*semestres',
      r'define\s*(\d{1,2})\s*semestres',
      r'duracao\s*ideal\s*do\s*curso\s*(\d{1,2})\s*semestres',
      r'duracao\s*minima\s*:\s*(\d{1,2})\s*semestres',
      r'minimo\s*[\d,.]+\s*anos\s*\((\d{1,2})\s*semestres\)',
      r'maximo\s*[\d,.]+\s*anos\s*\((\d{1,2})\s*semestres\)',
      r'(\d{1,2})\s*semestres\)',
      r'curso\s+esta\s+organizado\s+em\s+regime\s+semestral,\s+com\s+0?(\d{1,2})\s*\(',
      r'(\d{1,2})\s*semestres\s*como\s*sendo\s*a\s*duracao',
    ]);
    if (direct != null) {
      return direct;
    }

    final durationYears = _extractNumberByPatterns(compactNormalized, const [
      r'duracao\s*do\s*curso\s*(\d{1,2})\s*anos',
    ]);
    if (durationYears != null &&
        compactNormalized.contains('regime escolar semestral')) {
      return durationYears * 2;
    }

    return null;
  }

  int? _extractNumberByPatterns(String text, List<String> patterns) {
    for (final pattern in patterns) {
      final match = RegExp(pattern, caseSensitive: false).firstMatch(text);
      if (match == null) {
        continue;
      }
      final number = _parseNumber(match.group(1));
      if (number != null) {
        return number;
      }
    }
    return null;
  }

  String? _extractBetweenAnchors(
    String compactText,
    String compactNormalized, {
    required List<String> startNeedles,
    required List<String> endNeedles,
  }) {
    for (final startNeedle in startNeedles) {
      final startIndex = compactNormalized.indexOf(_normalize(startNeedle));
      if (startIndex == -1) {
        continue;
      }

      final contentStart = startIndex + startNeedle.length;
      var endIndex = compactText.length;
      var foundEnd = false;
      for (final endNeedle in endNeedles) {
        final candidate = compactNormalized.indexOf(
          _normalize(endNeedle),
          contentStart,
        );
        if (candidate != -1 && candidate < endIndex) {
          endIndex = candidate;
          foundEnd = true;
        }
      }

      if (!foundEnd || endIndex <= contentStart) {
        continue;
      }

      final value = compactText
          .substring(contentStart, endIndex)
          .replaceAll(RegExp(r'^[\s:\-]+|[\s:\-]+$'), '')
          .trim();
      if (value.isNotEmpty) {
        return value;
      }
    }

    return null;
  }

  String? _extractByPattern(
    String compactText,
    String compactNormalized,
    String pattern,
  ) {
    final match = RegExp(
      pattern,
      caseSensitive: false,
    ).firstMatch(compactNormalized);
    if (match == null) {
      return null;
    }

    final group = match.group(1);
    if (group == null || group.isEmpty) {
      return null;
    }

    final fullMatch = match.group(0)!;
    final relativeStart = fullMatch.indexOf(group);
    if (relativeStart == -1) {
      return null;
    }
    final start = match.start + relativeStart;
    final end = start + group.length;
    return compactText.substring(start, end).trim();
  }

  String? _extractLabeledValue(
    List<String> lines, {
    required List<String> labels,
  }) {
    for (final line in lines) {
      final normalized = _normalize(line);
      for (final label in labels) {
        final normalizedLabel = _normalize(label);
        if (!normalized.startsWith(normalizedLabel) &&
            !normalized.contains('$normalizedLabel:') &&
            !normalized.contains('$normalizedLabel -')) {
          continue;
        }

        if (normalized.startsWith(normalizedLabel) &&
            !normalized.contains('$normalizedLabel:') &&
            !normalized.contains('$normalizedLabel -')) {
          final trimmed = line.trim();
          if (!_isGenericLabelValue(trimmed)) {
            return trimmed;
          }
          continue;
        }

        final match = RegExp(
          '^.*?(?:${RegExp.escape(normalizedLabel)})\\s*[:\\-]?\\s*(.+)\$',
          caseSensitive: false,
        ).firstMatch(normalized);
        if (match == null) {
          continue;
        }

        final value = line
            .substring(line.length - match.group(1)!.length)
            .trim();
        if (value.isNotEmpty && !_isGenericLabelValue(value)) {
          return value;
        }
      }
    }

    return null;
  }

  String? _extractValueAfterLabelLine(
    List<String> lines, {
    required List<String> labels,
  }) {
    for (var index = 0; index < lines.length - 1; index++) {
      final current = _normalize(lines[index]);
      for (final label in labels) {
        if (current == _normalize(label)) {
          final next = lines[index + 1].trim();
          if (next.isNotEmpty) {
            return next;
          }
        }
      }
    }

    return null;
  }

  String _extractSection(
    String compactText,
    String compactNormalized, {
    required List<String> startNeedles,
    required List<String> endNeedles,
  }) {
    var selectedStart = -1;
    var selectedNeedle = '';
    for (final startNeedle in startNeedles) {
      final candidate = compactNormalized.lastIndexOf(_normalize(startNeedle));
      if (candidate > selectedStart) {
        selectedStart = candidate;
        selectedNeedle = startNeedle;
      }
    }

    if (selectedStart == -1) {
      return '';
    }

    var endIndex = compactText.length;
    for (final endNeedle in endNeedles) {
      final candidate = compactNormalized.indexOf(
        _normalize(endNeedle),
        selectedStart + selectedNeedle.length,
      );
      if (candidate != -1 && candidate < endIndex) {
        endIndex = candidate;
      }
    }

    if (endIndex <= selectedStart) {
      return '';
    }
    return compactText.substring(selectedStart, endIndex);
  }

  CourseSubjectType _inferSubjectType(
    String normalizedLine, {
    String? nucleus,
  }) {
    final upperNucleus = nucleus?.toUpperCase();
    if (upperNucleus == 'O') {
      return CourseSubjectType.elective;
    }
    if (normalizedLine.contains('estagio')) {
      return CourseSubjectType.internship;
    }
    if (normalizedLine.contains('extensao') ||
        normalizedLine.contains('extensionista')) {
      return CourseSubjectType.extension;
    }
    if (normalizedLine.contains('tcc') ||
        normalizedLine.contains('tc i') ||
        normalizedLine.contains('tc ii') ||
        normalizedLine.contains('trabalho de conclusao') ||
        normalizedLine.contains('trabalho de curso')) {
      return CourseSubjectType.thesis;
    }
    if (normalizedLine.contains('optativa') ||
        normalizedLine.contains('eletiva')) {
      return CourseSubjectType.elective;
    }
    return CourseSubjectType.mandatory;
  }

  bool _isMetadataLine(String normalizedLine) {
    return normalizedLine.contains('carga horaria total') ||
        normalizedLine.contains('horas complementares') ||
        normalizedLine.contains('atividades complementares') ||
        normalizedLine.contains('horas de extensao') ||
        normalizedLine.contains('extensao curricular') ||
        normalizedLine.contains('ementa') ||
        normalizedLine.contains('bibliografia') ||
        normalizedLine.contains('perfil do egresso') ||
        normalizedLine.contains('metodologia') ||
        normalizedLine.contains('avaliacao') ||
        normalizedLine.contains('coordenacao') ||
        normalizedLine.contains('coordenador') ||
        normalizedLine.contains('campus') ||
        normalizedLine.contains('instituicao') ||
        normalizedLine.contains('universidade') ||
        normalizedLine.contains('faculdade') ||
        RegExp(r'^estagio supervisionado\s*[:\-]').hasMatch(normalizedLine) ||
        RegExp(r'^extensao\s*[:\-]').hasMatch(normalizedLine) ||
        normalizedLine.contains('turno') ||
        normalizedLine.contains('modalidade');
  }

  bool _looksLikeMetadataName(String normalizedName) {
    return normalizedName.startsWith('carga horaria') ||
        normalizedName.startsWith('horas complementares') ||
        normalizedName.startsWith('atividades complementares') ||
        normalizedName.startsWith('estagio supervisionado total') ||
        normalizedName.startsWith('extensao total');
  }

  bool _looksLikeSemesterHeader(String line) {
    if (_shouldUseModernSemesterParsing(line)) {
      return RegExp(
        r'^\s*(?:\d{1,2}\s*(?:o|º|°)?|[ivxlcdm]+|primeiro|segundo|terceiro|quarto|quinto|sexto|setimo|sétimo|oitavo|nono|decimo)\s*(?:periodo|semestre|fase|modulo|ano)\b',
        caseSensitive: false,
      ).hasMatch(_normalize(line));
    }
    return RegExp(
      r'^\s*\d{1,2}\s*(?:o|º|°)?\s*(?:periodo|semestre|fase|modulo|ano)\b',
      caseSensitive: false,
    ).hasMatch(line);
  }

  int? _extractSemesterFromHeader(String line) {
    if (_shouldUseModernSemesterParsing(line)) {
      final directMatch = RegExp(
        r'(\d{1,2})\s*(?:o|º|°)?\s*(?:periodo|semestre|fase|modulo|ano)\b',
        caseSensitive: false,
      ).firstMatch(_normalize(line));
      if (directMatch != null) {
        final parsed = int.tryParse(directMatch.group(1)!);
        if (parsed != null && parsed >= 1 && parsed <= 12) {
          return parsed;
        }
        return null;
      }

      final textualMatch = RegExp(
        r'(primeiro|segundo|terceiro|quarto|quinto|sexto|setimo|sétimo|oitavo|nono|decimo|[ivxlcdm]+)\s*(?:periodo|semestre|fase|modulo|ano)\b',
        caseSensitive: false,
      ).firstMatch(_normalize(line));
      if (textualMatch == null) {
        return null;
      }
      return _parseSemesterToken(textualMatch.group(1) ?? '');
    }

    final match = RegExp(
      r'(\d{1,2})\s*(?:o|º|°)?\s*(?:periodo|semestre|fase|modulo|ano)\b',
      caseSensitive: false,
    ).firstMatch(line);
    if (match == null) {
      return null;
    }
    return int.tryParse(match.group(1)!);
  }

  int? _parseSemesterToken(String value) {
    final normalized = _normalize(value);
    if (_shouldUseModernSemesterParsing(value)) {
      const romanSemesters = {
        'i': 1,
        'ii': 2,
        'iii': 3,
        'iv': 4,
        'v': 5,
        'vi': 6,
        'vii': 7,
        'viii': 8,
        'ix': 9,
        'x': 10,
      };
      if (romanSemesters.containsKey(normalized)) {
        return romanSemesters[normalized];
      }
    }
    if (normalized.contains('primeiro')) {
      return 1;
    }
    if (normalized.contains('segundo')) {
      return 2;
    }
    if (normalized.contains('terceiro')) {
      return 3;
    }
    if (normalized.contains('quarto')) {
      return 4;
    }
    if (normalized.contains('quinto')) {
      return 5;
    }
    if (normalized.contains('sexto')) {
      return 6;
    }
    if (normalized.contains('setimo') || normalized.contains('sétimo')) {
      return 7;
    }
    if (normalized.contains('oitavo')) {
      return 8;
    }
    if (normalized.contains('nono')) {
      return 9;
    }
    if (normalized.contains('decimo')) {
      return 10;
    }
    return int.tryParse(normalized.replaceAll(RegExp(r'[^0-9]'), ''));
  }

  String _cleanSubjectName(String value) {
    var cleaned = value.replaceAll(RegExp(r'\s+'), ' ').replaceAll(' ,', ',');
    cleaned = cleaned.replaceAll(RegExp(r'\(\s+'), '(');
    cleaned = cleaned.replaceAll(RegExp(r'\s+\)'), ')');
    cleaned = cleaned.replaceAll(RegExp(r'\s+,'), ',');
    cleaned = cleaned.replaceAll(RegExp(r'\s+;'), ';');
    cleaned = _repairSplitWords(cleaned);
    return cleaned.trim();
  }

  String _repairSplitWords(String value) {
    if (_shouldUseModernWordRepair(value)) {
      var repairedValue = value;
      final singleLetterSplitPattern = RegExp(
        r'\b([A-ZÀ-Ý])\s+([a-zà-ÿ]{2,})\b',
      );

      while (true) {
        final merged = repairedValue.replaceAllMapped(
          singleLetterSplitPattern,
          (match) => '${match.group(1)}${match.group(2)}',
        );
        if (merged == repairedValue) {
          break;
        }
        repairedValue = merged;
      }

      return repairedValue;
    }

    var repaired = value;
    final singleLetterSplitPattern = RegExp(r'\b([A-ZÀ-Ý])\s+([a-zà-ÿ]{2,})\b');

    while (true) {
      final merged = repaired.replaceAllMapped(
        singleLetterSplitPattern,
        (match) => '${match.group(1)}${match.group(2)}',
      );
      if (merged == repaired) {
        break;
      }
      repaired = merged;
    }

    return repaired;
  }

  double _characterDiceCoefficient(String a, String b) {
    if (a == b) {
      return 1;
    }
    if (a.length < 2 || b.length < 2) {
      return 0;
    }

    final aBigrams = <String, int>{};
    for (var index = 0; index < a.length - 1; index++) {
      final gram = a.substring(index, index + 2);
      aBigrams.update(gram, (value) => value + 1, ifAbsent: () => 1);
    }

    var intersection = 0;
    var bCount = 0;
    for (var index = 0; index < b.length - 1; index++) {
      final gram = b.substring(index, index + 2);
      bCount++;
      final available = aBigrams[gram];
      if (available != null && available > 0) {
        intersection++;
        if (available == 1) {
          aBigrams.remove(gram);
        } else {
          aBigrams[gram] = available - 1;
        }
      }
    }

    final aCount = a.length - 1;
    return (2 * intersection) / (aCount + bCount);
  }

  int? _parseNumber(String? value) {
    if (value == null) {
      return null;
    }

    final sanitized = value.replaceAll(RegExp(r'[^0-9]'), '');
    if (sanitized.isEmpty) {
      return null;
    }
    return int.tryParse(sanitized);
  }

  int _sumHoursByType(
    List<CurriculumImportSubjectDraft> subjects,
    CourseSubjectType type,
  ) {
    return subjects
        .where((subject) => subject.type == type)
        .fold<int>(0, (sum, item) => sum + item.workloadHours);
  }

  int? _maxSuggestedSemester(List<CurriculumImportSubjectDraft> subjects) {
    final semesters = subjects
        .map((subject) => subject.suggestedSemester)
        .whereType<int>()
        .toList();
    if (semesters.isEmpty) {
      return null;
    }
    semesters.sort();
    return semesters.last;
  }

  List<CurriculumImportSubjectDraft> _mergeSubjects(
    List<CurriculumImportSubjectDraft> subjects,
  ) {
    final merged = <CurriculumImportSubjectDraft>[];
    final seen = <String>{};
    for (final subject in subjects) {
      final key =
          '${_normalize(subject.name)}|${subject.suggestedSemester ?? 0}';
      if (seen.add(key)) {
        merged.add(subject);
      }
    }
    return merged;
  }

  List<CurriculumImportSubjectDraft> _attachSyllabi(
    List<CurriculumImportSubjectDraft> subjects,
    Map<String, String> syllabusByNormalizedName,
  ) {
    if (subjects.isEmpty || syllabusByNormalizedName.isEmpty) {
      return subjects;
    }

    return subjects.map((subject) {
      final exactMatch =
          syllabusByNormalizedName[_normalizedSubjectLookupKey(subject.name)];
      final syllabus =
          exactMatch ??
          _findClosestSyllabus(subject.name, syllabusByNormalizedName);
      if (syllabus == null || syllabus.isEmpty) {
        return subject;
      }
      return subject.copyWith(syllabus: syllabus);
    }).toList();
  }

  Map<String, String> _extractSubjectSyllabusByNormalizedName(String text) {
    final matches = RegExp(
      r'Nome\s+da\s+disciplina:\s*(.+?)\s+Per[iíIÍ]odo:.*?Ementa:\s*(.+?)(?=\s+(?:Bibliografia|Nome\s+da\s+disciplina:|$))',
      caseSensitive: false,
      dotAll: true,
    ).allMatches(text);

    final syllabi = <String, String>{};
    for (final match in matches) {
      final name = _cleanSubjectName(match.group(1) ?? '');
      final syllabus = _cleanSyllabusText(match.group(2) ?? '');
      final normalizedName = _normalizedSubjectLookupKey(name);
      if (normalizedName.isEmpty || syllabus.isEmpty) {
        continue;
      }
      syllabi.putIfAbsent(normalizedName, () => syllabus);
    }
    return syllabi;
  }

  String _cleanSyllabusText(String value) {
    var cleaned = value.replaceAll(RegExp(r'\s+'), ' ').trim();
    cleaned = cleaned.replaceAll(
      RegExp(r'^(ementa|bibliografia)\s*:\s*', caseSensitive: false),
      '',
    );
    cleaned = _repairSplitWords(cleaned);
    return cleaned;
  }

  String _normalizedSubjectLookupKey(String value) {
    return _normalize(value).replaceAll(RegExp(r'[^a-z0-9]'), '');
  }

  String? _findClosestSyllabus(
    String subjectName,
    Map<String, String> syllabusByNormalizedName,
  ) {
    final target = _normalizedSubjectLookupKey(subjectName);
    if (target.isEmpty) {
      return null;
    }

    String? bestKey;
    var bestScore = 0.0;
    for (final candidate in syllabusByNormalizedName.keys) {
      final score = _characterDiceCoefficient(target, candidate);
      if (score > bestScore) {
        bestScore = score;
        bestKey = candidate;
      }
    }

    if (bestKey == null || bestScore < 0.9) {
      return null;
    }
    return syllabusByNormalizedName[bestKey];
  }

  String _buildProfileName({
    required String courseName,
    required String institution,
  }) {
    if (courseName.isEmpty && institution.isEmpty) {
      return '';
    }
    if (institution.isEmpty) {
      return courseName;
    }
    if (courseName.isEmpty) {
      return institution;
    }
    return '$institution - $courseName';
  }

  String? _stripLeadingLabel(String? value, {required List<String> labels}) {
    if (value == null) {
      return null;
    }

    final trimmed = value.trim();
    final normalizedTrimmed = _normalize(trimmed);
    for (final label in labels) {
      final normalizedLabel = _normalize(label);
      if (normalizedTrimmed.startsWith('$normalizedLabel ')) {
        return trimmed.substring(normalizedLabel.length).trim();
      }
    }
    return trimmed;
  }

  bool _looksLikeValidCourseName(String? value) {
    if (value == null) {
      return false;
    }

    final trimmed = value.trim();
    if (trimmed.isEmpty || trimmed.length > 120) {
      return false;
    }

    final normalized = _normalize(trimmed);
    const blockedFragments = [
      'sumario',
      'equipe responsavel',
      'diretor',
      'membros titulares',
      'identificacao',
      'organizacao didatico',
      'coordenadora',
      'coordenador',
      'nucleo docente',
    ];
    if (blockedFragments.any(normalized.contains)) {
      return false;
    }

    return normalized.contains('bacharelado') ||
        normalized.contains('curso de') ||
        normalized.contains('licenciatura') ||
        normalized.contains('tecnologia em') ||
        normalized.contains('tecnologo') ||
        normalized.contains('mestrado') ||
        normalized.contains('doutorado') ||
        normalized.contains('mba') ||
        normalized.contains('especializacao') ||
        normalized == 'administracao' ||
        normalized == 'agronomia' ||
        normalized == 'pedagogia' ||
        normalized == 'direito';
  }

  List<String> _buildParserNotes({
    required List<CurriculumImportSubjectDraft> subjects,
    required int totalCourseHours,
    required int semesterCount,
    required String institution,
    required String courseName,
    required String compactNormalized,
  }) {
    final notes = <String>[];

    if (subjects.isEmpty) {
      notes.add(
        'Nenhuma disciplina foi identificada automaticamente. Cole um trecho mais estruturado da grade ou adicione as materias manualmente antes de importar.',
      );
    }
    if (totalCourseHours == 0) {
      notes.add(
        'A carga horaria total do curso nao apareceu de forma clara no texto. Revise esse campo antes de concluir a importacao.',
      );
    }
    if (semesterCount == 0) {
      notes.add(
        'Nao foi possivel identificar a quantidade de semestres. Se o curso estiver organizado por periodo, ajuste esse campo manualmente.',
      );
    }
    if (institution.isEmpty) {
      notes.add(
        'A instituicao nao foi reconhecida automaticamente. Preencha esse campo para deixar o perfil mais completo.',
      );
    }
    if (courseName.isEmpty) {
      notes.add(
        'O nome do curso nao foi encontrado automaticamente. Revise antes de salvar.',
      );
    }
    if (_internshipIsNonMandatory(compactNormalized)) {
      notes.add(
        'O documento indica que o estagio curricular supervisionado nao e obrigatorio. O perfil sera criado com 0 horas obrigatorias de estagio.',
      );
    }

    return notes;
  }

  String _titleCaseIfUpper(String value) {
    final trimmed = value.trim();
    if (trimmed.isEmpty || trimmed != trimmed.toUpperCase()) {
      return trimmed;
    }

    return trimmed
        .split(RegExp(r'\s+'))
        .map((word) {
          if (word.isEmpty) {
            return word;
          }
          final lower = word.toLowerCase();
          return '${lower[0].toUpperCase()}${lower.substring(1)}';
        })
        .join(' ');
  }

  bool _shouldUseModernNormalization(String input) => true;

  bool _shouldUseModernSemesterParsing(String input) => true;

  bool _shouldUseModernWordRepair(String input) => true;

  bool _shouldKeepLegacyRegex(String input) => false;

  bool _isGenericLabelValue(String value) {
    final normalized = _normalize(value).trim();
    const invalidValues = {
      'instituicao',
      'instituicao de ensino',
      'universidade',
      'curso',
      'campus',
      'unidade',
      'nivel',
      'titulacao',
      'titulacao conferida',
      'grau academico',
      'respons.',
      'respons',
      ':',
      '-',
    };
    return normalized.isEmpty ||
        invalidValues.contains(normalized) ||
        (value.trim().endsWith(':') && value.trim().length <= 24);
  }

  String _repairMojibake(String value) {
    const replacements = {
      'Ã¡': 'á',
      'Ã ': 'à',
      'Ã¢': 'â',
      'Ã£': 'ã',
      'Ã¤': 'ä',
      'Ã©': 'é',
      'Ãª': 'ê',
      'Ã¨': 'è',
      'Ã­': 'í',
      'Ã¬': 'ì',
      'Ã³': 'ó',
      'Ã²': 'ò',
      'Ã´': 'ô',
      'Ãµ': 'õ',
      'Ã¶': 'ö',
      'Ãº': 'ú',
      'Ã¹': 'ù',
      'Ã¼': 'ü',
      'Ã§': 'ç',
      'Ã±': 'ñ',
      'Ã‰': 'É',
      'Ã“': 'Ó',
      'Ãš': 'Ú',
      'Ã‡': 'Ç',
      'Âº': 'º',
      'Â°': '°',
      'â€“': '-',
      'â€”': '-',
      'â€¢': '-',
      'â€˜': '\'',
      'â€™': '\'',
      'â€œ': '"',
      'â€': '"',
    };

    var repaired = value;
    replacements.forEach((source, target) {
      repaired = repaired.replaceAll(source, target);
    });
    return repaired;
  }

  String _normalize(String input) {
    if (_shouldUseModernNormalization(input)) {
      final replacements = {
        'á': 'a',
        'à': 'a',
        'â': 'a',
        'ã': 'a',
        'ä': 'a',
        'å': 'a',
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
        'ý': 'y',
        'ÿ': 'y',
        'º': 'o',
        '°': 'o',
      };

      var normalizedValue = _repairMojibake(input).toLowerCase();
      replacements.forEach((source, target) {
        normalizedValue = normalizedValue.replaceAll(source, target);
      });
      return normalizedValue;
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
    return normalized;
  }
}

class _TabularSubjectRow {
  const _TabularSubjectRow({
    required this.draft,
    this.prerequisiteRowNumbers = const <int>[],
    this.prerequisiteCodes = const <String>[],
    this.prerequisiteNames = const <String>[],
    this.rowNumber,
  });

  final int? rowNumber;
  final CurriculumImportSubjectDraft draft;
  final List<int> prerequisiteRowNumbers;
  final List<String> prerequisiteCodes;
  final List<String> prerequisiteNames;
}

class _ScoredLineWindow {
  const _ScoredLineWindow({
    required this.start,
    required this.end,
    required this.score,
  });

  final int start;
  final int end;
  final int score;
}

class _SemesterSection {
  const _SemesterSection({required this.semester, required this.text});

  final int? semester;
  final String text;
}
