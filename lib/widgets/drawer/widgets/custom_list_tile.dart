import 'package:flutter/material.dart';

class CustomListTile extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final Color textColor;
  final String text;
  final Function onTap;

  const CustomListTile({
    @required this.icon,
    this.iconColor = Colors.black,
    @required this.text,
    @required this.onTap,
    this.textColor = Colors.black,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.only(
        topRight: Radius.circular(50.0),
        bottomRight: Radius.circular(50.0),
      ),
      onTap: onTap,
      child: Container(
        height: 55,
        child: Padding(
          padding: EdgeInsets.only(left: 15),
          child: Row(
            children: <Widget>[
              Icon(
                icon,
                color: iconColor,
              ),
              Padding(
                padding: EdgeInsets.all(15.0),
                child: Text(
                  text,
                  style: Theme.of(context)
                      .textTheme
                      .display1
                      .copyWith(color: textColor),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
