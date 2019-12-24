import 'package:flutter/material.dart';

class PageNavigator extends StatelessWidget {
  final PageController controller;
  final bool finalPage;
  final bool firstPage;

  PageNavigator(this.controller, {this.finalPage, this.firstPage});

  @override
  Widget build(BuildContext context) {
    final buttonShape = RoundedRectangleBorder(
            borderRadius: BorderRadius.horizontal(
              left: Radius.circular(15),
              right: Radius.circular(15),
            ),
          );
    return ButtonBar(
      alignment: MainAxisAlignment.spaceBetween,
      buttonMinWidth: 100,
      children: <Widget>[
        FlatButton(
          color: Colors.grey,
          textColor: Colors.white,
          child: const Text("Previous"),
          onPressed: () {
            controller.previousPage(
              duration: Duration(milliseconds: 200),
              curve: Curves.easeIn,
            );
          },
          shape: buttonShape,
        ),
        FlatButton(
          color: Colors.blue[800],
          textColor: Colors.white,
          child: const Text("Next"),
          onPressed: () {
            controller.nextPage(
              duration: Duration(milliseconds: 200),
              curve: Curves.easeIn,
            );
          },
          shape: buttonShape,
        ),
      ],
    );
  }
}
