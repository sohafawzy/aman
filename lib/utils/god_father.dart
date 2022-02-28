import 'package:flutter/material.dart';

class GodFather extends StatefulWidget {
  GodFather({this.child});

  final Widget child;

  static void restartApp(BuildContext context) {
    context.findAncestorStateOfType<_GodFatherState>()?.restartApp();
  }

  @override
  _GodFatherState createState() => _GodFatherState();
}

class _GodFatherState extends State<GodFather> {
  Key key = UniqueKey();

  void restartApp() {
    setState(() {
      key = UniqueKey();
    });
  }

  @override
  Widget build(BuildContext context) {
    return KeyedSubtree(
      key: key,
      child: widget.child,
    );
  }
}