import 'package:flutter/material.dart';

import 'package:odee_front/src/providers/providers.dart';
import 'package:odee_front/src/utils/utils.dart';
import 'package:odee_front/src/widgets/vertical_spacing.dart';
import 'package:odee_front/src/widgets/widgets.dart';

import 'package:flutter_translate/flutter_translate.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});
  static String title = "login.title";
  static const route = "login";
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final authP = Provider.of<AuthProvider>(context);
    return ScaffoldGeneric(
      withAppBar: false,
      maxWidth: PageUtils.xsMax,
      body: Form(
        key: _formKey,
        child: SizedBox(
          height: PageUtils.height(context),
          child: authP.loadLogin
              ? const Loading()
              : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    TextFormField(
                      controller: authP.emailController,
                      validator: Validator().email,
                      decoration: InputDecoration(
                        filled: true,
                        prefixIcon: const Icon(Icons.email),
                        labelText: translate("login.emailController"),
                      ),
                      onSaved: (value) => authP.emailController.text = value!,
                      onChanged: (value) => _formKey.currentState?.validate(),
                    ),
                    const VerticalSpace(),
                    TextFormField(
                      controller: authP.passwordController,
                      validator: Validator().password,
                      obscureText: true,
                      decoration: InputDecoration(
                        filled: true,
                        prefixIcon: const Icon(Icons.password),
                        labelText: translate("login.passwordController"),
                      ),
                      onSaved: (value) =>
                          authP.passwordController.text = value!,
                      onChanged: (value) => _formKey.currentState?.validate(),
                    ),
                    const VerticalSpace(),
                    ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          await authP.login(context);
                        }
                      },
                      child: Text(translate("button.getinto")),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
