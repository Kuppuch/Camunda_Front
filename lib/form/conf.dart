class Conf {
  late String? type;
  late bool? value;

  Conf({this.type, this.value});

  Conf.fromJson(Map<dynamic, dynamic> json) {
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