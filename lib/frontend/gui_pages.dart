import 'package:flutter/material.dart';

class ColumnScaffold extends StatefulWidget {
  final List<Widget> children;
  final double top;

  ColumnScaffold({this.children = const <Widget>[], this.top});

  @override
  State<StatefulWidget> createState() => _CustomScaffoldState();
}

class _CustomScaffoldState extends State<ColumnScaffold> {
  @override
  Widget build(BuildContext context) {
    Widget child, column = Column(children: widget.children);
    if (widget.top != null) {
      child = Padding(
          padding: EdgeInsets.only(left: 15, right: 15, top: widget.top),
          child: column);
    } else {
      child =
          Center(child: Padding(padding: EdgeInsets.all(15), child: column));
    }
    return Scaffold(body: SafeArea(child: child));
  }
}

class ListViewScaffold extends StatefulWidget {
  final List<Widget> children;

  ListViewScaffold({this.children = const <Widget>[]});

  @override
  State<StatefulWidget> createState() => _ListViewScaffoldState();
}

class _ListViewScaffoldState extends State<ListViewScaffold> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: ListView(
      children: widget.children,
      padding: EdgeInsets.only(
          left: 15,
          right: 15,
          top: MediaQuery.of(context).size.height / 4.5,
          bottom: MediaQuery.of(context).size.height / 4.5),
    )));
  }
}

class CustomPageView extends StatefulWidget {
  final List<Widget> children;

  CustomPageView({this.children = const <Widget>[]});

  @override
  State<StatefulWidget> createState() => _CustomPageViewState();
}

class _CustomPageViewState extends State<CustomPageView> {
  @override
  Widget build(BuildContext context) {
    return null;
  }
}

/// Teilelement
class Teiler extends SizedBox {
  const Teiler({double height = 20, double width = 10, bool buttonTrenner = false, bool rahmenTrenner = false})
      : super(height: buttonTrenner ? 5 : (rahmenTrenner ? 30 : height), width: width);
}
