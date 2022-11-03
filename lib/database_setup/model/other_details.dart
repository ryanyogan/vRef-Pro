class OtherDetails {
  int? id;
  String? help;
  String? disclaimer;
  String? about;

  OtherDetails(
      {required this.id,
      required this.help,
      required this.disclaimer,
      question,
      required this.about});

  OtherDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    help = json['help'];
    disclaimer = json['disclaimer'];
    about = json['about'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['help'] = this.help;
    data['disclaimer'] = this.disclaimer;
    data['about'] = this.about;
    return data;
  }
}
