import 'package:dipl_app/tests/christians_spielwiese.dart';
import 'package:dipl_app/tests/dominiks_testgelaende.dart';
import 'package:dipl_app/tests/saschas_labor.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'orgApp',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Center(
      child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image.network('https://i.makeagif.com/media/9-18-2015/30s1Uo.gif', width: double.infinity),
                TempButton(
                    text: 'App-Baustelle',
                    onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => TempSeite(
                                  children: [
                                    Text('Wird noch ausgelagert'),
                                    Text(
                                        'Hier kommt später dann die fertige GUI hin')
                                  ],
                                )))),
                TempButton(
                    text: 'Testgelände',
                    onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => TempSeite(
                                  children: [
                                    TempButton(
                                      text: 'Saschas Labor',
                                      onPressed: () => Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  SaschasLabor())),
                                    ),
                                    TempButton(
                                      text: 'Dominiks Testgelände',
                                      onPressed: () => Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  DominiksTestgelaende())),
                                    ),
                                    TempButton(
                                      text: 'Christians Spielwiese',
                                      onPressed: () => Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                ChristiansSpielwiese())),
                                    )
                                  ],
                                ))))
              ])),
    )));
  }
}

class TempButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  TempButton({@required this.text, @required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: double.infinity,
        child: RaisedButton(
          onPressed: onPressed,
          child: Text(text),
        ));
  }
}

class TempSeite extends StatefulWidget {
  final List<Widget> children;

  TempSeite({this.children = const <Widget>[]});

  @override
  State<StatefulWidget> createState() => _TempSeiteState();
}

class _TempSeiteState extends State<TempSeite> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Center(
      child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: widget.children)),
    )));
  }
}
