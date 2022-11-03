class QuestionDetails {
  int id = 0;
  int systemId = 0;
  String question = "";
  String answer = "";
  String description = "";
  String? image = "";

  QuestionDetails(
      {required this.systemId,
      required this.question,
      required this.answer,
      required this.description,
      this.image});

  QuestionDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    question = json['question'];
    answer = json['answer'];
    description = json['description'];
    systemId = json['system_id'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['question'] = this.question;
    data['answer'] = this.answer;
    data['description'] = this.description;
    data['system_id'] = this.systemId;
    data['image'] = this.image;
    return data;
  }
}
