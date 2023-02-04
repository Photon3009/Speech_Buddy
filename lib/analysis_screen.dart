import 'dart:convert';
import 'package:flutter/material.dart';
import 'api_calling.dart';


class AnalysisPage extends StatefulWidget {
  String input;
  AnalysisPage({Key? key, required this.input}) : super(key: key);

  @override
  State<AnalysisPage> createState() => _AnalysisPageState();
}

class _AnalysisPageState extends State<AnalysisPage> {
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
        title: const Center(child: Text('Speech Analysis')),
        backgroundColor: const Color.fromARGB(255, 198, 18, 91),
        elevation: 0.0,
      ),
      body: Center(
        child: Container(
            padding: const EdgeInsets.all(20),
            child:
                Column(mainAxisAlignment: MainAxisAlignment.start, children: [
              isText
                  ? isText2
                      ? ConstrainedBox(
                          constraints: const BoxConstraints(
                            minHeight: 35.0,
                            maxHeight: 700.0,
                          ),
                          child: ListView.builder(
                              itemCount: text2.length,
                              shrinkWrap: true,
                              itemBuilder: (BuildContext context, int i) {
                                return 
                                 
                               Card(elevation:3,
                                      
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20),
                                       ),
                                      // child: Container(
                                        color:  Colors.white,
                                        // padding: const EdgeInsets.all(15),
                                        child: Padding(
                                          padding: const EdgeInsets.all(15.0),
                                          child: Column(children: [
                                      
                                            Row(
                                              children: [
                                                const Text(
                                                  "  Entity Group :",
                                                  style: TextStyle(
                                                      fontSize: 20,
                                                      color: Colors.black),
                                                ),
                                                const SizedBox(
                                                  width: 20,
                                                ),
                                                Text(
                                                  isText2
                                                      ? (text2[i]["entity_group"] ==
                                                              null)
                                                          ? 'Null'
                                                          : text2[i]["entity_group"]
                                                      : "Nothing to Show",
                                                  style:  const TextStyle(
                                                      fontSize: 20,
                                                      fontWeight: FontWeight.bold,
                                                      color: Colors.black,)
                                                ),
                                              ],
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            
                                            Row(
                                              children: [
                                                const Text(
                                                  "  Word :",
                                                  style: TextStyle(
                                                      fontSize: 20,
                                                      color: Colors.black),
                                                ),
                                                const SizedBox(
                                                  width: 7,
                                                ),
                                                Container(
                                                  width: 200,
                                                  child: Text(
                                                    isText2
                                                        ?((i == 0)
                                                            ?(text2.length==1)? text2[i]["word"]
                                                                .substring(
                                                                15,text2[i]["word"].length-3
                                                              ):text2[i]["word"]
                                                                .substring(
                                                                15,
                                                              )
                                                            : (i ==
                                                                    text2.length -
                                                                        1)
                                                                ? text2[i]["word"]
                                                                    .substring(
                                                                        0, text2[i]["word"].length-3)
                                                                : text2[i]["word"])
                                                        : "Nothing to Show",
                                                    style: TextStyle(
                                                        fontSize: 18,
                                                        fontWeight: FontWeight.bold,
                                                        color: (text2[i]["entity_group"] ==
                                                              'Fluent')?Color.fromARGB(255, 29, 101, 31):Color.fromARGB(255, 203, 17, 4)),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                          ]),
                                        ),
                                      
                                );
                              }))
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
                      child: const Text('Click to Analyze'),
                      onPressed: () async {
                        data = await query2(widget.input);
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
              ),
            ])),
      ),
    );
  }
}
