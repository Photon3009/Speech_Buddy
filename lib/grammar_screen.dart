import 'dart:convert';
import 'package:flutter/material.dart';
import 'api_calling.dart';

class GrammarPage extends StatefulWidget {
  String input;
  GrammarPage({Key? key, required this.input}) : super(key: key);

  @override
  State<GrammarPage> createState() => _GrammarPageState();
}

class _GrammarPageState extends State<GrammarPage> {
  bool isText = false;
  bool isText2 = false;
  late String data;
  late dynamic text2;
  late dynamic text3;

  Future convert2() async {
    text2 = json.decode(data);
    isText2 = true;
    if (text2.containsKey('error')) {
      isText2 = false;
    }
  }

  Future convert3() async {
    text3 = json.decode(widget.input);
  }

  check() {
    if (text2 == null) {
      isText2 = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Center(child: Text('Grammar Suggestion')),
          backgroundColor: const Color.fromARGB(255, 198, 18, 91),
          elevation: 0.0,
        ),
        body: Center(
          child: Container(
              padding: const EdgeInsets.all(30),
              child:
                  Column(mainAxisAlignment: MainAxisAlignment.start, children: [
                isText
                    ? isText2
                        ? Container(
                            child: Card(
                                elevation: 5,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                color: Colors.white,
                                child: Container(
                                    padding: const EdgeInsets.all(15),
                                    child: Column(children: [
                                      Row(
                                        children: [
                                          const Text(
                                            "Suggestion :",
                                            style: TextStyle(
                                                fontSize: 20,
                                                color: Colors.black),
                                          ),
                                          const SizedBox(
                                            width: 20,
                                          ),
                                          Container(
                                            width: 190,
                                            child: Text(
                                              text2[0]["generated_text"]
                                                  // .substring(
                                                  //     1,
                                                  //     text2[0]["generated_text"]
                                                  //             .length -
                                                  //         2)
                                                          ,
                                              style: const TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black),
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                    ]))))
                        : Container(
                            padding: const EdgeInsets.all(25),
                            child: const Text(
                              "Some error found, please try again later!",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ))
                    : ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            minimumSize: const Size(175, 50),
                            primary: const Color.fromARGB(255, 198, 18, 91),
                            onPrimary: Colors.white),
                        child: const Text('Click for Grammar Suggestions'),
                        onPressed: () async {
                          data = await query3(widget.input);
                          convert2();
                          convert3();
                          isText = true;
                          if (text3["text"] == null) {
                            isText = false;
                          }
                          check();
                          setState(() {});
                        },
                      ),
                const SizedBox(
                  height: 30,
                )
              ])),
        ));
  }
}
