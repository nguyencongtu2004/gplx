
class Question {
  Question({
    required this.id,
    required this.question,
    required this.answers,
    required this.correctAnswer,
    required this.explanation,
    required this.signId,
    required this.image,
    required this.chapter,
    required this.isFailingPoint,
  });

  final int id;
  final String question;
  final List<String> answers;
  final int correctAnswer;
  final String explanation;
  final List<String> signId;
  final String image ;
  final int chapter ;
  final bool isFailingPoint;

  factory Question.fromMap(Map<String, dynamic> map) {
    return Question(
      id: map['id'],
      question: map['question'],
      answers: <String>[
        map['answer1'],
        map['answer2'],
        map['answer3'],
        map['answer4'],
      ].where((element) => element.isNotEmpty).toList(),
      correctAnswer: map['correctAnswer'],
      explanation: map['explanation'],
      signId:( map['signId'] as String).split(','),
      image: map['image'],
      chapter: map['chapter'],
      isFailingPoint: map['isFailingPoint'] == 1,
    );
  }
}