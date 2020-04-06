import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DetailsPageAppbar extends StatelessWidget {
  const DetailsPageAppbar(this.title, this.backgroundColor);

  final String title;
  final Color backgroundColor;

  Brightness getForegroundBrightness() {
    return ThemeData.estimateBrightnessForColor(backgroundColor);
  }

  Color getIconThemeColor() {
    if (ThemeData.estimateBrightnessForColor(backgroundColor) ==
        Brightness.dark) {
      return Colors.white;
    } else {
      return Colors.black;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      floating: false,
      pinned: true,
      snap: false,
      elevation: 0,
      expandedHeight: 150.0,
      backgroundColor: backgroundColor,
      brightness: getForegroundBrightness(),
      iconTheme: IconThemeData(
        color: getIconThemeColor(),
      ),
      title: Text(
        title,
        style: GoogleFonts.openSans(
          fontWeight: FontWeight.w600,
          textStyle: TextStyle(
            color: getIconThemeColor(),
          ),
        ),
      ),
    );
  }
}
