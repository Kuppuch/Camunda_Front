import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:charset_converter/charset_converter.dart';
import 'package:untitled/confirm.dart';
import 'package:untitled/task.dart';

import 'business/issue.dart';
import 'business/new_issue.dart';
import 'form/answer.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Camunda',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'CAMUNDA IN YOUR PHONE'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Issue?> texts = [];

  @override
  @protected
  @mustCallSuper
  void initState() {
    getList();
  }

  void _incrementCounter() {
    endpoint();
  }

  void endpoint() async {
    // var url = Uri.parse("http://10.0.2.2:8080/user");
    var url = Uri.parse(
        "http://10.0.2.2:8080/engine-rest/process-definition/key/Process_1mdq8a9/start");
    Map data = {};
    var body = json.encode(data);
    print('body: ${body}');
    var response = await http.post(url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: body);
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
    NewIssue issue = NewIssue.fromJson(jsonDecode(response.body));
    print(issue.id);
    // setState(() {
    //   texts.add(issue.id);
    // });
    getList();
  }

  void getList() async {
    texts.clear();
    var url = Uri.parse(
        "http://10.0.2.2:8080/engine-rest/task?withoutTenantId=false&includeAssignedTasks=false&assigned=false&unassigned=false&withoutDueDate=false&withCandidateGroups=false&withoutCandidateGroups=false&withCandidateUsers=false&withoutCandidateUsers=false&active=false&suspended=false&variableNamesIgnoreCase=false&variableValuesIgnoreCase=false");
    var response = await http.get(url, headers: <String, String>{
      'Content-Type': 'application/json; charset=ISO-8859-1',
    });

    final respdata = jsonDecode(response.body);
    Issue? issue;

    for (Map i in respdata) {
      issue = Issue.fromJson(i);
      texts.add(issue);

    }
    setState(() {});
  }

  Future<Issue> getTask(String id) async {
    var url = Uri.parse(
        "http://10.0.2.2:8080/engine-rest/task/$id");
    var response = await http.get(url, headers: <String, String>{
      'Content-Type': 'application/json; charset=ISO-8859-1',
    });

    final respdata = jsonDecode(response.body);
    var issue = Issue.fromJson(respdata);
    return issue;
  }

  Future<Answer> getTaskConfirm(String id) async {
    var url = Uri.parse(
        "http://10.0.2.2:8080/engine-rest/task/$id/form-variables?deserializeValues=true");
    var response = await http.get(url, headers: <String, String>{
      'Content-Type': 'application/json; charset=ISO-8859-1',
    });

    final respdata = jsonDecode(response.body);
    var answer = Answer.fromJson(respdata);
    return answer;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          IconButton(
              onPressed: () {
                getList();
              },
              icon: const Icon(Icons.refresh))
        ],
      ),
      body: Center(
          child: texts.isNotEmpty
              ? ListView.builder(
                  itemCount: texts.length,
                  itemBuilder: (context, i) {
                    return TextButton(
                        onPressed: () {
                          if (texts[i]!.taskDefinitionKey == "Activity_0mr9046") {
                            getTask(texts[i]!.id.toString()).then((value) =>
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Task(value))));
                          } else if (texts[i]!.taskDefinitionKey == "Activity_0ffrjn0") {
                            getTaskConfirm(texts[i]!.id.toString()).then((value) => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Confirm(value, texts[i], ))));
                          } else if (texts[i]!.taskDefinitionKey == "Activity_05190a8") {
                            getTaskConfirm(texts[i]!.id.toString()).then((value) => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Confirm(value, texts[i]))));
                          } else if (texts[i]!.taskDefinitionKey == "Activity_0y8xft1") {
                            getTaskConfirm(texts[i]!.id.toString()).then((value) => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Confirm(value, texts[i]))));
                          }
                        },
                        child: Text(texts[i]!.name.toString()));
                  },
                )
              : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text("Task List is empty"),
                    Text("Try refresh"),
                  ],
                )),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
