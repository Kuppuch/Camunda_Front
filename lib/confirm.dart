import 'dart:convert';
import 'dart:ffi';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:untitled/business/issue.dart';

import 'form/answer.dart';

class Confirm extends StatefulWidget {
  final Answer? answer;
  final Issue? issue;

  const Confirm(this.answer, this.issue, {Key? key}) : super(key: key);

  @override
  State<Confirm> createState() => _ConfirmState();
}

class _ConfirmState extends State<Confirm> {
  bool isChecked = false;
  bool isPaid = false;
  TextEditingController price = TextEditingController();

  void submit() async {
    var url = Uri.parse(
        "http://10.0.2.2:8080/engine-rest/task/${widget.issue!.id.toString()}/submit-form");
    Map valueConfirm = {"value": isChecked};
    Map valueCheck = {"value": price.text};
    Map valuePaid = {"value": isPaid};

    Map<String, dynamic> d = {"confirm": valueConfirm};
    if (widget.issue!.taskDefinitionKey == "Activity_0ffrjn0") {
      d = {"confirm": valueConfirm};
    } else if (widget.issue!.taskDefinitionKey == "Activity_05190a8") {
      d = {"check": valueCheck};
    } else if (widget.issue!.taskDefinitionKey == "Activity_0y8xft1") {
      d = {"paid": valuePaid};
    }

    Map<dynamic, dynamic> data = {
      "variables": d,
      "withVariablesInReturn": true
    };
    var body = json.encode(data);
    print(data);
    print(body);
    var response = await http.post(url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=ISO-8859-1',
        },
        body: body);
    print(response.body);
    final respdata = jsonDecode(response.body);

    if (response.statusCode >= 200 && response.statusCode < 300) {
      Navigator.pop(context);
    }
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
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text("Item: "),
                    widget.answer!.item!.value.toString() == "bolt12"
                        ? const Text("bolt on 12")
                        : widget.answer!.item!.value.toString() == "screw12"
                            ? const Text("screw on 52")
                            : Text(widget.answer!.item!.value.toString()),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text("Count: "),
                    Text(widget.answer!.count!.value.toString()),
                  ],
                ),
              ),
              widget.issue!.taskDefinitionKey == "Activity_0ffrjn0"
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 0, horizontal: 10),
                          child: TextButton(
                            onPressed: () {
                              isChecked = false;
                              submit();
                            },
                            style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.resolveWith(
                                        (state) => Colors.orange),
                                foregroundColor:
                                    MaterialStateProperty.resolveWith(
                                        (state) => Colors.white)),
                            child: const Text("Cancel"),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 0, horizontal: 10),
                          child: TextButton(
                              onPressed: () {
                                isChecked = true;
                                submit();
                              },
                              style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.resolveWith(
                                          (state) => Colors.blue),
                                  foregroundColor:
                                      MaterialStateProperty.resolveWith(
                                          (state) => Colors.white)),
                              child: const Text("Confirm")),
                        ),
                      ],
                    )
                  : widget.issue!.taskDefinitionKey == "Activity_05190a8"
                      ? Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20.0, vertical: 0),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const Text("Set price: "),
                                  SizedBox(
                                    width: 50,
                                    child: TextField(
                                      controller: price,
                                    ),
                                  ),
                                ],
                              ),
                              TextButton(
                                  onPressed: () {
                                    submit();
                                  },
                                  child: const Text("Save"))
                            ],
                          ),
                        )
                      : Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const Text("Cost"),
                                Text(widget.answer!.check!.value.toString())
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 0, horizontal: 10),
                                  child: TextButton(
                                    onPressed: () {
                                      isPaid = false;
                                      submit();
                                    },
                                    style: ButtonStyle(
                                        backgroundColor:
                                        MaterialStateProperty.resolveWith(
                                                (state) => Colors.orange),
                                        foregroundColor:
                                        MaterialStateProperty.resolveWith(
                                                (state) => Colors.white)),
                                    child: const Text("Cancel"),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 0, horizontal: 10),
                                  child: TextButton(
                                      onPressed: () {
                                        isPaid = true;
                                        submit();
                                      },
                                      style: ButtonStyle(
                                          backgroundColor:
                                          MaterialStateProperty.resolveWith(
                                                  (state) => Colors.blue),
                                          foregroundColor:
                                          MaterialStateProperty.resolveWith(
                                                  (state) => Colors.white)),
                                      child: const Text("Pay")),
                                ),
                              ],
                            )
                          ],
                        ),
            ],
          ),
        ));
  }
}
