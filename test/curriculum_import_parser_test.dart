// Signature: dev.tswicolly03

import 'package:flutter_test/flutter_test.dart';

import 'package:campus_flow/features/academic_profile/data/services/curriculum_import_parser.dart';
import 'package:campus_flow/shared/enums/app_enums.dart';

void main() {
  group('CurriculumImportParser', () {
    test('extracts course metadata and subjects from a grade text', () {
      const rawText = '''
Universidade Federal do CampusFlow
Faculdade de Computacao
Curso: Bacharelado em Ciencia da Computacao
Campus: Centro
Carga horaria total: 3200 horas
Duracao minima: 8 semestres
Horas complementares: 120h
Estagio supervisionado: 160h
Horas de extensao: 180h

1o periodo
INF101 Algoritmos e Programacao 72h
MAT101 Calculo I 72h

2o periodo
INF201 Estruturas de Dados 72h
EXT200 Projeto de Extensao I 90h
EST300 Estagio Supervisionado I 80h
''';

      final preview = const CurriculumImportParser().parse(rawText);

      expect(preview.institution, 'Universidade Federal do Campus Flow');
      expect(preview.schoolName, 'Faculdade de Computacao');
      expect(preview.courseName, 'Bacharelado em Ciencia da Computacao');
      expect(preview.campus, 'Centro');
      expect(preview.degreeLabel, 'Bacharelado');
      expect(preview.totalCourseHours, 3200);
      expect(preview.semesterCount, 8);
      expect(preview.requiredComplementaryHours, 120);
      expect(preview.requiredInternshipHours, 160);
      expect(preview.requiredExtensionHours, 180);
      expect(preview.subjects, hasLength(5));
      expect(preview.subjects.first.code, 'INF101');
      expect(preview.subjects.first.name, 'Algoritmos e Programacao');
      expect(preview.subjects.first.workloadHours, 72);
      expect(preview.subjects.first.suggestedSemester, 1);
      expect(
        preview.subjects
            .firstWhere(
              (subject) => subject.name.contains('Projeto de Extensao'),
            )
            .type,
        CourseSubjectType.extension,
      );
      expect(
        preview.subjects
            .firstWhere(
              (subject) => subject.name.contains('Estagio Supervisionado'),
            )
            .type,
        CourseSubjectType.internship,
      );
    });

    test('extracts subjects and academic hours from a PPC-style matrix text', () {
      const rawText = '''
IDENTIFICACAO INSTITUCIONAL
Instituicao Instituto Federal de Educacao, Ciencia e Tecnologia Goiano
IDENTIFICACAO DA UNIDADE
Unidade Campus Morrinhos
IDENTIFICACAO DO CURSO
CURSO BACHARELADO EM CIENCIA DA COMPUTACAO
Titulo academico Bacharel em Ciencia da Computacao
Area do Conhecimento Ciencias Exatas e da Terra
Regime escolar Semestral
Duracao do curso 4 Anos
Carga horaria total do curso 3.200

1.1- MATRIZ CURRICULAR DE DISCIPLINAS OBRIGATORIAS
PRIMEIRO PERIODO
1 - Algoritmos e Programacao de Computadores NC 36 36 14 72
2 - Calculo I CB 72 0 14 72
5 - Introducao a Extensao NC 36 0 7 36

SEGUNDO PERIODO
8 - Algebra Linear CB 72 0 14 72
10 1 Linguagem e Tecnicas de Programacao NC 36 36 14 72

SEXTO PERIODO
37 11 Pratica de Laboratorio e Pesquisa (TC I) NE 36 0 7 36

SETIMO PERIODO
40 15, 37 Pratica de Laboratorio e Pesquisa (TC II) NE 36 0 7 36

1.2- DISCIPLINAS OPTATIVAS
44 - Desenvolvimento de aplicativos para dispositivos moveis O 36 36 14 72
53 - Libras O 36 0 7 36

C.H. em Atividades Complementares 108
C.H. em Atividades Extensionistas 320
** CARGA HORARIA TOTAL DO CURSO 3.200

No curso Bacharelado em Ciencia da Computacao, o estagio curricular supervisionado nao e obrigatorio.
''';

      final preview = const CurriculumImportParser().parse(rawText);

      expect(
        preview.institution,
        'Instituto Federal de Educacao, Ciencia e Tecnologia Goiano',
      );
      expect(preview.campus, 'Campus Morrinhos');
      expect(preview.courseName, 'Bacharelado Em Ciencia Da Computacao');
      expect(preview.degreeLabel, 'Bacharel em Ciencia da Computacao');
      expect(preview.totalCourseHours, 3200);
      expect(preview.semesterCount, 8);
      expect(preview.requiredComplementaryHours, 108);
      expect(preview.requiredExtensionHours, 320);
      expect(preview.requiredInternshipHours, 0);
      expect(preview.subjects, hasLength(8));
      expect(
        preview.subjects[0].name,
        'Algoritmos e Programacao de Computadores',
      );
      expect(preview.subjects[0].suggestedSemester, 1);
      expect(preview.subjects[2].type, CourseSubjectType.extension);
      expect(preview.subjects[5].type, CourseSubjectType.thesis);
      final linguagem = preview.subjects.firstWhere(
        (subject) => subject.name == 'Linguagem e Tecnicas de Programacao',
      );
      final algoritmos = preview.subjects.firstWhere(
        (subject) => subject.name == 'Algoritmos e Programacao de Computadores',
      );
      final tc2 = preview.subjects.firstWhere(
        (subject) =>
            subject.name == 'Pratica de Laboratorio e Pesquisa (TC II)',
      );
      final tc1 = preview.subjects.firstWhere(
        (subject) => subject.name == 'Pratica de Laboratorio e Pesquisa (TC I)',
      );
      expect(linguagem.prerequisiteLocalIds, contains(algoritmos.localId));
      expect(tc2.prerequisiteLocalIds, contains(tc1.localId));
      expect(
        preview.subjects.any(
          (subject) => subject.type == CourseSubjectType.elective,
        ),
        isTrue,
      );
      expect(
        preview.notes,
        contains(
          'O documento indica que o estagio curricular supervisionado nao e obrigatorio. O perfil sera criado com 0 horas obrigatorias de estagio.',
        ),
      );
    });

    test('repairs split subject names extracted from PDF text', () {
      const rawText = '''
Curso: Bacharelado em Ciencia da Computacao
Carga horaria total: 3200 horas
Duracao minima: 8 semestres

1o periodo
MAT101 C \u00e1lculo I 72h
INF101 I ntroducao a Computacao 72h
''';

      final preview = const CurriculumImportParser().parse(rawText);

      expect(
        preview.subjects.any((subject) => subject.name == 'C\u00e1lculo I'),
        isTrue,
      );
      expect(
        preview.subjects.any(
          (subject) => subject.name == 'Introducao a Computacao',
        ),
        isTrue,
      );
    });

    test('extracts syllabus blocks linked to the imported subjects', () {
      const rawText = '''
Curso: Bacharelado em Ciencia da Computacao
Carga horaria total: 3200 horas
Duracao minima: 8 semestres

1o periodo
INF101 Algoritmos e Programacao de Computadores 72h

Nome da disciplina: Algoritmos e Programacao de Computadores
Periodo: 1o
Pre-requisito(s): Nao ha pre-requisitos.
Ementa:
Logica de programacao; constantes; tipos de dados primitivos; variaveis; estruturas de decisao.
Bibliografia Basica:
Livro 1.
''';

      final preview = const CurriculumImportParser().parse(rawText);
      final algorithms = preview.subjects.firstWhere(
        (subject) => subject.name == 'Algoritmos e Programacao de Computadores',
      );

      expect(algorithms.syllabus, contains('Logica de programacao'));
      expect(algorithms.syllabus, contains('estruturas de decisao'));
    });

    test('extracts administration matrix from compact semester blocks', () {
      const rawText = '''
MATRIZ CURRICULAR CURSO DE ADMINISTRACAO
1o PERIODO CR H/A 50 min C/H 60 min PRESENCIAL MODALIDADE EAD PRATICAS EXTENSIONISTAS
1. Contabilidade Introdutoria I 4 80 67 34 33
2. Teoria Geral da Administracao 4 80 67 34 33
3. Economia 4 80 67 34 33
6. Praticas Extensionista I (Cesta Basica) 2 40 40 AACC 10 10
TOTAL 22 360 385 180 165 40
2o PERIODO CR H/A 50 min C/H 60 min PRESENCIAL MODALIDADE EAD PRATICAS EXTENSIONISTAS
7. Contabilidade Introdutoria II 4 80 67 34 33
8. Ciencias Sociais Aplicadas 4 80 67 34 33
''';

      final preview = const CurriculumImportParser().parse(rawText);

      expect(preview.courseName, 'Administracao');
      expect(preview.subjects.any((subject) => subject.name == 'Contabilidade Introdutoria I'), isTrue);
      expect(preview.subjects.any((subject) => subject.name == 'Contabilidade Introdutoria II'), isTrue);
      expect(
        preview.subjects
            .firstWhere((subject) => subject.name == 'Praticas Extensionista I (Cesta Basica)')
            .type,
        CourseSubjectType.extension,
      );
      expect(
        preview.subjects
            .firstWhere((subject) => subject.name == 'Contabilidade Introdutoria I')
            .suggestedSemester,
        1,
      );
    });

    test('extracts compact pedagogy matrix rows', () {
      const rawText = '''
UNIVERSIDADE FEDERAL DE GOIAS
PROJETO PEDAGOGICO CURSO DE PEDAGOGIA
VI ESTRUTURA CURRICULAR
a) Matriz Curricular
NUCLEO COMUM E ESPECIFICO - TOTAL 2.688 HORAS
Didatica na Formacao de Professores FE ----------------- 64 16 80 Especifico 16
Educacao e Artes Visuais FE ----------------- 64 16 80 Comum 16
Estagio em Anos Iniciais e Ed. infantil I FE ----------------- 56 16 72 Especifico 16
QUADRO DOS COMPONENTES CURRICULARES
ATIVIDADES COMPLEMENTARES (AC) 200 3%
''';

      final preview = const CurriculumImportParser().parse(rawText);

      expect(preview.courseName, 'Pedagogia');
      expect(preview.requiredComplementaryHours, 200);
      expect(
        preview.subjects.any(
          (subject) => subject.name.contains('Didatica na Formacao'),
        ),
        isTrue,
      );
      expect(
        preview.subjects
            .firstWhere(
              (subject) =>
                  subject.name.contains('Estagio em Anos Iniciais e Ed. infantil I'),
            )
            .type,
        CourseSubjectType.internship,
      );
    });

  });
}
