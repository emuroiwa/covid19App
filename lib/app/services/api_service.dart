import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:covid19_zim/app/services/api.dart';

class APIService {
  APIService(this.api);
  final API api;

  Future<String> getAccessToken() async {
    final res = await http.post(api.tokenUri().toString(),
        headers: {'Authorization': 'Basic ${api.apiKey}'});

    if (res.statusCode == 200) {
      final data = json.decode(res.body);
      final accessToken = data['access_token'];
      if (accessToken != null) {
        return accessToken;
      }
    }
    print(
        'Request ${api.tokenUri()} failed \n Response ${res.statusCode} ${res.reasonPhrase}');
    throw res;
  }
}
