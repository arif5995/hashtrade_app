import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Network {
  final String _url = 'https://api.hastrader.com/api';
  var token;
  var id;

  _getToken() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    token = jsonDecode(localStorage.getString('token').toString());
    id = localStorage.getInt('iduser').toString();
    // print (token);
  }

  auth(data, apiURL) async {
    var fullUrl = _url + apiURL;
    return await http.post(Uri.parse(fullUrl),
        body: jsonEncode(data), headers: _setHeaders());
  }

  register(data, apiURL) async {
    var fullUrl = _url + apiURL;
    print("API " + fullUrl);
    print("Dta ${jsonEncode(data)}");
    return await http.post(Uri.parse(fullUrl),
        body: jsonEncode(data), headers: _setHeaders());
  }

  getData(apiURL) async {
    var fullUrl = _url + apiURL;
    await _getToken();
    return await http.get(
      Uri.parse(fullUrl),
      headers: _setHeaders(),
    );
  }

  Future<http.Response> getDataStock(apiURL) async {
    var fullUrl = _url + apiURL;
    await _getToken();
    return await http.get(
      Uri.parse(fullUrl),
      headers: _setHeaders(),
    );
  }

  Future<http.Response> postUpdatePass(data, apiUrl) async {
    await _getToken();
    var fullUrl = _url + apiUrl + "/" + id;
    await _getToken();
    return await http.post(
      Uri.parse(fullUrl),
      body: json.encode(data),
      headers: _setHeaders(),
    );
  }

  Future<http.Response> postDataParam(data, apiUrl) async {
    await _getToken();
    var fullUrl = _url + apiUrl;
    await _getToken();
    return await http.post(
      Uri.parse(fullUrl),
      body: json.encode(data),
      headers: _setHeaders(),
    );
  }

  Future<http.StreamedResponse> postUpdate(data, apiURL, File? file) async {
    var response;
    await _getToken();
    var fullUrl = Uri.parse(_url + apiURL + "/" + id);
    print('URL UPDATE $fullUrl header ${_setHeaders()}');
    try {
      var request = http.MultipartRequest('POST', fullUrl);
      request = _jsonToFormData(request, data);
      request.headers.addAll(_setHeaders());
      if (file != null) {
        request.files
            .add(await http.MultipartFile.fromPath('image', file.path));
      }
      response = await request.send();
      final respon1 = await response.stream.toBytes();
      final respon2 = String.fromCharCodes(respon1);
      print("CEK UPDATE PROFIL $request dan $respon2");
      return response;
    } catch (e) {
      print('ERROR $e');
    }
    return response;
  }

  _jsonToFormData(http.MultipartRequest request, Map<String, dynamic> data) {
    for (var key in data.keys) {
      request.fields[key] = data[key].toString();
    }
    return request;
  }

  postData(apiURL) async {
    var fullUrl = _url + apiURL;
    await _getToken();
    return await http.post(
      Uri.parse(fullUrl),
      headers: _setHeaders(),
    );
  }

  _setHeaders() => {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      };
}
