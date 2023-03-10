import 'dart:convert';
import 'package:chat_bot/src/model/open_ai_model.dart';
import 'package:http/http.dart' as http;

const _key = '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';

class ApiCallAI {
  static Future<List<Choice>> getRoboResponse({required String message}) async {
    var headers = {
      'Authorization': 'Bearer $_key',
      'Content-Type': 'application/json'
    };
    var request = http.Request(
        'POST', Uri.parse('https://api.openai.com/v1/completions'));
    request.body =
        json.encode({"model": "text-davinci-002", "prompt": message});

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var json = jsonDecode(await response.stream.bytesToString());
      var _data = OpenAiModel.fromJson(json);
      // print(json);
      return _data.choices;
    } else {
      // print(response.reasonPhrase);
    }
    return [];
  }

  static Future<String> getRoboResponseImage({required String message}) async {
    String imageUrl = '';
    var headers = {
      'Authorization': 'Bearer $_key',
      'Content-Type': 'application/json'
    };
    var request = http.Request(
        'POST', Uri.parse('https://api.openai.com/v1/images/generations'));
    request.body = json.encode({"prompt": message, "n": 1, "size": "256x256"});

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var json = jsonDecode(await response.stream.bytesToString());
      imageUrl = json['data'][0]['url'];
      return imageUrl;
    } else {
      // print(response.reasonPhrase);
    }
    return imageUrl;
  }
}
