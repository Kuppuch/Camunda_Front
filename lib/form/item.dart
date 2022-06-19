class Item {
  late String? type;
  late String? value;

  Item({this.type, this.value});

  Item.fromJson(Map<dynamic, dynamic> json) {
    type = json['type'];
    value = json['value'];
  }

  Map<dynamic, dynamic> toJson() {
    final Map<dynamic, dynamic> data = new Map<dynamic, dynamic>();
    data['type'] = type;
    data['count'] = value;
    return data;
  }
}