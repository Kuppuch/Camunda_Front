class Issue {
  late String? id;
  late String? name;
  late String? executionId;
  late String? created;
  late String? processDefinitionId;
  late String? processInstanceId;
  late String? taskDefinitionKey;
  late int? priority;

  Issue({this.id, this.name, this.executionId, this.created, this.priority,
    this.processDefinitionId, this.processInstanceId, this.taskDefinitionKey});

  Issue.fromJson(Map<dynamic, dynamic> json) {
    id = json['id'];
    name = json['name'];
    executionId = json['executionId'];
    created = json['created'];
    processDefinitionId = json['processDefinitionId'];
    processInstanceId = json['processInstanceId'];
    taskDefinitionKey = json['taskDefinitionKey'];
    priority = json['priority'];
  }

  Map<dynamic, dynamic> toJson() {
    final Map<dynamic, dynamic> data = new Map<dynamic, dynamic>();
    data['id'] = id;
    data['name'] = name;
    data['executionId'] = executionId;
    data['created'] = created;
    data['processDefinitionId'] = processDefinitionId;
    data['processInstanceId'] = processInstanceId;
    data['taskDefinitionKey'] = taskDefinitionKey;
    data['priority'] = priority;
    return data;
  }
}
