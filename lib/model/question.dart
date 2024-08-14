enum QuestionStatus {
  notAnswered,
  correct,
  wrong,
}

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
    required this.isHard,
    required this.isSaved,
    required this.questionStatus,
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

  final bool isHard;
  final bool isSaved;
  final QuestionStatus questionStatus; // 0: chưa trả lời, 1: đã trả lời đúng, 2: đã trả lời sai

  factory Question.fromMap(Map<String, dynamic> map) {
    final QuestionStatus questionStatus;
    switch (map['questionStatus']) {
      case 0:
        questionStatus = QuestionStatus.notAnswered;
        break;
      case 1:
        questionStatus = QuestionStatus.correct;
        break;
      case 2:
        questionStatus = QuestionStatus.wrong;
        break;
      default:
        questionStatus = QuestionStatus.notAnswered;
    }

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
      isHard: map['isHard'] == 1,
      isSaved: map['isSaved'] == 1,
      questionStatus: questionStatus,
    );
  }

  // Hàm này trả về một bản sao của đối tượng Question với một số trường được thay đổi
  Question copyWith({
    int? id,
    String? question,
    List<String>? answers,
    int? correctAnswer,
    String? explanation,
    List<String>? signId,
    String? image,
    int? chapter,
    bool? isFailingPoint,
    bool? isHard,
    bool? isSaved,
    QuestionStatus? questionStatus,
  }) {
    return Question(
      id: id ?? this.id,
      question: question ?? this.question,
      answers: answers ?? this.answers,
      correctAnswer: correctAnswer ?? this.correctAnswer,
      explanation: explanation ?? this.explanation,
      signId: signId ?? this.signId,
      image: image ?? this.image,
      chapter: chapter ?? this.chapter,
      isFailingPoint: isFailingPoint ?? this.isFailingPoint,
      isHard: isHard ?? this.isHard,
      isSaved: isSaved ?? this.isSaved,
      questionStatus: questionStatus ?? this.questionStatus,
    );
  }
}