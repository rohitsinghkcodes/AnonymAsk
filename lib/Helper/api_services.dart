import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

Future<dynamic> sendMessageToChatGPT(String message) async {
  var apiUrl = 'https://api.openai.com/v1/chat/completions';

  SharedPreferences prefs = await SharedPreferences.getInstance();
  var apiKey = prefs.getString('gptKey');

  var headers = {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer $apiKey',
  };

  var body = {
    'model': 'gpt-3.5-turbo',
    'messages': [
      {'role': 'system', 'content': 'You are a helpful assistant.'},
      {'role': 'user', 'content': message},
    ],
  };

  var response = await http.post(Uri.parse(apiUrl),
      headers: headers, body: json.encode(body));

  if (response.statusCode == 200) {
    var jsonResponse = json.decode(response.body);
    var msg = jsonResponse['choices'][0]['message']['content'];
    return msg;
  }
  // Return an error message if something went wrong
  debugPrint(response.body);
  return 'Oops! Something went wrong.';
}

//getting the api key for chat gpt
Future<void> getApiKey() async {
  String url = 'https://ai-chatty-api-buyn.onrender.com/keys/';
  final response = await http.get(Uri.parse(url));
  try {
    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('gptKey', jsonResponse[0]["key"].toString());
    } else {
      debugPrint(
          'Failed with status: ${response.statusCode}. ${response.reasonPhrase}');
    }
  } on Exception catch (e) {
    debugPrint('Error making request: $e');
  }
}
