class PlaneCategories {
  int? id;
  String name = "";

  PlaneCategories({this.id, required this.name});

  PlaneCategories.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
}

class ImageModel {
  int? id;
  int? question_id;
  String? image;

  ImageModel({this.id, this.question_id, this.image});

  ImageModel.fromJson(Map<String, dynamic> map) {
    id = map['id'];
    question_id = map['question_id'];
    image = map['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['question_id'] = this.question_id;
    data['image'] = this.image;
    return data;
  }
}
