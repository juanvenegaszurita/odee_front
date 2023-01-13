import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';

import 'package:odee_front/src/pages/private/private.dart';
import 'package:odee_front/src/pages/public/public.dart';

import 'package:odee_front/src/services/services.dart';

class CheckAuthPage extends StatelessWidget {
  static const route = "checkAuth";
  
  const CheckAuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    final as = AuthService();
    return Scaffold(
      body: Center(
        child: FutureBuilder(
          future: as.readToken(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Text(translate("loading"));
            }

            if( snapshot.data == "" ) {
              Future.microtask(() {
                Navigator.pushReplacement(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (_, __, ___) => LoginPage(),
                    transitionDuration: const Duration(seconds: 0),
                  ),
                );
              });
            } else {
              Future.microtask(() {
                Navigator.pushReplacement(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (_, __, ___) => const HomePage(),
                    transitionDuration: const Duration(seconds: 0),
                  ),
                );
              });
            }
            return Container();
          },
        ),
      ),
    );
  }
}
