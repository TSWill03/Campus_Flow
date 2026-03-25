// Signature: dev.tswicolly03

import 'dart:math' as math;

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../course_subjects/domain/entities/course_subject.dart';
import '../../domain/entities/academic_profile.dart';
import '../../domain/entities/curriculum_import_subject_draft.dart';
import '../../domain/entities/subject_equivalence_suggestion.dart';

final courseSubjectEquivalenceAnalyzerProvider =
    Provider<CourseSubjectEquivalenceAnalyzer>(
      (ref) => const CourseSubjectEquivalenceAnalyzer(),
    );

class CourseSubjectEquivalenceAnalyzer {
  const CourseSubjectEquivalenceAnalyzer();

  static const _syllabusSimilarityThreshold = 0.8;
  static const _nameSimilarityThreshold = 0.92;
  static const _combinedNameThreshold = 0.72;
  static const _combinedSyllabusThreshold = 0.58;
  static const _combinedWorkloadThreshold = 0.7;

  Map<String, List<SubjectEquivalenceSuggestion>> analyze({
    required List<CurriculumImportSubjectDraft> importedSubjects,
    required List<AcademicProfile> existingProfiles,
    required List<CourseSubject> existingSubjects,
    String? excludedProfileId,
  }) {
    if (importedSubjects.isEmpty ||
        existingProfiles.isEmpty ||
        existingSubjects.isEmpty) {
      return const {};
    }

    final profileById = {
      for (final profile in existingProfiles)
        if (!profile.isDeleted) profile.id: profile,
    };
    final candidates = existingSubjects.where((subject) {
      final profileId = subject.academicProfileId;
      return !subject.isDeleted &&
          profileId != null &&
          profileId.isNotEmpty &&
          profileId != excludedProfileId &&
          profileById.containsKey(profileId);
    }).toList();
    if (candidates.isEmpty) {
      return const {};
    }

    final suggestionsByImportedSubject =
        <String, List<SubjectEquivalenceSuggestion>>{};
    for (final importedSubject in importedSubjects) {
      final subjectSuggestions = <SubjectEquivalenceSuggestion>[];
      for (final candidate in candidates) {
        final profile = profileById[candidate.academicProfileId];
        if (profile == null) {
          continue;
        }

        final nameSimilarity = _nameSimilarity(
          importedSubject.name,
          candidate.name,
        );
        final syllabusSimilarity = _syllabusSimilarity(
          importedSubject.syllabus,
          candidate.syllabus,
        );
        final workloadSimilarity = _workloadSimilarity(
          importedSubject.workloadHours,
          candidate.workloadHours,
        );

        if (!_shouldSuggestMatch(
          nameSimilarity: nameSimilarity,
          syllabusSimilarity: syllabusSimilarity,
          workloadSimilarity: workloadSimilarity,
        )) {
          continue;
        }

        final matchScore =
            (nameSimilarity * 0.45) +
            (syllabusSimilarity * 0.45) +
            (workloadSimilarity * 0.10);

        subjectSuggestions.add(
          SubjectEquivalenceSuggestion(
            importedSubjectLocalId: importedSubject.localId,
            importedSubjectName: importedSubject.name,
            existingSubjectId: candidate.id,
            existingSubjectName: candidate.name,
            existingProfileId: profile.id,
            existingProfileName: profile.profileName,
            existingStatus: candidate.status,
            matchScore: matchScore,
            nameSimilarity: nameSimilarity,
            syllabusSimilarity: syllabusSimilarity,
            workloadSimilarity: workloadSimilarity,
          ),
        );
      }

      if (subjectSuggestions.isEmpty) {
        continue;
      }

      subjectSuggestions.sort((left, right) {
        final scoreComparison = right.matchScore.compareTo(left.matchScore);
        if (scoreComparison != 0) {
          return scoreComparison;
        }

        if (left.isCompletedEquivalent != right.isCompletedEquivalent) {
          return right.isCompletedEquivalent ? 1 : -1;
        }

        return right.nameSimilarity.compareTo(left.nameSimilarity);
      });

      suggestionsByImportedSubject[importedSubject.localId] = subjectSuggestions
          .take(3)
          .toList();
    }

    return suggestionsByImportedSubject;
  }

  bool _shouldSuggestMatch({
    required double nameSimilarity,
    required double syllabusSimilarity,
    required double workloadSimilarity,
  }) {
    if (nameSimilarity >= _nameSimilarityThreshold) {
      return true;
    }
    if (syllabusSimilarity >= _syllabusSimilarityThreshold) {
      return true;
    }
    return nameSimilarity >= _combinedNameThreshold &&
        syllabusSimilarity >= _combinedSyllabusThreshold &&
        workloadSimilarity >= _combinedWorkloadThreshold;
  }

