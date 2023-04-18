import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:provider/provider.dart';
import 'package:odee_front/src/utils/utils.dart';
import 'package:odee_front/src/widgets/table_responsive.dart';
import 'package:odee_front/src/widgets/vertical_spacing.dart';
import 'package:odee_front/src/widgets/widgets.dart';
import 'package:odee_front/src/providers/providers.dart';

class TypeFilePage extends StatelessWidget {
  static String title = "typeFile.title";
  static const route = "typeFile";
  static GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  const TypeFilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => TypeFileProvider(),
      child: ScaffoldGeneric(
        title: translate(title),
        scaffoldKey: TypeFilePage.scaffoldKey,
        endDrawer: FormTypeFile(),
        body: TypeFileBody(scaffoldKey: scaffoldKey),
      ),
    );
  }
}

class TypeFileBody extends StatelessWidget {
  const TypeFileBody({
    Key? key,
    required this.scaffoldKey,
  }) : super(key: key);

  final GlobalKey<ScaffoldState> scaffoldKey;

  @override
  Widget build(BuildContext context) {
    final cep = Provider.of<TypeFileProvider>(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        CreateButton(
          onPressed: () {
            cep.typeForm = TypeForm.CREATE;
            cep.clearForm();
            TypeFilePage.scaffoldKey.currentState!.openEndDrawer();
          },
        ),
        const VerticalSpace(),
        const _Table(),
      ],
    );
  }
}

class FormTypeFile extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  FormTypeFile({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cep = Provider.of<TypeFileProvider>(context);
    final double w = PageUtils.width(context) < 500? PageUtils.width(context) : 500;
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
                labelText: translate("typeFile.nameController"),
              ),
              onSaved: (value) => cep.nameController.text = value!,
              onChanged: (value) => _formKey.currentState?.validate(),
            ),
            TextFormField(
              controller: cep.mimeController,
              validator: Validator().notEmpty,
              decoration: InputDecoration(
                filled: true,
                prefixIcon: const Icon(Icons.file_copy),
                labelText: translate("typeFile.mimeController"),
              ),
              onSaved: (value) => cep.mimeController.text = value!,
              onChanged: (value) => _formKey.currentState?.validate(),
            ),
            TextFormField(
              controller: cep.extensionController,
              validator: Validator().notEmpty,
              decoration: InputDecoration(
                filled: true,
                prefixIcon: const Icon(Icons.extension),
                labelText: translate("typeFile.extensionController"),
              ),
              onSaved: (value) => cep.extensionController.text = value!,
              onChanged: (value) => _formKey.currentState?.validate(),
            ),
            cep.typeForm == TypeForm.CREATE
                ? SaveCreateButton<TypeFileProvider>(
                    formKey: _formKey,
                    onPressedEnd: () => Navigator.of(context).pop(),
                  )
                : SaveUpdateButton<TypeFileProvider>(
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
    final cep = Provider.of<TypeFileProvider>(context);
    return TableResponsive<TypeFileProvider>(
      provider: cep,
      listTitle: const ["Id", "nombre", "Mime", "Extención", "Acciones"],
      haveTitlePorc: const [20, 20, 27, 20, 13],
      fields: const ["id", "name", "mime", "extension"],
      onPressedBtnEdit: (i) {
        cep.typeForm = TypeForm.EDIT;
        cep.idController.text = cep.list[i].id.toString();
        cep.nameController.text = cep.list[i].name;
        cep.mimeController.text = cep.list[i].mime;
        cep.extensionController.text = cep.list[i].extension;
        TypeFilePage.scaffoldKey.currentState!.openEndDrawer();
      },
    );
  }
}
