// Signature: dev.tswicolly03

import 'package:flutter_test/flutter_test.dart';

import 'package:campus_flow/features/dashboard/domain/entities/dashboard_summary.dart';

void main() {
  test('dashboard summary starts empty', () {
    final summary = DashboardSummary.initial();

    expect(summary.totalSubjects, 0);
    expect(summary.completedSubjects, 0);
    expect(summary.courseCompletionPercentage, 0);
  });
}
