import 'dart:async';
import 'dart:convert' as convert;
import 'dart:io';
// import 'package:list_car/util/http_helper.dart' as http;
import 'package:http/http.dart';
import 'package:path/path.dart' as path;

import '../login/api_response.dart';

class UploadApi {
  static Future<ApisResponse<String>> upload(File file) async {
    try {
      String url = "https://carros-springboot.herokuapp.com/api/v1/upload";

      List<int> imageBytes = file.readAsBytesSync();
      String base64Image = convert.base64Encode(imageBytes);

      String fileName = path.basename(file.path);

      var params = {
        "fileName": fileName,
        "mimeType": "image/jpeg",
        "base64": base64Image
      };

      String json = convert.jsonEncode(params);

      print("http.upload: " + url);
      print("params: " + json);

      final response = await post(Uri.parse(url), body: json).timeout(
            Duration(seconds: 120),
            onTimeout: _onTimeOut,
          );

      print("http.upload << " + response.body);

      Map<String, dynamic> map = convert.json.decode(response.body);

      String urlFoto = map["url"];

      return ApisResponse.ok(urlFoto);
    } catch (error, exception) {
      print("Erro ao fazer upload $error - $exception");
      return ApisResponse.error("Não foi possível fazer o upload");
    }
  }

  static FutureOr<Response> _onTimeOut() {
    print("timeout!");
    throw SocketException("Não foi possível se comunicar com o servidor.");
  }
}
