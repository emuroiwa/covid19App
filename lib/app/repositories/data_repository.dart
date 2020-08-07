import 'package:covid19_zim/app/repositories/endpoints_data.dart';
import 'package:covid19_zim/app/services/api.dart';
import 'package:covid19_zim/app/services/api_service.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart';

class DataRepository {
  DataRepository({@required this.apiService});
  final APIService apiService;
  String _accessToken;

  Future<int> getEndpointData(EndPoint endPoint) async {
    try {
      if (_accessToken == null) {
        _accessToken = await apiService.getAccessToken();
      }
      return await apiService.getEndpointData(
          accessToken: _accessToken, endPoint: endPoint);
    } on Response catch (res) {
      if (res.statusCode == 401) {
        _accessToken = await apiService.getAccessToken();
        return await apiService.getEndpointData(
            accessToken: _accessToken, endPoint: endPoint);
      }
      rethrow;
    }
  }

  Future<EndpointsData> getAllEndpointData() async {
    try {
      if (_accessToken == null) {
        _accessToken = await apiService.getAccessToken();
      }
      return await _getAllEndPointData();
    } on Response catch (res) {
      if (res.statusCode == 401) {
        _accessToken = await apiService.getAccessToken();
        return await _getAllEndPointData();
      }
      rethrow;
    }
  }

  Future<EndpointsData> _getAllEndPointData() async {
    final values = await Future.wait([
      apiService.getEndpointData(
          accessToken: _accessToken, endPoint: EndPoint.cases),
      apiService.getEndpointData(
          accessToken: _accessToken, endPoint: EndPoint.casesConfirmed),
      apiService.getEndpointData(
          accessToken: _accessToken, endPoint: EndPoint.casesSuspected),
      apiService.getEndpointData(
          accessToken: _accessToken, endPoint: EndPoint.deaths),
      apiService.getEndpointData(
          accessToken: _accessToken, endPoint: EndPoint.recovered),
    ]);
    return EndpointsData(values: {
      EndPoint.cases: values[0],
      EndPoint.casesConfirmed: values[1],
      EndPoint.casesSuspected: values[2],
      EndPoint.deaths: values[3],
      EndPoint.recovered: values[4],
    });
  }
}
