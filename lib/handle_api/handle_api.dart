import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

class HttpHelper {
  /// object
  static Future<Map<String, dynamic>?> invokeHttp(dynamic url, RequestType type,
      {Map<String, String>? headers, dynamic body,Encoding? encoding}) async {
    http.Response response;
    Map<String, dynamic>? responseBody;
    try {
      response = await _invoke(url, type,
          headers: getHeaders(headers),
          body: body,
          encoding: Encoding.getByName("utf-8")
      );
    } catch (error) {
      rethrow;
    }
    if (response.body.isEmpty) return null;
    responseBody = jsonDecode(utf8.decode(response.bodyBytes));
    return responseBody;
  }

  static Future<http.Response> _invoke(dynamic url, RequestType type,
      {Map<String, String>? headers, dynamic body, Encoding? encoding}) async {
    http.Response response;

    try {
      switch (type) {
        case RequestType.get:
          response = await http.get(url, headers: headers);
          break;
        case RequestType.post:
          response = await http.post(url,
              headers: headers, body: body, encoding: encoding);
          break;
        case RequestType.put:
          response = await http.put(url,
              headers: headers, body: body, encoding: encoding);
          break;
        case RequestType.delete:
          response = await http.delete(url, headers: headers);
          break;
      }
      // check for any errors
      if (response.statusCode == 200) {
        Map<String, dynamic> body = jsonDecode(response.body);
      }
      return response;
    } on http.ClientException {
      // handle any 404's
      rethrow;

      // handle no internet connection
    } on SocketException catch (e) {
      throw Exception(e.osError?.message);
    } catch (error) {
      rethrow;
    }
  }

  static Map<String, String> getHeaders(Map<String, String>? headers) {
    Map<String, String>? customizeHeaders;
    if (headers != null) {
      customizeHeaders = headers;
    } else {
      customizeHeaders = {
        "Content-Type": "application/json",
        "Accept": "application/json",
       // "Authorization": "Bearer " + Global.mToken
      };
    }
    return customizeHeaders;
  }
}
enum RequestType {get, post, put, delete }