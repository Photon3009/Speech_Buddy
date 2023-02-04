import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

String API_URL1='https://api-inference.huggingface.co/models/Aditya02/stt_en_citrinet_1024';
// const header1={"Authorization":"Bearer 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"};
const header1={"Authorization":"Bearer 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"};

String API_URL2='https://api-inference.huggingface.co/models/Aditya02/Speech_Analyzer_Model';
const header2={"Authorization":"Bearer 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"};

String API_URL3='https://api-inference.huggingface.co/models/vennify/t5-base-grammar-correction';
const header3={"Authorization":"Bearer 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"};

Future<String> query(String filename) async{
  final bytes=await File(filename).readAsBytes();
 final response=await http.post(Uri.parse(API_URL1),headers: header1,body:bytes);
 return response.body;
 }

Future<String> query2(String payload) async{
   final response = await http.post(Uri.parse(API_URL2), headers: header2, body: jsonEncode(payload));
 return response.body;
 }

Future<String> query3(String payload) async{
   final response = await http.post(Uri.parse(API_URL3), headers: header3, body: jsonEncode(payload));
 return response.body;
 }