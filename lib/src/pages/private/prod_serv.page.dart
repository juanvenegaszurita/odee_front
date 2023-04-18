import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:provider/provider.dart';
import 'package:odee_front/src/utils/utils.dart';
import 'package:odee_front/src/widgets/table_responsive.dart';
import 'package:odee_front/src/widgets/vertical_spacing.dart';
import 'package:odee_front/src/widgets/widgets.dart';
import 'package:odee_front/src/providers/providers.dart';

class ProdServPage extends StatelessWidget {
  static String title = "prodserv.title";
  static const route = "prodserv";
  static GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  const ProdServPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ProdServProvider(),
      child: ScaffoldGeneric(
        title: translate(title),
        scaffoldKey: ProdServPage.scaffoldKey,
        endDrawer: FormCodeError(),
        body: ProdServPageBody(scaffoldKey: scaffoldKey),
      ),
    );
  }
}

class ProdServPageBody extends StatelessWidget {
  const ProdServPageBody({
    Key? key,
    required this.scaffoldKey,
  }) : super(key: key);

  final GlobalKey<ScaffoldState> scaffoldKey;

  @override
  Widget build(BuildContext context) {
    final cep = Provider.of<ProdServProvider>(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        CreateButton(
          onPressed: () {
            cep.typeForm = TypeForm.CREATE;
            cep.detailController.text = "";
            cep.priceController.text = "";
            cep.typeController.text = "";
            cep.idController.text = "";
            ProdServPage.scaffoldKey.currentState!.openEndDrawer();
          },
        ),
        const VerticalSpace(),
        const _TableCodeError(),
      ],
    );
  }
}

class FormCodeError extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  FormCodeError({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cep = Provider.of<ProdServProvider>(context);
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
              controller: cep.detailController,
              validator: Validator().notEmpty,
              decoration: InputDecoration(
                filled: true,
                prefixIcon: const Icon(Icons.message),
                labelText: translate("prodserv.detailController"),
              ),
              keyboardType: TextInputType.multiline,
              maxLines: null,
              onSaved: (value) => cep.detailController.text = value!,
              onChanged: (value) => _formKey.currentState?.validate(),
            ),
            TextFormField(
              controller: cep.typeController,
              validator: Validator().notEmpty,
              decoration: InputDecoration(
                filled: true,
                prefixIcon: const Icon(Icons.merge_type),
                labelText: translate("prodserv.typeCodeController"),
              ),
              onSaved: (value) => cep.typeController.text = value!,
              onChanged: (value) => _formKey.currentState?.validate(),
            ),
            TextFormField(
              controller: cep.priceController,
              validator: Validator().notEmpty,
              decoration: InputDecoration(
                filled: true,
                prefixIcon: const Icon(Icons.price_change),
                labelText: translate("prodserv.priceController"),
              ),
              onSaved: (value) => cep.priceController.text = value!,
              onChanged: (value) => _formKey.currentState?.validate(),
            ),
            cep.typeForm == TypeForm.CREATE
                ? SaveCreateButton<ProdServProvider>(
                    formKey: _formKey,
                    onPressedStart: () {
                      cep.body = {
                        "detail": cep.detailController.text,
                        "price": int.parse(cep.priceController.text),
                        "type": cep.typeController.text,
                      };
                      cep.detailController.text = "";
                      cep.priceController.text = "";
                      cep.typeController.text = "";
                    },
                    onPressedEnd: () {
                      Navigator.of(context).pop();
                    },
                  )
                : SaveUpdateButton<ProdServProvider>(
                    formKey: _formKey,
                    onPressedStart: () {
                      cep.bodyUpdate = {
                        "id": int.parse(cep.idController.text),
                        "detail": cep.detailController.text,
                        "price": int.parse(cep.priceController.text),
                        "type": cep.typeController.text,
                      };
                      cep.detailController.text = "";
                      cep.priceController.text = "";
                      cep.typeController.text = "";
                      cep.idController.text = "";
                    },
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

class _TableCodeError extends StatelessWidget {
  const _TableCodeError({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cep = Provider.of<ProdServProvider>(context);
    return TableResponsive<ProdServProvider>(
      provider: cep,
      listTitle: const ["Id", "Detalle", "Precio", "Tipo","Acciones"],
      haveTitlePorc: const [20, 20, 20, 27, 13],
      fields: const ["id", "detail", "price", "type"],
      onPressedBtnEdit: (i) {
        cep.typeForm = TypeForm.EDIT;
        cep.idController.text = cep.list[i].id.toString();
        cep.detailController.text = cep.list[i].detail;
        cep.priceController.text = cep.list[i].price.toString();
        cep.typeController.text = cep.list[i].type;
        ProdServPage.scaffoldKey.currentState!.openEndDrawer();
      },
    );
  }
}
