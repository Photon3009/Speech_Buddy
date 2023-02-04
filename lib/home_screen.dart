import 'package:flutter/material.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'dart:async';
import 'package:permission_handler/permission_handler.dart';
import 'dart:convert';
import 'package:avatar_glow/avatar_glow.dart';
import 'api_calling.dart';
import 'nav_drawer.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  final recorder = FlutterSoundRecorder();
  final audioPlayer = AssetsAudioPlayer();
  late AnimationController _controller;
  late Animation<double> _animation;
  bool isRecorderReady = false;
  bool isPlaying = false;
  int counter = 1;
  late final path;
  late String speechtoT;
  bool isText = false;
  bool isText2 = true;
  late Map text2;

  Future convert() async {
    text2 = json.decode(speechtoT);
    if (text2.containsKey('error')) {
      isText2 = false;
    }
  }

  late String filePath = 'speech${counter.toString()}';

  Future record() async {
    if (!isRecorderReady) return;
    await recorder.startRecorder(toFile: filePath);
  }

  Future stop() async {
    if (!isRecorderReady) return;
    path = await recorder.stopRecorder();
    print('Recorded audio file: $path');
  }

  Future startPlaying() async {
    audioPlayer.open(Audio.file(path), autoStart: true, showNotification: true);
    print('Audio is playing');
    isPlaying = true;
  }

  Future stopPlaying() async {
    audioPlayer.stop();
    isPlaying = false;
  }

  @override
  void initState() {
    super.initState();
    initRecorder();
  }

  @override
  void dispose() {
    recorder.closeRecorder();
    super.dispose();
  }

  Future initRecorder() async {
    final status = await Permission.microphone.request();
    final status2 = await Permission.storage.request();
    await Permission.manageExternalStorage;
    if (status != PermissionStatus.granted) {
      throw 'Microphone permission not granted';
    }
    if (status2 != PermissionStatus.granted) {
      throw 'Storage permission not granted';
    }
    await recorder.openRecorder();
    isRecorderReady = true;
    print('begin');
    recorder.setSubscriptionDuration(const Duration(milliseconds: 500));
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );
    _controller.addListener(() {
      setState(() {});
    });
    _controller.repeat();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Center(child: Text('Speech Buddy')),
        backgroundColor: const Color.fromARGB(255, 198, 18, 91),
        elevation: 0.0,
      ),
      drawer: NavigationDrawer(input: isText ? speechtoT : "Record First"),
      body: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Container(
            height: 400.0,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color.fromARGB(255, 198, 18, 91),
                  Color.fromARGB(255, 60, 7, 25)
                ],
              ),
              borderRadius: BorderRadius.vertical(
                bottom:
                    Radius.elliptical(MediaQuery.of(context).size.width, 100.0),
              ),
            ),
            child: recorder.isRecording
                ? Center(
                    child: Container(
                      child: AvatarGlow(
                          animate: recorder.isRecording,
                          repeat: true,
                          endRadius: 80,
                          duration: const Duration(milliseconds: 1000),
                          glowColor: Colors.white,
                          child: const Text("Recording",
                              style: TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white))),
                    ),
                  )
                : Center(
                    child: Container(
                        child: const Text("Start recording",
                            style: TextStyle(
                                fontSize: 40,
                                fontWeight: FontWeight.bold,
                                color: Colors.white))),
                  ),
          ),
          const SizedBox(
            height: 30,
          ),
          ElevatedButton(
            // ignore: sort_child_properties_last
            child: Icon(
              recorder.isRecording ? Icons.stop : Icons.mic,
              size: 50,
            ),
            style: ElevatedButton.styleFrom(
                primary: const Color.fromARGB(255, 198, 18, 91),
                onPrimary: Colors.white),
            onPressed: () async {
              if (recorder.isRecording) {
                await stop();
              } else {
                await record();
              }
              setState(() {});
            },
          ),
          const SizedBox(
            height: 20,
          ),
          ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
                minimumSize: const Size(175, 50),
                primary: Colors.white,
                onPrimary: Colors.black),
            icon: Icon(
              isPlaying ? Icons.stop : Icons.play_arrow,
              size: 50,
            ),
            label: Text(isPlaying ? 'Stop Playing' : 'Play Recording'),
            onPressed: () async {
              if (isPlaying) {
                await stopPlaying();
              } else {
                await startPlaying();
              }
              setState(() {});
            },
          ),
          const SizedBox(
            height: 20,
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
                minimumSize: const Size(175, 50),
                primary: Colors.white,
                onPrimary: Colors.black),
            child: const Text('Convert to Text'),
            onPressed: () async {
              speechtoT = await query(path);
              convert();
              isText = true;
              setState(() {});
            },
          ),
          const SizedBox(
            height: 20,
          ),
          Center(
            child: Container(
              padding: const EdgeInsets.all(30),
                height: 150.0,
              child: Expanded(
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Text(
                    isText
                        ? (isText2 ? text2["text"] : '${text2['error']}') : "Nothing to Show",
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          )
        ]),
      ),
    );
  }
}