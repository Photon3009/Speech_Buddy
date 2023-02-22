// import 'dart:convert';
// import 'dart:io';
// import 'package:http/http.dart' as http;
// import 'package:flutter/foundation.dart';

// final uploadEndpoint = 'https://api.assemblyai.com/v2/upload';
// final transcribeEndpoint = 'https://api.assemblyai.com/v2/transcript';

// Future<String> upload(String filename) async {
//   final chunkSize = 5242880;
//   final headers = {
//     'authorization': '32856a9341434c0fad235039f4671640',
//   };

//   final file = File(filename);
//   // final length = await file.length();
//   // int offset = 0;
//   // final chunks = <List<int>>[];
//   // while (offset < length) {
//   //   final chunk = await file.readAsBytes().catchError((e) => []);
//   //   offset += chunkSize;
//   //   chunks.add(chunk);
//   // }
//   final bytes = await File(filename).readAsBytes();

//   final response1 = await http.post(Uri.parse(uploadEndpoint),
//       headers: headers, body: bytes);
//   final uploadUrl = jsonDecode(response1.body)['upload_url'];

//   final body = {'audio_url': uploadUrl, 'disfluencies': true};
//   final response2 = await http.post(Uri.parse(transcribeEndpoint),
//       headers: headers, body: jsonEncode(body));
//   final id = jsonDecode(response2.body)['id'];
//   final pollingEnd = transcribeEndpoint + '/$id';
//   final response = await http.get(Uri.parse(pollingEnd), headers: headers);
//   return jsonDecode(response.body);
// }
















// Future<String> transcribe(String audioUrl) async {
//   final headers = {
//     'authorization': '32856a9341434c0fad235039f4671640',
//   };
//   final body = {'audio_url': audioUrl, 'disfluencies': true};
//   final response = await http.post(Uri.parse(transcribeEndpoint),
//       headers: headers, body: jsonEncode(body));
//   final id = jsonDecode(response.body)['id'];
//   return id;
// }

// Future<Map<String, dynamic>> getWords(String id) async {
//   final pollingEnd = transcribeEndpoint + '/$id';
//   // final headers = {
//   //   'authorization': '32856a9341434c0fad235039f4671640',
//   // };
//   final response = await http.get(Uri.parse(pollingEnd), headers: headers);
//   return jsonDecode(response.body);
// }

// class TranscribeWords with ChangeNotifier {
//   Map<String, dynamic> _words;

//   Map<String, dynamic> get words => _words;

//   void transcribe(String filename) async {
//     final audioUrl = await upload(filename);
//     final id = await transcribe(audioUrl);
//     _words = await getWords(id);
//     notifyListeners();
//   }
// }
