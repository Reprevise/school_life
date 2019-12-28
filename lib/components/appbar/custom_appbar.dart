import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget> actions;
  final Widget leading;

  const CustomAppBar(
    this.title, {
    this.actions,
    this.leading,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      centerTitle: true,
      brightness: DynamicTheme.of(context).brightness,
      backgroundColor: Colors.transparent,
      actions: actions == null ? [] : actions,
      title: Text(
        title,
        style: GoogleFonts.openSans(
          fontWeight: FontWeight.w600,
          textStyle: TextStyle(
            color: Theme.of(context).textTheme.body1.color,
          ),
        ),
      ),
      leading: leading,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(50.0);
}
