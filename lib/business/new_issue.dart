class NewIssue {
  late String? links;
  late String? id;
  late String? definitionId;
  late String? businessKey;
  late String? caseInstanceId;
  late bool? ended;
  late bool? suspended;
  late bool? tenantId;

  NewIssue({this.links, this.id, this.definitionId, this.businessKey,
    this.caseInstanceId, this.ended, this.suspended, this.tenantId});

  NewIssue.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    definitionId = json['definitionId'];
    businessKey = json['businessKey'];
    caseInstanceId = json['caseInstanceId'];
    ended = json['ended'];
    suspended = json['suspended'];
    tenantId = json['tenantId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['definitionId'] = definitionId;
    data['businessKey'] = businessKey;
    data['caseInstanceId'] = caseInstanceId;
    data['ended'] = ended;
    data['suspended'] = suspended;
    data['tenantId'] = tenantId;
    return data;
  }
}