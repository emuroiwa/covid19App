import 'package:covid19_zim/app/services/api.dart';
import 'package:flutter/foundation.dart';

import '../services/api.dart';

class EndpointsData {
  EndpointsData({@required this.values});
  final Map<EndPoint, int> values;
  int get cases => values[EndPoint.cases];
  int get casesSuspected => values[EndPoint.casesSuspected];
  int get casesConfirmed => values[EndPoint.casesConfirmed];
  int get deaths => values[EndPoint.deaths];
  int get recovered => values[EndPoint.recovered];

  String toString() => 'cases:$cases, suspected $casesSuspected';

}
