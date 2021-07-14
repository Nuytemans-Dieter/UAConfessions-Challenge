import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ua_confessions/Theme.dart';

class CustomCard extends StatelessWidget {
  final Widget _child;

  CustomCard(this._child);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      child: Container(
        width: double.infinity,
        child: Card(
          color: UATheme.secondaryBackground,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: _child,
        ),
      ),
    );
  }
}
