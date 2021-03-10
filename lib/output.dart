import 'package:flutter/material.dart';

class Output extends StatelessWidget {
  static final String route = '/output';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Urdu Text'),
        ),
        body: Center(
            child: TextFormField(
          decoration: InputDecoration(
              border: InputBorder.none, hintText: 'Output Text Shown Here'),
        )));
  }
}
