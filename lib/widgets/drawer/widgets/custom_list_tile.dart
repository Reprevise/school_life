import 'package:flutter/material.dart';

class CustomListTile extends StatefulWidget {
  final IconData icon;
  final Color iconColor;
  final Color textColor;
  final Color topContainerColor;
  final String text;
  final Function onTap;

  const CustomListTile({
    @required this.icon,
    this.iconColor = Colors.black,
    @required this.text,
    @required this.onTap,
    @required this.topContainerColor,
    this.textColor = Colors.black,
  });

  @override
  _CustomListTileState createState() => _CustomListTileState();
}

class _CustomListTileState extends State<CustomListTile> {
  @override
  Widget build(BuildContext context) {

    final Radius roundBorderRadius = const Radius.circular(50);

    return Container(
      decoration: BoxDecoration(
        color: widget.topContainerColor,
        borderRadius: BorderRadius.only(
          topRight: roundBorderRadius,
          bottomRight: roundBorderRadius,
        ),
      ),
      child: InkWell(
        borderRadius: BorderRadius.only(
          topRight: roundBorderRadius,
          bottomRight: roundBorderRadius,
        ),
        onTap: widget.onTap,
        child: Container(
          height: 55,

          child: Padding(
            padding: EdgeInsets.only(left: 15),
            child: Row(
              children: <Widget>[
                Icon(
                  widget.icon,
                  color: widget.iconColor,
                ),
                Padding(
                  padding: EdgeInsets.all(15.0),
                  child: Text(
                    widget.text,
                    style: Theme.of(context)
                        .textTheme
                        .display1
                        .copyWith(color: widget.textColor),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
