import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:odee_front/src/models/models.dart';
import 'package:provider/provider.dart';
import 'package:odee_front/src/utils/utils.dart';
import 'package:odee_front/src/widgets/table_responsive.dart';
import 'package:odee_front/src/widgets/vertical_spacing.dart';
import 'package:odee_front/src/widgets/widgets.dart';
import 'package:odee_front/src/providers/providers.dart';

class BusinessPage extends StatelessWidget {
  static String title = "business.title";
  static const route = "business";
  static GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  const BusinessPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => BusinessProvider(),
      child: ScaffoldGeneric(
        title: translate(title),
        scaffoldKey: BusinessPage.scaffoldKey,
        endDrawer: FormBusiness(),
        body: BusinessBody(scaffoldKey: scaffoldKey),
      ),
    );
  }
}

class BusinessBody extends StatelessWidget {
  const BusinessBody({
    Key? key,
    required this.scaffoldKey,
  }) : super(key: key);

  final GlobalKey<ScaffoldState> scaffoldKey;

  @override
  Widget build(BuildContext context) {
    final cep = Provider.of<BusinessProvider>(context);
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

class FormBusiness extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  FormBusiness({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cep = Provider.of<BusinessProvider>(context);
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
                prefixIcon: const Icon(Icons.person),
                labelText: translate("business.nameController"),
              ),
              onSaved: (value) => cep.nameController.text = value!,
              onChanged: (value) => _formKey.currentState?.validate(),
            ),
            TextFormField(
              controller: cep.businessNameController,
              validator: Validator().notEmpty,
              decoration: InputDecoration(
                filled: true,
                prefixIcon: const Icon(Icons.business),
                labelText: translate("business.businessNameController"),
              ),
              onSaved: (value) => cep.businessNameController.text = value!,
              onChanged: (value) => _formKey.currentState?.validate(),
            ),
            TextFormField(
              controller: cep.rutController,
              validator: Validator().notEmpty,
              decoration: InputDecoration(
                filled: true,
                prefixIcon: const Icon(Icons.key),
                labelText: translate("business.rutController"),
              ),
              onSaved: (value) => cep.rutController.text = value!,
              onChanged: (value) => _formKey.currentState?.validate(),
            ),
            TextFormField(
              controller: cep.addressController,
              validator: Validator().notEmpty,
              decoration: InputDecoration(
                filled: true,
                prefixIcon: const Icon(Icons.map),
                labelText: translate("business.addressController"),
              ),
              onSaved: (value) => cep.addressController.text = value!,
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
                  value: int.tryParse(cep.userController.text),
                  elevation: 16,
                  isExpanded: true,
                  hint: Text(translate("business.userController")),
                  items: cep.listTF
                      .map<DropdownMenuItem<int>>((UserModel value) {
                    return DropdownMenuItem<int>(
                      value: value.id,
                      child: Row(
                        children: [
                          Text(value.name),
                        ],
                      ),
                    );
                  }).toList(),
                  onChanged: (Object? value) {
                    cep.userController.text = "${value!}";
                    cep.notifyListeners();
                  },
                ),
              ],
            ),
            cep.typeForm == TypeForm.CREATE
                ? SaveCreateButton<BusinessProvider>(
                    formKey: _formKey,
                    onPressedEnd: () => Navigator.of(context).pop(),
                  )
                : SaveUpdateButton<BusinessProvider>(
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
    final cep = Provider.of<BusinessProvider>(context);
    return TableResponsive<BusinessProvider>(
      provider: cep,
      listTitle: const [
        "table.id",
        "business.nameController",
        "business.businessNameController",
        "business.rutController",
        "business.addressController",
        "business.userController",
        "table.action"
      ],
      haveTitlePorc: const [10, 20, 20, 10, 10, 17, 13],
      fields: const [
        "id",
        "name",
        "business_name",
        "rut",
        "address",
        "users.name"
      ],
      onPressedBtnEdit: (i) {
        cep.typeForm = TypeForm.EDIT;
        cep.idController.text = cep.list[i].id.toString();
        cep.nameController.text = cep.list[i].name;
        cep.businessNameController.text = cep.list[i].business_name;
        cep.rutController.text = cep.list[i].rut;
        cep.rutController.text = cep.list[i].rut;
        cep.addressController.text = cep.list[i].address;
        cep.userController.text = cep.list[i].users_id.toString();
        BusinessPage.scaffoldKey.currentState!.openEndDrawer();
      },
    );
  }
}
