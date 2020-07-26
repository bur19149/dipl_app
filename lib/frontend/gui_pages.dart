import 'package:flutter/material.dart';

class ColumnScaffold extends StatefulWidget {
  final List<Widget> children;

  ColumnScaffold({this.children = const <Widget>[]});

  @override
  State<StatefulWidget> createState() => _CustomScaffoldState();
}

class _CustomScaffoldState extends State<ColumnScaffold> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Center(
      child: Padding(
          padding: EdgeInsets.all(15),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: widget.children)),
    )));
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
    return null;
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