import 'package:dipl_app/frontend/gui_konstanten.dart';
import 'package:flutter/material.dart';
import 'package:dipl_app/main.dart';

class SaschasLabor extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SaschasLaborState();
}

class _SaschasLaborState extends State<SaschasLabor> {
  @override
  Widget build(BuildContext context) {
    return TempSeite(children: [CustomDropDownButton()]);
  }
}

class CustomDropDownButton extends StatefulWidget {
  @override
  _CustomDropDownButtonState createState() => _CustomDropDownButtonState();
}

class _CustomDropDownButtonState extends State<CustomDropDownButton> {
  @override
  bool istAusgeklappt = false;

  //TODO width border: Border.all(color: Farben.rahmenFarbe, width: 1) durch Variable ersetzen!

  Widget build(BuildContext context) {
    double radius = istAusgeklappt ? 0 : 10;
    return Container(
        width: double.infinity,
        height: 40,
        child: Stack(children: [
          AnimatedContainer(
              duration: Duration(seconds: 1),
              height: 40,
              width: double.infinity,
              decoration: BoxDecoration(
                  color: Colors.amber, //TODO white
                  border: Border.all(color: Farben.rahmenFarbe, width: 1),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                      bottomLeft: Radius.circular(radius),
                      bottomRight: Radius.circular(radius)))),
          Align(
              alignment: Alignment.centerRight,
              child: AnimatedContainer(
                duration: Duration(seconds: 1),
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                    color: Colors.red, //TODO white
                    border: Border.all(color: Farben.rahmenFarbe, width: 1),
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(10), bottomRight: Radius.circular(radius))),
                child: Stack(
                  children: [
                    Align(
                        alignment: Alignment.center,
                        child: Container(
                            height: 15,
                            width: 15,
                            color: Colors.green) //TODO Platzhalter für die Animation
                        )
                  ],
                ),
              )),
          AnimatedContainer(
              duration: Duration(seconds: 1),
              height: 40,
              width: double.infinity,
              decoration: BoxDecoration(
            //      color: istAusgeklappt ? Colors.black : Colors.purple,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                      bottomLeft: Radius.circular(radius),
                      bottomRight: Radius.circular(radius))),
              child: InkWell(
                onTap: () => handleDropDown(),
                // child: Container(
                //   height: double.infinity,
                //   width: double.infinity,
                // ),
              ))
        ]));
  }

  handleDropDown() {
    setState(() {
      istAusgeklappt = !istAusgeklappt;
    });
  }
}
