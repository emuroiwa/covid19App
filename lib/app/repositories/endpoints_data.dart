import 'package:covid19_zim/app/services/api.dart';
import 'package:flutter/foundation.dart';

class EndpointsData {
  EndpointsData({@required this.values});
  final Map<EndPoint, int> values;
}
