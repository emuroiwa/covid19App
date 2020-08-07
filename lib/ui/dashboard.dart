import 'package:covid19_zim/app/repositories/data_repository.dart';
import 'package:covid19_zim/app/services/api.dart';
import 'package:covid19_zim/ui/endpoint_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../app/repositories/endpoints_data.dart';
import '../app/services/api.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  EndpointsData _endpointsData;

  @override
  void initState() {
    super.initState();
    _updateData();
  }

  Future<void> _updateData() async {
    print('object');
    try {
      final dataRepository =
          Provider.of<DataRepository>(context, listen: false);
      final endpointsData = await dataRepository.getAllEndpointData();
      setState(() {
        _endpointsData = endpointsData;
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Covid19 Tracker')),
        body: RefreshIndicator(
          onRefresh: _updateData,
          child: ListView(
            children: <Widget>[
              for (var endpoint in EndPoint.values) 
              EndpointCard(
                endPoint: endpoint,
                value: _endpointsData != null ? 
                _endpointsData.values[endpoint]
                : null,
              )
            ],
          ),
        ));
  }
}
