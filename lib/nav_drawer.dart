import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:speech_buddy2/graph.dart';
import 'analysis_screen.dart';
import 'auth_controller.dart';
import 'grammar_screen.dart';
import 'home_screen.dart';

class NavigationDrawer extends StatefulWidget {
  String input;
  NavigationDrawer({Key? key, required this.input}) : super(key: key);

  @override
  State<NavigationDrawer> createState() => _NavigationDrawerState();
}

class _NavigationDrawerState extends State<NavigationDrawer> {
  @override
  Widget build(BuildContext context) => Drawer(
        child: SingleChildScrollView(
            child: Column(
          children: [
            buildHeader(context),
            buildMenuItems(context),
          ],
        )),
      );
  Widget buildHeader(BuildContext context) => Container(
        
        padding: EdgeInsets.only(
          top: 24 + MediaQuery.of(context).padding.top,
          bottom: 24,
        ),
        child: Column(
          children: [
            // CircleAvatar(
            //   radius: 52,
            //  backgroundImage:const Image(image: AssetImage("img/images/logo1sb.png")),
            // ),
            Container(
              height: 150,
              width: 150,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                image: AssetImage("img/images/logo1sb-removebg-preview.png"),
                fit: BoxFit.fill,
              )),
            ),
           
            const Text(
              'Speech Buddy',
              style: TextStyle(
                  fontSize: 28,
                  color: Color.fromARGB(255,153, 32, 81),
                  fontWeight: FontWeight.bold),
            )
          ],
        ),
      );
  Widget buildMenuItems(BuildContext context) => Container(
        padding: const EdgeInsets.all(24),
        child: Wrap(
          runSpacing: 16,
          children: [
            ListTile(
              leading: const Icon(Icons.home_outlined),
              title: const Text('Home'),
              onTap: () => {
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) =>
                        const MyHomePage(title: 'Flutter Demo Home Page')))
              },
            ),
            ListTile(
              leading: const Icon(Icons.analytics_outlined),
              title: const Text('Speech Analysis'),
              onTap: () {
                Navigator.pop(context);
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => AnalysisPage(
                          input: widget.input,
                        )));
              },
            ),
            ListTile(
              leading: const Icon(Icons.app_registration_rounded),
              title: const Text('Grammar Suggestions'),
              onTap: () {
                Navigator.pop(context);
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => GrammarPage(
                          input: widget.input,
                        )));
              },
            ),
             ListTile(
              leading: const Icon(Icons.graphic_eq_outlined),
              title: const Text('Visualise Performance'),
              onTap: () {
                 Navigator.pop(context);
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => GraphPer(
                          input: widget.input,
                        )));
              },
            ),
            ListTile(
              leading: const Icon(Icons.account_circle_rounded),
              title: const Text('Sign Out'),
              onTap: () {
                AuthController.instance.logOut();
              },
            ),
          ],
        ),
      );
}
