import 'package:covid19_zim/app/services/api_keys.dart';
import 'package:flutter/foundation.dart';

enum EndPoint { cases, casesSuspected, casesConfirmed, deaths, recovered }

class API {
  API({@required this.apiKey});
  final String apiKey;
  factory API.sandbox() => API(apiKey: APIKeys.ncovSandboxKey);
  static final String hostname = "ncov2019-admin.firebaseapp.com";

  Uri tokenUri() => Uri(scheme: 'https', host: hostname, path: 'token');
  Uri endpointUri(EndPoint endPoint) =>
      Uri(scheme: 'https', host: hostname, path: _paths[endPoint]);
  static Map<EndPoint, String> _paths = {
    EndPoint.cases: 'cases',
    EndPoint.casesConfirmed: 'casesConfirmed',
    EndPoint.casesSuspected: 'casesSuspected',
    EndPoint.deaths: 'deaths',
    EndPoint.recovered: 'recovered'
  };
}
