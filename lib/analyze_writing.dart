import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'api_calling.dart';

class WritingBuddy extends StatefulWidget {
  WritingBuddy({Key? key}) : super(key: key);

  @override
  State<WritingBuddy> createState() => _WritingBuddyState();
}

class _WritingBuddyState extends State<WritingBuddy> {
  final codeController = TextEditingController();
  late var code;
  late dynamic explained;
  bool isText = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Center(child: Text('Writing Buddy')),
        backgroundColor: const Color.fromARGB(255, 198, 18, 91),
        elevation: 0.0,
      ),
      body: Center(
        child: Container(
          child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
            Container(
              padding: const EdgeInsets.all(30),
              height: 120.0,
              
              child: Expanded(
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: TextField(
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    controller: codeController,
                    decoration: InputDecoration(
                        hintText: "Paste your text here",
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: const BorderSide(
                            color: Color.fromRGBO(50, 59, 63, 1),
                            width: 1.0,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: const BorderSide(
                            color: Color.fromRGBO(50, 59, 63, 1),
                            width: 1.0,
                          ),
                        ),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30))),
                  ),
                ),
              ),
            ),
            
            Row(
              children: [
                SizedBox(width: 30,),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      minimumSize: const Size(160, 50),
                      primary: const Color.fromARGB(255, 198, 18, 91),
                      onPrimary: Colors.white),
                  child: const Text('Grammify'),
                  onPressed: () async {
                    try {
                      code = await query5(codeController.text);
                      print(code);
                      isText = true;
                    } catch (e) {
                      isText = false;
                      Get.snackbar("about User", "user message",
                          backgroundColor: Colors.redAccent,
                          snackPosition: SnackPosition.BOTTOM,
                          titleText: const Text(
                            "Failed! Try again",
                            style: TextStyle(color: Colors.white),
                          ),
                          messageText: Text(e.toString(),
                              style: const TextStyle(color: Colors.white)));
                    }
                    explained = json.decode(code);
                    setState(() {});
                  },
                ),
                SizedBox(width: 20,),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      minimumSize: const Size(160, 50),
                      primary: const Color.fromARGB(255, 198, 18, 91),
                      onPrimary: Colors.white),
                  child: const Text('Suggestions'),
                  onPressed: () async {
                    try {
                      code = await query6(codeController.text);
                      print(code);
                      isText = true;
                    } catch (e) {
                      isText = false;
                      Get.snackbar("about User", "user message",
                          backgroundColor: Colors.redAccent,
                          snackPosition: SnackPosition.BOTTOM,
                          titleText: const Text(
                            "Failed! Try again",
                            style: TextStyle(color: Colors.white),
                          ),
                          messageText: Text(e.toString(),
                              style: const TextStyle(color: Colors.white)));
                    }
                    explained = json.decode(code);
                    setState(() {});
                  },
                ),
              ],
            ),
            Center(
              child: Container(
                padding: const EdgeInsets.all(30),
                height: 300.0,
                child: Expanded(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Text(
                      (isText)
                          ? explained["choices"][0]["text"]
                          : '',
                      style: const TextStyle(
                        fontSize: 20,
                        // fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:flutter/src/widgets/container.dart';
// import 'package:flutter/src/widgets/framework.dart';

// class WritingBuddy extends StatefulWidget {
//   const WritingBuddy({super.key});

//   @override
//   State<WritingBuddy> createState() => _WritingBuddyState();
// }

// class _WritingBuddyState extends State<WritingBuddy> {
//   @override
//   Widget build(BuildContext context) {
//     double w = MediaQuery.of(context).size.width;
//     double h = MediaQuery.of(context).size.height;
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Writing Buddy'),
//         centerTitle: true,
//         backgroundColor: Color.fromARGB(255, 198, 18, 91),
//       ),
      
//       body: Column(
//         children: [
//           SizedBox(height: 25,),
//           Container(
//             margin: EdgeInsets.only(left: 20, right: 20),
//             height: h*0.07,
//             width: w,
//             child: TextField(
//               keyboardType: TextInputType.multiline,
//               maxLines: null,
//                   decoration: InputDecoration(
//                       hintText: "write your text here",
//                       focusedBorder: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(30),
//                         borderSide: const BorderSide(
//                           color: Colors.white,
//                           width: 1.0,
//                         ),
//                       ),
//                       enabledBorder: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(30),
//                         borderSide: const BorderSide(
//                           color: Colors.white,
//                           width: 1.0,
//                         ),
//                       ),
//                       border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(30))),
//                 ),),
//                 SizedBox(height: 25,),
//                 Container(
//                   width: w * 0.25,
//                   height: h * 0.060,
//                   decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(35),
//                       image: const DecorationImage(
//                           image: AssetImage("img/gradient (2).png"),
//                           fit: BoxFit.cover)),
//                   child: const Center(
//                     child: Text(
//                       "submit",
//                       style: TextStyle(
//                         fontSize: 20,
//                         fontWeight: FontWeight.bold,
//                         color: Colors.white
//                 ),
//               ),
//             ),
//           ),
                
//           ])
//         ,
//       )

//     ;
//   }
// }