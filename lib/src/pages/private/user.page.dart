import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:odee_front/src/models/models.dart';
import 'package:provider/provider.dart';
import 'package:odee_front/src/utils/utils.dart';
import 'package:odee_front/src/widgets/table_responsive.dart';
import 'package:odee_front/src/widgets/vertical_spacing.dart';
import 'package:odee_front/src/widgets/widgets.dart';
import 'package:odee_front/src/providers/providers.dart';

class UserPage extends StatelessWidget {
  static String title = "user.title";
  static const route = "user";
  static GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  const UserPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => UserProvider(),
      child: ScaffoldGeneric(
        title: translate(title),
        scaffoldKey: UserPage.scaffoldKey,
        endDrawer: FormUser(),
        body: UserBody(scaffoldKey: scaffoldKey),
      ),
    );
  }
}

class UserBody extends StatelessWidget {
  const UserBody({
    Key? key,
    required this.scaffoldKey,
  }) : super(key: key);

  final GlobalKey<ScaffoldState> scaffoldKey;

  @override
  Widget build(BuildContext context) {
    final cep = Provider.of<UserProvider>(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        CreateButton(
          onPressed: () {
            cep.typeForm = TypeForm.CREATE;
            cep.clearForm();
            scaffoldKey.currentState!.openEndDrawer();
          },
        ),
        const VerticalSpace(),
        const _Table(),
      ],
    );
  }
}

class FormUser extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  FormUser({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cep = Provider.of<UserProvider>(context);
    final double w =
        PageUtils.width(context) < 500 ? PageUtils.width(context) : 500;
    return Drawer(
      width: w,
      child: Form(
        key: _formKey,
        child: GridResponsive(
          isExternal: false,
          tallaAll: 1,
          children: [
            Text(
              cep.typeForm == TypeForm.CREATE
                  ? translate("crud.create")
                  : translate("crud.update"),
              style: const TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
            TextFormField(
              controller: cep.nameController,
              validator: Validator().notEmpty,
              decoration: InputDecoration(
                filled: true,
                prefixIcon: const Icon(Icons.price_change),
                labelText: translate("user.nameController"),
              ),
              onSaved: (value) => cep.nameController.text = value!,
              onChanged: (value) => _formKey.currentState?.validate(),
            ),
            TextFormField(
              controller: cep.emailController,
              validator: Validator().notEmpty,
              decoration: InputDecoration(
                filled: true,
                prefixIcon: const Icon(Icons.email),
                labelText: translate("user.emailController"),
              ),
              onSaved: (value) => cep.emailController.text = value!,
              onChanged: (value) => _formKey.currentState?.validate(),
            ),
            GridResponsive(
              isExternal: false,
              tallaAll: 2,
              porcAll: const [5, 95],
              rowMainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                const Icon(Icons.extension),
                DropdownButton(
                  value: int.tryParse(cep.roleController.text),
                  elevation: 16,
                  isExpanded: true,
                  hint: Text(translate("user.roleController")),
                  items: cep.listRole
                      .map<DropdownMenuItem<int>>((RoleModel value) {
                    return DropdownMenuItem<int>(
                      value: value.id,
                      child: Row(
                        children: [
                          Text(value.description),
                        ],
                      ),
                    );
                  }).toList(),
                  onChanged: (Object? value) {
                    cep.roleController.text = "${value!}";
                    cep.notifyListeners();
                  },
                ),
              ],
            ),
            cep.typeForm == TypeForm.CREATE
                ? SaveCreateButton<UserProvider>(
                    formKey: _formKey,
                    onPressedEnd: () => Navigator.of(context).pop(),
                  )
                : SaveUpdateButton<UserProvider>(
                    formKey: _formKey,
                    onPressedEnd: () => Navigator.of(context).pop(),
                  ),
            CancelButton(
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        ),
      ),
    );
  }
}

class _Table extends StatelessWidget {
  const _Table({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cep = Provider.of<UserProvider>(context);
    return TableResponsive<UserProvider>(
      provider: cep,
      listTitle: const ["table.id", "user.nameController", "user.emailController", "table.createdAt", "user.roleController", "user.UID", "table.action"],
      haveTitlePorc: const [6, 20, 16, 17, 10, 13, 13],
      fields: const ["id", "name", "email","createdAt", "roles.description", "UID"],
      onPressedBtnEdit: (i) {
        cep.typeForm = TypeForm.EDIT;
        cep.idController.text = cep.list[i].id.toString();
        cep.nameController.text = cep.list[i].name;
        cep.emailController.text = cep.list[i].email;
        cep.roleController.text = cep.list[i].roles_id.toString();
        UserPage.scaffoldKey.currentState!.openEndDrawer();
      },
    );
  }
}
