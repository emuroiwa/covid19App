import 'package:covid19_zim/app/services/api.dart';
import 'package:flutter/material.dart';

class EndpointCard extends StatelessWidget {
  @override
  const EndpointCard({Key key, this.endPoint, this.value}) : super(key: key);
  final EndPoint endPoint;
  final int value;

  static Map<EndPoint, String> _cardTitles = {
    EndPoint.cases: 'cases',
    EndPoint.casesConfirmed: 'Confirmed Cases',
    EndPoint.casesSuspected: 'Suspected Cases',
    EndPoint.deaths: 'Deaths',
    EndPoint.recovered: 'Recovered'
  };

  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                _cardTitles[endPoint],
                style: Theme.of(context).textTheme.headline5,
              ),
              Text(
                value != null ? value.toString() : '',
                style: Theme.of(context).textTheme.headline4,
              )
            ],
          ),
        ),
      ),
    );
  }
}
