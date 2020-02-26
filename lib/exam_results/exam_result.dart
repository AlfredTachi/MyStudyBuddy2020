class ExamResult {
  int number;
  String name;
  String term;
  double grade;
  String passed;
  double credits;
  String note;
  int numberOfTries;
  DateTime date;

  ExamResult(int number, String name, String term, double grade, String passed,
      double credits, String note, int numberOfTries, String date) {
    this.number = number;
    this.name = name;
    this.term = term;
    this.grade = grade;
    this.passed = passed;
    this.credits = credits;
    this.note = note;
    this.numberOfTries = numberOfTries;
    this.date = DateTime.tryParse(date);
  }

  Map<String, dynamic> toMap() {
    return {
      'examNumber' : number,
      'examName' : name,
      'term' : term,
      'grade' : grade,
      'passed' : passed,
      'credits' : credits,
      'note' : note,
      'numberOfTries' : numberOfTries,
      'date' : date.toString()
    };
  }

  String toString() {
    return '''
    examNumber: $number
    examName: $name
    grade: $grade
    passed: $passed
    credits: $credits
    note: $note
    numberOfTries: $numberOfTries
    date: $date
    ''';
  }
}
