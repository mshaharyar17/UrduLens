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
          textAlign: TextAlign.center,
          maxLines: null,
          initialValue: ModalRoute.of(context).settings.arguments,
          style: TextStyle(fontSize: 24),
          decoration: InputDecoration(
              border: InputBorder.none, hintText: "Recognition Output"),
        )));
  }
}
