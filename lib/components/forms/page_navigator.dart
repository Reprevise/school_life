import 'package:flutter/material.dart';

class PageNavigator extends StatelessWidget {
  const PageNavigator(
    this.controller, {
    this.isFinalPage = false,
    this.isFirstPage = false,
    this.onSubmit,
  });

  final PageController controller;
  final bool isFinalPage;
  final bool isFirstPage;
  final VoidCallback onSubmit;

  @override
  Widget build(BuildContext context) {
    const RoundedRectangleBorder buttonShape = RoundedRectangleBorder(
      borderRadius: BorderRadius.horizontal(
        left: Radius.circular(15),
        right: Radius.circular(15),
      ),
    );

    Widget buildNextButton() {
      return FlatButton(
        color: Colors.blue[900],
        textColor: Colors.white,
        child: const Text('Next'),
        onPressed: () {
          controller.nextPage(
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeIn,
          );
        },
        shape: buttonShape,
      );
    }

    Widget buildPreviousButton() {
      return FlatButton(
        color: Colors.grey,
        textColor: Colors.white,
        child: const Text('Previous'),
        onPressed: () {
          controller.previousPage(
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeIn,
          );
        },
        shape: buttonShape,
      );
    }

    Widget buildSubmitButton() {
      return FlatButton(
        color: Colors.blue[900],
        textColor: Colors.white,
        child: const Text('Submit'),
        onPressed: onSubmit,
        shape: buttonShape,
      );
    }

    return ButtonBar(
      alignment:
          isFirstPage ? MainAxisAlignment.end : MainAxisAlignment.spaceBetween,
      buttonMinWidth: 100,
      buttonHeight: 35,
      children: <Widget>[
        Visibility(
          visible: !isFirstPage,
          child: buildPreviousButton(),
          maintainSize: true,
          maintainAnimation: true,
          maintainState: true,
        ),
        if (isFinalPage) buildSubmitButton() else buildNextButton(),
      ],
    );
  }
}
