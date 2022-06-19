class Response {
  late int? status;
  late String? body;

  Response({this.status, this.body});

  Response.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    body = json['body'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['body'] = this.body;
    return data;
  }
}
