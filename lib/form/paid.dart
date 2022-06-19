class Paid {
  late String? type;
  late bool? value;

  Paid({this.type, this.value});

  Paid.fromJson(Map<dynamic, dynamic> json) {
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