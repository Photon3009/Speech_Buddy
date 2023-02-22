import 'package:flutter/material.dart';
import 'package:speech_buddy2/analyze_writing.dart';

import 'auth_controller.dart';
import 'code_screen.dart';
import 'home_screen.dart';

class Home1Page extends StatefulWidget {
  Home1Page({Key? key}) : super(key: key);

  @override
  State<Home1Page> createState() => _Home1PageState();
}

class _Home1PageState extends State<Home1Page> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
           Container(
                height: MediaQuery.of(context).size.height*0.3,
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                  image: AssetImage("img/images/wavygradient6.png"),
                  fit: BoxFit.fill,
                )),
              ),

          Center(
          child: Container(
              child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 185,
              ),
              Container(
                height: 200,
                width: 200,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                  image: AssetImage("img/images/logo2sb-removebg-preview.png"),
                  fit: BoxFit.fill,
                )),
              ),
              const Text(
                'My Buddy',
                style: TextStyle(
                    fontSize: 40,
                    color: Color.fromARGB(255, 153, 32, 81),
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 70,
              ),
              ElevatedButton.icon(
                icon: Icon(Icons.multitrack_audio_rounded,size: 40,),
                style: ElevatedButton.styleFrom(
                    minimumSize: const Size(250, 60),
                    primary: const Color.fromARGB(255, 198, 18, 91),
                    onPrimary: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0))),
                label: const Text('   Speech Buddy',style: TextStyle(fontSize: 20),),
                onPressed: () async {
                  Navigator.pop(context);
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const MyHomePage(title: '')));
                },
              ),
              const SizedBox(
                height: 30,
              ),
              ElevatedButton.icon(
                icon: Icon(Icons.menu_book_rounded,size: 40,),
                style: ElevatedButton.styleFrom(
                    minimumSize: const Size(250, 60),
                    primary: const Color.fromARGB(255, 198, 18, 91),
                    onPrimary: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0))),
                label: const Text('   Writing Buddy',style: TextStyle(fontSize: 20),),
                onPressed: () async {
                  // Navigator.pop(context);
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => WritingBuddy()));
                },
              ),
              const SizedBox(
                height: 30,
              ),
              ElevatedButton.icon(
                icon: Icon(Icons.code_rounded,size: 40,),
                style: ElevatedButton.styleFrom(
                    minimumSize: const Size(250, 60),
                    primary: const Color.fromARGB(255, 198, 18, 91),
                    onPrimary: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0))),
                label: const Text('  Code Buddy   ',style: TextStyle(fontSize: 20),),
                onPressed: () async {
                  // Navigator.pop(context);
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) => CodePage()));
                },
              ),
               const SizedBox(
                height: 30,
              ),
                ElevatedButton(
                
                style: ElevatedButton.styleFrom(
                    minimumSize: const Size(170, 40),
                    primary:  Colors.grey[300],
                    onPrimary: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0))),
                child: const Text('  Sign Out   ',style: TextStyle(fontSize: 20),),
                onPressed: () async {
                AuthController.instance.logOut();
                },
              ),
            ],
          )),
        ),
      ]),
    );
  }
}
