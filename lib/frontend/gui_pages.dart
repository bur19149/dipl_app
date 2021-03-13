import 'package:flutter/material.dart';

import 'gui_konstanten.dart';
import 'gui_text.dart';

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

// @formatter:off
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
                  bottom: MediaQuery.of(context).size.height / 4.5))));
  } // @formatter:on
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
// @formatter:off
/// Teilelement
class Teiler extends SizedBox {
  const Teiler({double height = 20, double width = 10, bool buttonTrenner = false, bool rahmenTrenner = false})
      : super(height: buttonTrenner ? 5 : (rahmenTrenner ? 30 : height), width: width);
} // @formatter:on

class CustomSnackbar extends SnackBar {
	final String text;
	final String label;
	final Color backgroundColor;
	final Color textColor;
	final VoidCallback onPressed;

	CustomSnackbar({this.onPressed, this.text, this.backgroundColor = Farben
			.rot, this.label = 'OK', this.textColor = Farben.weiss}) :
				super(
					content: Text(text, style: Schrift(color: Farben.weiss)),
					backgroundColor: backgroundColor,
					behavior: SnackBarBehavior.floating,
					shape: RoundedRectangleBorder(
							borderRadius: BorderRadius.circular(10)),
					action: SnackBarAction(
						onPressed: onPressed ?? () {}, label: label, textColor: textColor,
					));

	static showSnackbar(BuildContext context,
			{onPressed, text, backgroundColor = Farben
					.rot, label = 'OK', textColor = Farben.weiss}) =>
			ScaffoldMessenger.of(context).showSnackBar(CustomSnackbar(
					onPressed: onPressed,
					text: text,
					backgroundColor: backgroundColor,
					label: label,
					textColor: textColor));
}

//class CustomSnackbar extends StatefulWidget {
//
//  final text;
//
//  CustomSnackbar({this.text});
//
//  @override
//  _CustomSnackbarState createState() => _CustomSnackbarState();
//}
//
//class _CustomSnackbarState extends State<CustomSnackbar> {
//
//  @override
//  Widget build(BuildContext context) {
//    return SnackBar(
//      content: Text(widget.text),
//      backgroundColor: Farben.rot,
//      behavior: SnackBarBehavior.floating,
//      shape: RoundedRectangleBorder(
//        borderRadius: BorderRadius.circular(10.0),),
//      action: SnackBarAction(
//        onPressed: () {
//          // Some code to undo the change.
//        }, label: 'OK',textColor: Farben.weiss,
//      ),
//    );
//  }
//}
