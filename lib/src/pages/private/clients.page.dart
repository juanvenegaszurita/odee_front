import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:odee_front/src/models/models.dart';
import 'package:provider/provider.dart';
import 'package:odee_front/src/utils/utils.dart';
import 'package:odee_front/src/widgets/table_responsive.dart';
import 'package:odee_front/src/widgets/vertical_spacing.dart';
import 'package:odee_front/src/widgets/widgets.dart';
import 'package:odee_front/src/providers/providers.dart';

class ClientsPage extends StatelessWidget {
  static String title = "clients.title";
  static const route = "clients";
  static GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  const ClientsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ClientsProvider(),
      child: ScaffoldGeneric(
        title: translate(title),
        scaffoldKey: ClientsPage.scaffoldKey,
        endDrawer: ClientsClients(),
        body: ClientsBody(scaffoldKey: scaffoldKey),
      ),
    );
  }
}

class ClientsBody extends StatelessWidget {
  const ClientsBody({
    Key? key,
    required this.scaffoldKey,
  }) : super(key: key);

  final GlobalKey<ScaffoldState> scaffoldKey;

  @override
  Widget build(BuildContext context) {
    final cep = Provider.of<ClientsProvider>(context);
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

class ClientsClients extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  ClientsClients({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cep = Provider.of<ClientsProvider>(context);
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
                labelText: translate("clients.nameController"),
              ),
              onSaved: (value) => cep.nameController.text = value!,
              onChanged: (value) => _formKey.currentState?.validate(),
            ),
            TextFormField(
              controller: cep.rutController,
              validator: Validator().notEmpty,
              decoration: InputDecoration(
                filled: true,
                prefixIcon: const Icon(Icons.key),
                labelText: translate("clients.rutController"),
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
                labelText: translate("clients.addressController"),
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
                  value: int.tryParse(cep.businessController.text),
                  elevation: 16,
                  isExpanded: true,
                  hint: Text(translate("clients.businessController")),
                  items: cep.listTF
                      .map<DropdownMenuItem<int>>((BusinessModel value) {
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
                    cep.businessController.text = "${value!}";
                    cep.notifyListeners();
                  },
                ),
              ],
            ),
            cep.typeForm == TypeForm.CREATE
                ? SaveCreateButton<ClientsProvider>(
                    formKey: _formKey,
                    onPressedEnd: () => Navigator.of(context).pop(),
                  )
                : SaveUpdateButton<ClientsProvider>(
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
    final cep = Provider.of<ClientsProvider>(context);
    return TableResponsive<ClientsProvider>(
      provider: cep,
      listTitle: const [
        "table.id",
        "clients.nameController",
        "clients.rutController",
        "clients.addressController",
        "clients.businessController",
        "table.action"
      ],
      haveTitlePorc: const [10, 30, 10, 20, 17, 13],
      fields: const [
        "id",
        "name",
        "rut",
        "address",
        "business.name"
      ],
      onPressedBtnEdit: (i) {
        cep.typeForm = TypeForm.EDIT;
        cep.idController.text = cep.list[i].id.toString();
        cep.nameController.text = cep.list[i].name;
        cep.rutController.text = cep.list[i].rut;
        cep.addressController.text = cep.list[i].address;
        cep.businessController.text = cep.list[i].business_id.toString();
        ClientsPage.scaffoldKey.currentState!.openEndDrawer();
      },
    );
  }
}
