class Answer {
  int step;
  String question;
  String value;

  Answer(this.step, this.question, this.value);

  Map<String, dynamic> toMap() {
    return {'step': step ?? null, 'question': question, 'value': value};
  }

  Answer.fromMap(Map<String, dynamic> map) {
    this.step = map['step'];
    this.question = map['question'];
    this.value = map['value'];
  }
}
