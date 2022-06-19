class Issue {
  late String? item;
  late String? count;

  Issue({this.item, this.count});

  Issue.fromJson(Map<dynamic, dynamic> json) {
    item = json['item'];
    count = json['count'];
  }

  Map<dynamic, dynamic> toJson() {
    final Map<dynamic, dynamic> data = new Map<dynamic, dynamic>();
    data['item'] = item;
    data['count'] = count;
    return data;
  }
}
