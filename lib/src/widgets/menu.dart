import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:provider/provider.dart';

import 'package:odee_front/src/cross/cross.dart';
import 'package:odee_front/src/models/menu.model.dart';
import 'package:odee_front/src/providers/auth.provider.dart';

import 'package:odee_front/src/widgets/widgets.dart';

class Menu extends StatelessWidget {
  const Menu({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authP = Provider.of<AuthProvider>(context);
    return Drawer(
      width: 250,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 15.0),
        child: Column(
          children: [
            Expanded(
              child: ListView(
                padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                children: [
                  const SizedBox(
                    height: 150,
                    child: DrawerHeader(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage("assets/png/logo.png"),
                          fit: BoxFit.scaleDown,
                        ),
                      ),
                      child: null,
                      margin: EdgeInsets.only(bottom: 0.0),
                      padding: EdgeInsets.only(bottom: 0.0),
                    ),
                  ),
                  ..._listMenu(context),
                ],
              ),
            ),
            SizedBox(
              width: 136.0,
              height: 40,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100.0),
                  ),
                  alignment: Alignment.center,
                ),
                onPressed: (() async {
                  await authP.logOut(context);
                }),
                child: Wrap(
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    const Icon(Icons.logout),
                    Text(translate("button.getout")),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<MenuModel> get listmenu => routesMenu;

  List<Widget> _listMenu(BuildContext context) {
    List<Widget> menu = [];
    routesMenu.forEach((rm) {
      menu.add(ListTile(
        title: Text(rm.title),
      ));
      menu.addAll(rm.menuOptions
          .map(
            (e) => ListTile(
              title: IconText(
                textAfterIcon: translate(e.name),
                icon: e.icon,
                finalIcon: Icons.keyboard_arrow_right,
              ),
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => e.page,
                  ),
                );
              },
            ),
          )
          .toList());
    });
    return menu;
  }
}
