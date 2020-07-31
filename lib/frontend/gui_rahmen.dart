import 'package:dipl_app/frontend/gui_konstanten.dart';
import 'package:dipl_app/frontend/gui_text.dart';
import 'package:flutter/material.dart';

import 'gui_buttons.dart';
import 'gui_pages.dart';

class ExpandableInnerRahmen extends StatefulWidget {
  final List<Widget> children;

  const ExpandableInnerRahmen({this.children});

  @override
  _ExpandableInnerRahmenState createState() => _ExpandableInnerRahmenState();
}

class _ExpandableInnerRahmenState extends State<ExpandableInnerRahmen>
    with SingleTickerProviderStateMixin {
  bool _isExpanded;
  AnimationController _controller;
  Animation<double> _heightFactor;

  void _handleTap() {
    setState(() {
      _isExpanded = !_isExpanded;
      if (_isExpanded) {
        _controller.forward();
      } else {
        _controller.reverse().then<void>((void value) {
          if (!mounted) return;
          setState(() {});
        });
      }
      PageStorage.of(context)?.writeState(context, _isExpanded);
    });
  }

  @override
  void initState() {
    _controller =
        AnimationController(duration: Duration(milliseconds: 200), vsync: this);
    _heightFactor = _controller.drive(CurveTween(curve: Curves.easeIn));
    _isExpanded = PageStorage.of(context)?.readState(context) ?? false;
    if (_isExpanded) _controller.value = 1.0;
    super.initState();
  }

  Widget _buildChildren(BuildContext context, Widget child) {
    return Column(children: [
      Row(children: [
        Expanded(child: Container()),
        Text('Öffentlich', style: Schrift()),
        SizedBox(width: 30),
        CustomToggleButton(
          size: 70,
          value: false,
          onTap: () => _handleTap(),
        ),
        Expanded(child: Container())
      ]),
      Teiler(),
      AnimatedOpacity(
          duration: Duration(milliseconds: 200),
          curve: Curves.easeIn,
          opacity: _isExpanded ? 1 : 0,
          child: ClipRect(
              child: Align(heightFactor: _heightFactor.value, child: child))),
      Teiler(height: _isExpanded ? 20 : 0)
    ]);
  }

  @override
  Widget build(BuildContext context) {
    final bool closed = !_isExpanded && _controller.isDismissed;
    return AnimatedBuilder(
        animation: _controller.view,
        builder: _buildChildren,
        child: closed
            ? null
            : Container(
                width: double.infinity,
                child: Align(
                    alignment: Alignment.centerLeft,
                    child: Rahmen(children: widget.children ?? [], shadow: false))));
  }
}

// ###################################################################

class ExpandableRahmen extends StatefulWidget {
  // @formatter:off
  final String       header;
  final String       bottomHeader;
  final List<Widget> childrenTop;
  final List<Widget> childrenBottom;
  // @formatter:on

  const ExpandableRahmen( // @formatter:off
      {this.header        = 'Header',
      this.bottomHeader   = 'Header',
      this.childrenTop    = const [],
      this.childrenBottom = const []});
  // @formatter:on

  @override
  State<StatefulWidget> createState() => _ExpandableRahmenState();
}

