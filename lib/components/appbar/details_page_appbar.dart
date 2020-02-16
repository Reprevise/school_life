import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:school_life/util/color_utils.dart';

class DetailsPageAppbar extends StatelessWidget {
  const DetailsPageAppbar(this.title, this.backgroundColor, {Key key})
      : super(key: key);

  final String title;
  final Color backgroundColor;

  Brightness getForegroundBrightness() {
    if (ColorUtils().useWhiteForeground(backgroundColor)) {
      return Brightness.dark;
    }
    return Brightness.light;
  }

  Color getIconThemeColor() {
    if (!ColorUtils().useWhiteForeground(backgroundColor)) {
      return Colors.black;
    }
    return Colors.white;
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
      flexibleSpace: FlexibleSpaceBar(
        title: Text(
          title,
          style: GoogleFonts.openSans(
            fontWeight: FontWeight.w600,
            textStyle: TextStyle(
              color: getIconThemeColor(),
            ),
          ),
        ),
      ),
    );
  }
}
