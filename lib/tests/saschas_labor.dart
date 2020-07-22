import 'package:dipl_app/frontend/gui_text.dart';
import 'package:dipl_app/main.dart';
import 'package:flutter/material.dart';

class SaschasLabor extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SaschasLaborState();
}

class _SaschasLaborState extends State<SaschasLabor> {
  @override
  Widget build(BuildContext context) {
    return TempSeite(children: [
      TextTemplate(text: 'Ich bin ein Löwenzahn!',)
          ]);
  }
}