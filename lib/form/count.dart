class Count {
  late String? type;
  late int? value;

  Count({this.type, this.value});

  Count.fromJson(Map<dynamic, dynamic> json) {
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