import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'api_calling.dart';

class CodePage extends StatefulWidget {
  CodePage({Key? key}) : super(key: key);

  @override
  State<CodePage> createState() => _CodePageState();
}

class _CodePageState extends State<CodePage> {
  final codeController = TextEditingController();
  late var code;
  late dynamic explained;
  bool isText = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Center(child: Text('Code Explaination')),
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
                        hintText: "Paste your code here",
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
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  minimumSize: const Size(175, 50),
                  primary: const Color.fromARGB(255, 198, 18, 91),
                  onPrimary: Colors.white),
              child: const Text('Submit'),
              onPressed: () async {
                try {
                  code = await query4(codeController.text);
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
