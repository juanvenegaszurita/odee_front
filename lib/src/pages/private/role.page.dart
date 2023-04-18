import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:odee_front/src/models/models.dart';
import 'package:provider/provider.dart';
import 'package:odee_front/src/utils/utils.dart';
import 'package:odee_front/src/widgets/table_responsive.dart';
import 'package:odee_front/src/widgets/vertical_spacing.dart';
import 'package:odee_front/src/widgets/widgets.dart';
import 'package:odee_front/src/providers/providers.dart';

class RolePage extends StatelessWidget {
  static String title = "role.title";
  static const route = "role";
  static GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  const RolePage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => RoleProvider(),
      child: ScaffoldGeneric(
        title: translate(title),
        scaffoldKey: RolePage.scaffoldKey,
        endDrawer: FormRole(),
        body: RoleBody(scaffoldKey: scaffoldKey),
      ),
    );
  }
}

class RoleBody extends StatelessWidget {
  const RoleBody({
    Key? key,
    required this.scaffoldKey,
  }) : super(key: key);

  final GlobalKey<ScaffoldState> scaffoldKey;

  @override
  Widget build(BuildContext context) {
    final cep = Provider.of<RoleProvider>(context);
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

class FormRole extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  FormRole({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cep = Provider.of<RoleProvider>(context);
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
              controller: cep.descriptionController,
              validator: Validator().notEmpty,
              decoration: InputDecoration(
                filled: true,
                prefixIcon: const Icon(Icons.price_change),
                labelText: translate("role.descriptionController"),
              ),
              onSaved: (value) => cep.descriptionController.text = value!,
              onChanged: (value) => _formKey.currentState?.validate(),
            ),
            cep.typeForm == TypeForm.CREATE
                ? SaveCreateButton<RoleProvider>(
                    formKey: _formKey,
                    onPressedEnd: () => Navigator.of(context).pop(),
                  )
                : SaveUpdateButton<RoleProvider>(
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
    final cep = Provider.of<RoleProvider>(context);
    return TableResponsive<RoleProvider>(
      provider: cep,
      listTitle: const ["Id", "description", "Acciones"],
      haveTitlePorc: const [20, 67, 13],
      fields: const ["id", "description"],
      onPressedBtnEdit: (i) {
        cep.typeForm = TypeForm.EDIT;
        cep.idController.text = cep.list[i].id.toString();
        cep.descriptionController.text = cep.list[i].description;
        RolePage.scaffoldKey.currentState!.openEndDrawer();
      },
    );
  }
}
