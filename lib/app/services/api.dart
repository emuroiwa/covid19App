import 'package:covid19_zim/app/services/api_keys.dart';
import 'package:flutter/foundation.dart';

class API {
  API({@required this.apiKey});
  final String apiKey;
  factory API.sandbox() => API(apiKey: APIKeys.ncovSandboxKey);
  static final String hostname = "ncov2019-admin.firebaseapp.com";

  Uri tokenUri() => Uri(scheme: 'https', host: hostname, path: 'token');
}
