class Answer {
  int step;
  String title;
  String question;
  String value;

  Answer(this.step, this.title, this.question, this.value);

  Map<String, dynamic> toMap() {
    return {'step': step, 'title': title, 'question': question, 'value': value};
  }

  Answer.fromMap(Map<String, dynamic> map) {
    this.step = map['step'];
    this.title = map['title'];
    this.question = map['question'];
    this.value = map['value'];
  }

  @override
  String toString() {
    return "[step: $step, title: $title, question: $question, value: $value]";
  }
}
