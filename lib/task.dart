import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'business/issue.dart';

class Task extends StatefulWidget {
  final Issue? issue;

  const Task(this.issue, {Key? key}) : super(key: key);

  @override
  State<Task> createState() => _TaskState();
}

class _TaskState extends State<Task> {
  Issue? issue;
  String? item;
  int count = 0;
  final countController = TextEditingController();


  Future<Issue> submit() async {
    var url = Uri.parse(
        "http://10.0.2.2:8080/engine-rest/task/${widget.issue!.id.toString()}/submit-form");
    switch (item) {
      case "bolt on 12":
        item = "bolt12";
        break;
      case "screw on 52":
        item = "screw12";
        break;
    }
    Map valueCount = {"value": countController.text};
    Map valueItem = {"value": item};
    Map<String, dynamic> d = {"item": valueItem, "count": valueCount};
    Map<dynamic, dynamic> data = {
      "variables": d,
      "withVariablesInReturn": true
    };
    var body = json.encode(data);
    var response = await http.post(url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=ISO-8859-1',
        },
        body: body);


    final respdata = jsonDecode(response.body);
    var issue = Issue.fromJson(respdata);
    if (response.statusCode >= 200 && response.statusCode < 300) {
      Navigator.pop(context);
    }
    return issue;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.issue!.name.toString()),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            DropdownButton(
              hint: const Text('Please choose a item'),
              // Not necessary for Option 1
              value: item,
              onChanged: (newValue) {
                setState(() {
                  item = newValue as String?;
                });
              },
              items: <String>['bolt on 12', 'screw on 52', 'caliper', 'clutch']
                  .map((String value) {
                return DropdownMenuItem(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            SizedBox(
              width: 300,
              child: TextField(
                controller: countController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter a item count',
                ),
              ),
            ),
            TextButton(
                onPressed: () {
                  if (item!.isNotEmpty) {
                    submit();
                  }
                },
                child: const Text("Save"))
          ],
        ),
      ),
    );
  }
}
