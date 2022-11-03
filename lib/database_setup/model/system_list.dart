class SystemListModel {
  int id = 0;
  String name = "";
  int status = 0;
  int planeId = 0;

  SystemListModel(
      {required this.planeId, required this.name, required this.status});

  SystemListModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    planeId = json['plane_id'];
    name = json['name'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['plane_id'] = this.planeId;
    data['name'] = this.name;
    data['status'] = this.status;
    return data;
  }
}
