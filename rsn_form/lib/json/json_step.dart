import 'dart:collection';

class JsonStep {
  String title;
  String question;
  String answerType;
  int step;
  LinkedHashMap<String, String> possibileAnswers;

  JsonStep(this.title, this.question, this.answerType, this.step,
      this.possibileAnswers);

  JsonStep.fromMap(Map<String, dynamic> map) {
    possibileAnswers = LinkedHashMap<String, String>();
    this.title = map['title'];
    this.question = map['question'];
    this.answerType = map['answerType'];
    this.step = map['step'];
    map['answers'].forEach((e) => {
          possibileAnswers.putIfAbsent(
              e['answer'].toString(), () => e['value'].toString())
        });
  }
}
