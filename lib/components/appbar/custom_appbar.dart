import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:school_life/components/theme/theme_switcher.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar(
    this.title, {
    this.actions,
    this.leading,
    this.elevation = 0,
  });

  final String title;
  final List<Widget> actions;
  final Widget leading;
  final double elevation;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      centerTitle: true,
      brightness: ThemeSwitcher.of(context).brightness,
      backgroundColor: Colors.transparent,
      actions: actions ?? <Widget>[],
      title: Text(
        title,
        style: GoogleFonts.openSans(
          fontWeight: FontWeight.w600,
          textStyle: TextStyle(
            color: Theme.of(context).textTheme.bodyText2.color,
          ),
        ),
      ),
      leading: leading,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(50.0);
}
