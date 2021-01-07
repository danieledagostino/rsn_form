import 'dart:collection';

class JsonStep {
  String title;
  String question;
  String answerType;
  int step;
  bool mandatory;
  String regex;
  KeyboardType keyboardType;
  LinkedHashMap<String, String> possibileAnswers;

  JsonStep(this.title, this.question, this.answerType, this.step,
      this.mandatory, this.regex, this.keyboardType, this.possibileAnswers);

  JsonStep.fromMap(Map<String, dynamic> map) {
    possibileAnswers = LinkedHashMap<String, String>();
    this.title = map['title'];
    this.question = map['question'];
    this.answerType = map['answerType'];
    this.step = map['step'];
    this.mandatory = map['mandatory'] == '1';
    this.regex = (map['regex'] ?? '');
    this.keyboardType = (map['keyboard_type'] == 'text')
        ? KeyboardType.text
        : KeyboardType.numeric;
    if (map['answers'] != null) {
      map['answers'].forEach((e) => {
            possibileAnswers.putIfAbsent(
                e['answer'].toString(), () => e['value'].toString())
          });
    }
  }
}

enum KeyboardType { text, numeric }
