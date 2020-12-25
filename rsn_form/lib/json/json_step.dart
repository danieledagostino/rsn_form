class JsonStep {

  String title;
  String question;
  String answerType;
  int step;
  List<String> possibileAnswers;

  JsonStep(this.title, this.question, this.answerType, this.step, this.possibileAnswers);

  JsonStep.fromMap(Map<String, dynamic> map) {
    possibileAnswers = List<String>();
    this.title = map['title'];
    this.question = map['question'];
    this.answerType = map['answerType'];
    this.step = map['step'];
    for(int i = 0; i < map['answers'].length; i++){
      possibileAnswers.add(map['answers'][i]);
    }
}