  double _nameSimilarity(String left, String right) {
    final normalizedLeft = _normalizeText(left);
    final normalizedRight = _normalizeText(right);
    if (normalizedLeft.isEmpty || normalizedRight.isEmpty) {
      return 0;
    }
    if (normalizedLeft == normalizedRight) {
      return 1;
    }

    final compactLeft = normalizedLeft.replaceAll(' ', '');
    final compactRight = normalizedRight.replaceAll(' ', '');
    final characterDice = _characterDiceCoefficient(compactLeft, compactRight);
    final tokenDice = _tokenDiceCoefficient(
      _tokenize(normalizedLeft, allowShortTokens: true),
      _tokenize(normalizedRight, allowShortTokens: true),
    );

    return math.min(1, (characterDice * 0.6) + (tokenDice * 0.4));
  }

  double _syllabusSimilarity(String? left, String? right) {
    final leftTokens = _tokenize(left, allowShortTokens: false);
    final rightTokens = _tokenize(right, allowShortTokens: false);
    if (leftTokens.isEmpty || rightTokens.isEmpty) {
      return 0;
    }

    final jaccard = _jaccardSimilarity(leftTokens, rightTokens);
    final overlap = _overlapCoefficient(leftTokens, rightTokens);
    final tokenDice = _tokenDiceCoefficient(leftTokens, rightTokens);
    return [jaccard, overlap, tokenDice].reduce(math.max);
  }

  double _workloadSimilarity(int leftHours, int rightHours) {
    if (leftHours <= 0 || rightHours <= 0) {
      return 0;
    }

    final larger = math.max(leftHours, rightHours);
    final diff = (leftHours - rightHours).abs();
    return math.max(0, 1 - (diff / larger));
  }

  Set<String> _tokenize(String? text, {required bool allowShortTokens}) {
    if (text == null || text.trim().isEmpty) {
      return const <String>{};
    }

    return _normalizeText(
      text,
    ).split(RegExp(r'\s+')).map((token) => token.trim()).where((token) {
      if (token.isEmpty || _stopwords.contains(token)) {
        return false;
      }
      if (allowShortTokens) {
        return token.length >= 2;
      }
      return token.length >= 4;
    }).toSet();
  }

  String _normalizeText(String input) {
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

    normalized = normalized.replaceAll(RegExp(r'[^a-z0-9\s]'), ' ');
    normalized = normalized.replaceAll(RegExp(r'\s+'), ' ').trim();
    return normalized;
  }

  double _characterDiceCoefficient(String left, String right) {
    if (left == right) {
      return 1;
    }
    if (left.length < 2 || right.length < 2) {
      return 0;
    }

    final leftBigrams = <String, int>{};
    for (var index = 0; index < left.length - 1; index++) {
      final gram = left.substring(index, index + 2);
      leftBigrams.update(gram, (value) => value + 1, ifAbsent: () => 1);
    }

    var intersection = 0;
    var rightBigramCount = 0;
    for (var index = 0; index < right.length - 1; index++) {
      final gram = right.substring(index, index + 2);
      rightBigramCount++;
      final available = leftBigrams[gram];
      if (available != null && available > 0) {
        intersection++;
        if (available == 1) {
          leftBigrams.remove(gram);
        } else {
          leftBigrams[gram] = available - 1;
        }
      }
    }

    final leftBigramCount = left.length - 1;
    return (2 * intersection) / (leftBigramCount + rightBigramCount);
  }

  double _tokenDiceCoefficient(
    Set<String> leftTokens,
    Set<String> rightTokens,
  ) {
    if (leftTokens.isEmpty || rightTokens.isEmpty) {
      return 0;
    }

    final intersection = leftTokens.intersection(rightTokens).length;
    return (2 * intersection) / (leftTokens.length + rightTokens.length);
  }

  double _jaccardSimilarity(Set<String> leftTokens, Set<String> rightTokens) {
    if (leftTokens.isEmpty || rightTokens.isEmpty) {
      return 0;
    }

    final unionSize = leftTokens.union(rightTokens).length;
    if (unionSize == 0) {
      return 0;
    }
    return leftTokens.intersection(rightTokens).length / unionSize;
  }

  double _overlapCoefficient(Set<String> leftTokens, Set<String> rightTokens) {
    if (leftTokens.isEmpty || rightTokens.isEmpty) {
      return 0;
    }

    final smallerSize = math.min(leftTokens.length, rightTokens.length);
    if (smallerSize == 0) {
      return 0;
    }
    return leftTokens.intersection(rightTokens).length / smallerSize;
  }
}

const _stopwords = <String>{
  'a',
  'ao',
  'aos',
  'as',
  'com',
  'da',
  'das',
  'de',
  'do',
  'dos',
  'e',
  'em',
  'na',
  'nas',
  'no',
  'nos',
  'o',
  'os',
  'ou',
  'para',
  'por',
  'um',
  'uma',
  'uns',
  'umas',
};
