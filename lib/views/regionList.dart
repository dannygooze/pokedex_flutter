import 'package:flutter/material.dart';

class RegionList extends StatelessWidget {
  final RegionArguements region;

  RegionList({Key key, @required this.region}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(region.name),
      ),
      body: Center(
        child: RaisedButton(
          child: Text('Region'),
          onPressed: () {
            // Navigate to second route when tapped.
          },
        ),
      ),
    );
  }
}

class RegionArguements {
  final String name;
  final int lowerLimit;
  final int upperLimit;

  RegionArguements(this.name, this.lowerLimit, this.upperLimit);
}
