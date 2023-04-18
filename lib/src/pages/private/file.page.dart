import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:odee_front/src/models/models.dart';
import 'package:provider/provider.dart';
import 'package:odee_front/src/utils/utils.dart';
import 'package:odee_front/src/widgets/table_responsive.dart';
import 'package:odee_front/src/widgets/vertical_spacing.dart';
import 'package:odee_front/src/widgets/widgets.dart';
import 'package:odee_front/src/providers/providers.dart';

class FilePage extends StatelessWidget {
  static String title = "file.title";
  static const route = "file";
  static GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  const FilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => FileProvider(),
      child: ScaffoldGeneric(
        title: translate(title),
        scaffoldKey: FilePage.scaffoldKey,
        endDrawer: FormFile(),
        body: FileBody(scaffoldKey: scaffoldKey),
      ),
    );
  }
}

class FileBody extends StatelessWidget {
  const FileBody({
    Key? key,
    required this.scaffoldKey,
  }) : super(key: key);

  final GlobalKey<ScaffoldState> scaffoldKey;

  @override
  Widget build(BuildContext context) {
    final cep = Provider.of<FileProvider>(context);
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

class FormFile extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  FormFile({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cep = Provider.of<FileProvider>(context);
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
              controller: cep.urlController,
              validator: Validator().notEmpty,
              decoration: InputDecoration(
                filled: true,
                prefixIcon: const Icon(Icons.price_change),
                labelText: translate("file.urlController"),
              ),
              onSaved: (value) => cep.urlController.text = value!,
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
                  value: int.tryParse(cep.typeFileController.text),
                  elevation: 16,
                  isExpanded: true,
                  hint: Text(translate("file.typeFileController")),
                  items: cep.listTF
                      .map<DropdownMenuItem<int>>((TypeFileModel value) {
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
                    cep.typeFileController.text = "${value!}";
                    cep.notifyListeners();
                  },
                ),
              ],
            ),
            cep.typeForm == TypeForm.CREATE
                ? SaveCreateButton<FileProvider>(
                    formKey: _formKey,
                    onPressedEnd: () => Navigator.of(context).pop(),
                  )
                : SaveUpdateButton<FileProvider>(
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
    final cep = Provider.of<FileProvider>(context);
    return TableResponsive<FileProvider>(
      provider: cep,
      listTitle: const ["Id", "url", "Tipo de archivo", "Acciones"],
      haveTitlePorc: const [20, 47, 20, 13],
      fields: const ["id", "url", "typeFile.name"],
      onPressedBtnEdit: (i) {
        cep.typeForm = TypeForm.EDIT;
        cep.idController.text = cep.list[i].id.toString();
        cep.urlController.text = cep.list[i].url;
        cep.typeFileController.text = cep.list[i].typeFile_id.toString();
        FilePage.scaffoldKey.currentState!.openEndDrawer();
      },
    );
  }
}
