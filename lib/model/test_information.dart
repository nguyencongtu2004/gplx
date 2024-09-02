class TestInformation {
  TestInformation({
    required this.totalQuestions,
    required this.timeLimit,
    required this.minimumPassingScore,
  });

  final int totalQuestions;
  final int timeLimit; // in minutes
  final int minimumPassingScore;
}
