// import 'package:charts_flutter/flutter.dart';
import 'dart:convert';
import 'package:d_chart/d_chart.dart';
import 'package:flutter/material.dart';
import 'package:speech_buddy2/api_calling.dart';
// import 'package:charts_flutter/flutter.dart' as charts;

class GraphPer extends StatefulWidget {
  String input;
  GraphPer({Key? key, required this.input}) : super(key: key);

  @override
  State<GraphPer> createState() => _GraphPerState();
}

class _GraphPerState extends State<GraphPer> {
  // Map<String, double> dataMap = {
  //   "Fluency": 7,
  //   "Disfluency": 3,
  // };
 
  bool isText = false;
  bool isText2 = false;
  late String data;
  late dynamic text2;
  late dynamic text3;
  num count1 = 0;
  late int fcount;
  late int dcount;

 late var data1 = [
    {'fluency': 'Fluent', 'counts': fcount},
    {'fluency': 'Disfluent', 'counts': dcount}
  ];


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

  countFun() {
    for (int i = 0; i < text2.length; i++) {
      if (text2[i]["entity_group"] == 'Disfluent') {
        count1=count1+text2[i]["word"].split(" ").length;
        // count1++;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Center(child: Text('Visualise Performance')),
        backgroundColor: Colors.pinkAccent[700],
        centerTitle: true,
        elevation: 0.0,
      ),
      body: Center(
        child: Container(
            padding: const EdgeInsets.all(50),
            child: ListView(
              children: [
                isText?
                     isText2? 
                    ConstrainedBox(
                       constraints: const BoxConstraints(
                            minHeight: 35.0,
                            maxHeight: 700.0,
                          ),
                        // aspectRatio: 16 / 9,
                        child: DChartPie(
                            data: data1.map((e) {
                              return {
                                'domain': e['fluency'],
                                'measure': e['counts']
                              };
                            }).toList(),
                            fillColor: (pieData, index) {
                              switch (pieData['domain']) {
                                case 'Fluent':
                                  return Colors.green;
                                case 'Disfluent':
                                  return Colors.red[800];
                                default:
                                  return Colors.blueGrey;
                              }
                            },
                            labelColor: Colors.black,
                            labelPosition: PieLabelPosition.outside,
                            labelFontSize: 10,
                            labelLineColor: Colors.grey,
                            pieLabel:
                                (Map<dynamic, dynamic> pieData, int? index) {
                              return pieData['domain'] +
                                  ':\n' +
                                  pieData['measure'].toString();
                            }),
                      ):Container(
                          padding: const EdgeInsets.all(25),
                          child:  const Text(
                            "Some error found, please try again later!",
                            style: TextStyle (
                              fontSize: 20,
                              fontWeight: FontWeight.bold
                            ),
                          ))
                    : ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            minimumSize: const Size(175, 50),
                            primary: Colors.pinkAccent[700],
                            onPrimary: Colors.white),
                        child: const Text('Click to Analyze'),
                        onPressed: () async {
                          data = await query2(widget.input);
                          convert2();
                          convert3();
                          countFun();
                          fcount=text3["text"].split(" ").length-count1;
                          dcount=int.parse(count1.toString());
                          isText = true;
                          if (text3["text"] == null) {
                            isText = false;
                          }
                          check();
                          setState(() {});
                        },
                      ),
                const SizedBox(height: 16),
                // AspectRatio(
                //     aspectRatio: 16 / 9,
                //     child: Container(
                //       color: Colors.blue,
                //     ))
              ],
            )),
      ),
    );
  }
}
