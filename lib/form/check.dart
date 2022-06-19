class Check {
  late String? type;
  late int? value;

  Check({this.type, this.value});

  Check.fromJson(Map<dynamic, dynamic> json) {
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