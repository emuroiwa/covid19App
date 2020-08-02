import 'dart:convert';

import 'package:flutter/foundation.dart';
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

  Future<int> getEndpointData(
      {@required String accessToken, @required EndPoint endPoint}) async {
    final uri = api.endpointUri(endPoint);
    final res = await http.get(uri.toString(),
        headers: {'Authorization': 'Bearer $accessToken '});

    if (res.statusCode == 200) {
      final List<dynamic> data = json.decode(res.body);
      if (data.isNotEmpty) {
        final Map<String, dynamic> endPointData = data[0];
        final String responseJsonKey = _responseJsonKeys[endPoint];
        final int result = endPointData[responseJsonKey];
        if (result != null) {
          return result;
        }
      }
    }
    print(
        'Request ${api.tokenUri()} failed \n Response ${res.statusCode} ${res.reasonPhrase}');
    throw res;
  }

  static Map<EndPoint, String> _responseJsonKeys = {
    EndPoint.cases: 'cases',
    EndPoint.casesConfirmed: 'data',
    EndPoint.casesSuspected: 'data',
    EndPoint.deaths: 'data',
    EndPoint.recovered: 'data'
  };
}
