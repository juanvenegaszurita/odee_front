import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:odee_front/src/pages/private/private.dart';
import 'package:odee_front/src/providers/providers.dart';

import 'package:odee_front/src/utils/page.utils.dart';
import 'package:odee_front/src/widgets/widgets.dart';

import 'package:flutter_translate/flutter_translate.dart';

class ScaffoldGeneric extends StatelessWidget {
  const ScaffoldGeneric({
    super.key,
    required this.body,
    this.title = "",
    this.maxWidth = PageUtils.maxWidth,
    this.border = false,
    this.backgroundColor,
    this.backgroundColorAppBar,
    this.colorTitle,
    this.alignmentTitle = Alignment.center,
    this.elevationTitle = 0,
    this.withAppBar = true,
    this.withMenu = true,
    this.endDrawer,
    this.scaffoldKey,
  });
  final String title;
  final Widget body;
  final double maxWidth;
  final bool border;
  final Color? backgroundColor;
  final Color? backgroundColorAppBar;
  final Color? colorTitle;
  final AlignmentGeometry alignmentTitle;
  final double elevationTitle;
  final bool withAppBar;
  final bool withMenu;
  final Widget? endDrawer;
  final GlobalKey<ScaffoldState>? scaffoldKey;

  @override
  Widget build(BuildContext context) {
    double width = PageUtils.width(context) > maxWidth
        ? maxWidth
        : PageUtils.width(context);
    final ps = Provider.of<SettingProvider>(context);
    //final npp = Provider.of<NotificationPushProvider>(context);
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: backgroundColor ?? Theme.of(context).backgroundColor,
      appBar: withAppBar
          ? AppBar(
              iconTheme: const IconThemeData(),
              backgroundColor: backgroundColorAppBar,
              elevation: elevationTitle,
              title: Center(
                child: Container(
                  alignment: alignmentTitle,
                  width: double.infinity,
                  child: Text(
                    translate(title),
                    style: TextStyle(
                      color: colorTitle,
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              actions: [
                IconsActions(
                  icon: ps.themeMode == ThemeMode.dark
                      ? Icons.nightlight
                      : Icons.sunny,
                  onPressed: ps.changeThemeMode,
                ),
                /* IconsActions(
                  icon: npp.haveNotifications
                      ? Icons.notifications_active
                      : Icons.notifications,
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const NotificationPushPage(),
                      ),
                    );
                  },
                ), */
                const IconsActions(icon: Icons.person),
              ],
            )
          : null,
      drawer: withMenu ? const Menu() : null,
      endDrawer: endDrawer,
      body: SafeArea(
        left: true,
        top: true,
        right: true,
        bottom: true,
        child: Center(
          child: Container(
            alignment: Alignment.topCenter,
            decoration: border
                ? BoxDecoration(border: Border.all(color: Colors.black))
                : const BoxDecoration(),
            width: width,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: body,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class IconsActions extends StatelessWidget {
  const IconsActions({
    Key? key,
    required this.icon,
    this.onPressed,
  }) : super(key: key);

  final IconData icon;
  final Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
          ),
          margin: const EdgeInsets.only(left: 2.5, right: 2.5, top: 2.5),
          height: 40,
          width: 40,
          child: IconButton(onPressed: onPressed, icon: Icon(icon)),
        ),
      ],
    );
  }
}
