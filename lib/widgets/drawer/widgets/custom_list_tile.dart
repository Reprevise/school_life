import 'package:flutter/material.dart';

class CustomListTile extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final Color textColor;
  final Color topContainerColor;
  final String text;
  final Function onTap;

  const CustomListTile({
    @required this.icon,
    @required this.text,
    @required this.onTap,
    @required this.topContainerColor,
    this.iconColor = Colors.black,
    this.textColor = Colors.black,
  });

  @override
  Widget build(BuildContext context) {
    print("custom list tile rebuilding");
    const Radius circularRadius = const Radius.circular(50);
    const BorderRadius roundBorderRadius = const BorderRadius.only(
      topRight: circularRadius,
      bottomRight: circularRadius,
    );
    return InkWell(
      borderRadius: roundBorderRadius,
      onTap: onTap,
      child: Container(
        height: 55,
        decoration: BoxDecoration(
          color: topContainerColor,
          borderRadius: roundBorderRadius,
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 15),
          child: Row(
            children: <Widget>[
              Icon(
                icon,
                color: iconColor,
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
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
