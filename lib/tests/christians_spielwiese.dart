import 'package:dipl_app/main.dart';
import 'package:flutter/material.dart';

class ChristiansSpielwiese extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ChristiansSpielwieseState();
}

class _ChristiansSpielwieseState extends State<ChristiansSpielwiese> {
  bool change = false;

  void _pressed() {
    setState(() {
      change = !change;
    });
  }

  @override
  Widget build(BuildContext context) {
    return TempSeite(children: [
      Test(
        text: 'huhggn',
      ),
      StatefulContainer(
        color: change ? Colors.red : Colors.blue,
      ),
      RaisedButton(
        onPressed: _pressed,
        child: Text('änder Farbe'),
      )
    ]);
  }
}

class Test extends StatelessWidget {
  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(color: Colors.red, fontFamily: 'Consolas'),
    );
  }

  Test({this.text = 'aba'});
}

class StatefulContainer extends StatefulWidget {
  final Color color;

  StatefulContainer({@required this.color});

  @override
  State<StatefulWidget> createState() => _StatefulContainerState();
}

class _StatefulContainerState extends State<StatefulContainer> {
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      height: 100,
      width: 100,
      color: widget.color, duration: Duration(milliseconds: 500),
    );
  }
}
