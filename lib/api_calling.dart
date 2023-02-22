import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

String API_URL1 =
    'https://api-inference.huggingface.co/models/Aditya02/stt_en_citrinet_1024';
const header1 = {
  "Authorization": "Bearer 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"
};

String API_URL2 =
    'https://api-inference.huggingface.co/models/Aditya02/Speech_Analyzer_Model';
const header2 = {
  "Authorization": "Bearer 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"
};

String API_URL3 =
    'https://api-inference.huggingface.co/models/vennify/t5-base-grammar-correction';
const header3 = {
  "Authorization": "Bearer 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"
};

// String API_URL4='https://api.openai.com/v1/engines/text-davinci-002/completions';
const API_KEY = "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";
const header4 = {
  "Content-Type": "application/json",
  "Authorization": "Bearer $API_KEY"
};

const API_KEY2 = "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";
const header5 = {
  "Content-Type": "application/json",
  "Authorization": 'Bearer $API_KEY2'};

Future<String> query(String filename) async {
  final bytes = await File(filename).readAsBytes();
  final response =
      await http.post(Uri.parse(API_URL1), headers: header1, body: bytes);
  return response.body;
}

Future<String> query2(String payload) async {
  final response = await http.post(Uri.parse(API_URL2),
      headers: header2, body: jsonEncode(payload));
  return response.body;
}

Future<String> query3(String payload) async {
  final response = await http.post(Uri.parse(API_URL3),
      headers: header3, body: jsonEncode(payload));
  return response.body;
}

Future<String> query4(String prompt) async {
  final response =
      await http.post(Uri.https("api.openai.com", "/v1/completions"),
          headers: header4,
          body: jsonEncode({
            "model": "code-davinci-002",
            "prompt": prompt,
            "temperature": 0,
           "max_tokens":200,
            'top_p': 1,
            'frequency_penalty': 0.0,
            'presence_penalty': 0.0
          }));
  return response.body;
}

Future<String> query5(String prompt) async {
  final response =
      await http.post(Uri.https("api.openai.com", "/v1/completions"),
          headers: header5,
          body: jsonEncode({
            "model": "text-davinci-003",
            "prompt": "Correct this to standard english:\n\n$prompt",
            "temperature": 0,
           "max_tokens":200,
            'top_p': 1,
            'frequency_penalty': 0.0,
            'presence_penalty': 0.0
          }));
  return response.body;
}

Future<String> query6(String prompt) async {
  final response =
      await http.post(Uri.https("api.openai.com", "/v1/completions"),
          headers: header5,
          body: jsonEncode({
            "model": "text-davinci-003",
            "prompt": "Rate this from 1 to 10 and suggest some improvisations:\n\n$prompt",
            "temperature": 0,
           "max_tokens":200,
            'top_p': 1,
            'frequency_penalty': 0.0,
            'presence_penalty': 0.0
          }));
  return response.body;
}