class _ExpandableRahmenState extends State<ExpandableRahmen>
    with SingleTickerProviderStateMixin {
  // @formatter:off
  bool                _isExpanded;
  AnimationController _controller;
  Animation<double>   _heightFactor;
  List<Widget>        _childrenTop;
  List<Widget>        _childrenBottom;
  // @ormatter:on

  @override
  void initState() { // @formatter:off
    _controller   = AnimationController(duration: Duration(milliseconds: 200), vsync: this);
    _heightFactor = _controller.drive(CurveTween(curve: Curves.easeIn));
    _isExpanded   = PageStorage.of(context)?.readState(context) ?? false;
    if (_isExpanded) _controller.value = 1.0;
    super.initState();
  } // @formatter:on

  void _handleTap() {
    setState(() {
      _isExpanded = !_isExpanded;
      if (_isExpanded) {
        _controller.forward();
      } else {
        _controller.reverse().then<void>((void value) {
          if (!mounted) return;
          setState(() {});
        });
      }
      PageStorage.of(context)?.writeState(context, _isExpanded);
    });
  }

  Widget _buildChildren(BuildContext context, Widget child) {
    _childrenTop = [];
    _childrenTop.addAll([
      Row(children: [
        Text(widget.header, style: Schrift.ueberschrift()),
        Expanded(child: Container()),
        Kreuz(groesse: 0.5, offen: _isExpanded),
        SizedBox(width: 5)
      ]),
      SizedBox(height: 10),
      ...widget.childrenTop,
      ClipRect(child: Align(heightFactor: _heightFactor.value, child: child))
    ]);
    return InkWell(
        onTap: () => _handleTap(),
        child: Rahmen(
            header: BottomHeader(header: widget.bottomHeader),
            children: _childrenTop));
  }

  @override
  Widget build(BuildContext context) {
    final bool closed = !_isExpanded && _controller.isDismissed;

    return AnimatedBuilder(
        animation: _controller.view,
        builder: _buildChildren,
        child: closed
            ? null
            : Container(
            width: double.infinity,
            child: Align(
                alignment: Alignment.centerLeft,
                child: Column(children: widget.childrenBottom))));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

// ###################################################################

class Rahmen extends StatefulWidget {
  final List<Widget> children;
  final Widget header;
  final bool shadow;

  Rahmen({this.children = const [], this.header, this.shadow = true});

  @override
  State<StatefulWidget> createState() => _RahmenState();
}

class _RahmenState extends State<Rahmen> {
  @override
  Widget build(BuildContext context) {
    Widget topWidget = Container(),
        bottomWidget = Container();

    if (widget.header is LoginHeader || widget.header is TopHeader)
      topWidget = widget.header;
    if (widget.header is BottomHeader) bottomWidget = widget.header;

    List<Widget> children = [];
    children.addAll([
      topWidget,
      Padding(
          padding: EdgeInsets.only(bottom: 25, top: 20, left: 11, right: 11),
          child: Column(children: widget.children)),
      bottomWidget
    ]);

    return Container(
        width: double.infinity,
        decoration: BoxDecoration(
            boxShadow: [
              widget.shadow ? BoxShadow(
                  blurRadius: 7,
                  spreadRadius: 0.03,
                  color: Color.fromRGBO(0, 0, 0, 0.18),
                  offset: Offset(3, 3)) : BoxShadow(
                  color: Color.fromRGBO(0, 0, 0, 0))
            ],
            color: Farben.weiss,
            borderRadius: BorderRadius.all(Radius.circular(10)),
            border: Border.all(color: Farben.rahmenFarbe, width: 1)),
        child: Column(children: children));
  }
}

class TerminRahmen extends StatefulWidget {
  final List<Widget> children;

  TerminRahmen({this.children = const []});

  @override
  State<StatefulWidget> createState() => _TerminRahmenState();
}

class _TerminRahmenState extends State<TerminRahmen> {
  bool _offen = false;

  void _oeffnen() {
    setState(() {
      _offen = !_offen;
    });
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        focusColor: Colors.transparent,
        onTap: _oeffnen,
        child: Stack(children: [
          Rahmen(children: widget.children, header: BottomHeader()),
          Positioned(
              right: 15,
              top: 15,
              child: Kreuz(
                offen: _offen,
                groesse: 0.6,
              ))
        ]));
  }
}

class LoginRahmen extends StatelessWidget {
  final List<Widget> children;

  LoginRahmen({this.children});

  @override
  Widget build(BuildContext context) {
    return Rahmen(
      header: LoginHeader(),
      children: children,
    );
  }
}

class LoginHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        height: 80,
        padding: EdgeInsets.only(left: 11),
        decoration: BoxDecoration(
            color: Farben.rot,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(9.5), topRight: Radius.circular(9.5))),
        child: Align(
            alignment: Alignment.centerLeft,
            child: Text('Anmelden', style: Schrift.titel())));
  }
}

class BottomHeader extends StatelessWidget {
  final String header;

  const BottomHeader({this.header = 'Header'});

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Align(
            alignment: Alignment.centerLeft,
            child: Text(header, style: Schrift.titelFooter())),
        height: 45,
        padding: EdgeInsets.only(left: 15),
        width: double.infinity,
        decoration: BoxDecoration(
            color: Farben.gruen, // TODO variabel
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(9.5),
                bottomRight: Radius.circular(9.5))));
  }
}

class TopHeader extends StatelessWidget {
  final Color farbe, rahmen, textfarbe;
  final String text;

  const TopHeader({this.farbe = Farben.blaugrau,
    this.rahmen = Farben.rahmenFarbe,
    this.textfarbe = Farben.weiss,
    this.text = 'TopHeader'});

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Container(
          padding: EdgeInsets.only(left: 11),
          child: Align(
              alignment: Alignment.centerLeft,
              child: Text(text, style: Schrift.ueberschrift(color: textfarbe))),
          // TODO
          height: 45,
          width: double.infinity,
          decoration: BoxDecoration(
              color: farbe,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(9), topRight: Radius.circular(9)))),
      Container(
          width: double.infinity,
          decoration: BoxDecoration(
              border: Border(
                  top: rahmen == null
                      ? BorderSide.none
                      : BorderSide(color: rahmen))))
    ]);
  }
}

class Kreuz extends StatefulWidget {
  final bool offen;
  final Duration duration = Duration(milliseconds: 250);
  final double groesse;

  Kreuz({this.offen = false, this.groesse = 1});

  @override
  State<StatefulWidget> createState() => _KreuzState();
}

class _KreuzState extends State<Kreuz> with TickerProviderStateMixin {
  AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.duration,
      vsync: this,
    );
  }

  @override
  void didUpdateWidget(Kreuz oldWidget) {
    if (widget.offen) {
      _controller.forward();
    } else {
      _controller.reverse();
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 60 * widget.groesse,
        width: 60 * widget.groesse,
        child: Align(
            alignment: Alignment.center,
            child: Stack(children: [
              RotationTransition(
                  turns: Tween(begin: 0.0, end: 0.5).animate(_controller),
                  child: Stack(children: [
                    Align(
                        alignment: Alignment.center,
                        child: AnimatedContainer(
                          color: Farben.rot,
                          height: widget.offen ? 0 : 50 * widget.groesse,
                          width: 11.5 * widget.groesse,
                          duration: widget.duration,
                        )),
                    Align(
                        alignment: Alignment.center,
                        child: Container(
                          color: Farben.rot,
                          height: 11.5 * widget.groesse,
                          width: 50 * widget.groesse,
                        ))
                  ]))
            ])));
  }
}
