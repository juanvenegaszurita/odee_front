import 'package:flutter_translate/flutter_translate.dart';
import 'package:odee_front/src/models/models.dart';
import 'package:odee_front/src/pages/private/private.dart';
import 'package:odee_front/src/providers/providers.dart';
import 'package:odee_front/src/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EmpresasPage extends StatelessWidget {
  static String title = "Empresa";
  static const route = 'empresa';

  const EmpresasPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => EmpresasProvider(),
      child: ScaffoldGeneric(
        title: translate(title),
        scaffoldKey: BusinessPage.scaffoldKey,
        body: const _CardList(),
      ),
    );
  }
}

class _CardList extends StatelessWidget {
  const _CardList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ep = Provider.of<EmpresasProvider>(context);
    return GridResponsive(
      tallaAll: 1,
      children: [
        TextFormField(
          controller: ep.filterController,
          validator: null,
          decoration: InputDecoration(
            filled: true,
            prefixIcon: const Icon(Icons.search),
            labelText: translate("input.filter"),
          ),
          onSaved: (value) => ep.filterController.text = value!,
          onChanged: (value) => ep.filter(value, ["name", "business_name", "rut"]),
        ),
        ...List.generate(
          ep.listFilter.length,
          (index) => Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            child: ListTile(
              leading: const Icon(Icons.business_sharp),
              title: Text(ep.listFilter[index].name),
              subtitle: GridResponsive(
                tallaAll: 1,
                isExternal: false,
                children: [
                  GridResponsive(
                    md: 3,
                    isExternal: false,
                    children: [
                      Text(
                          "${translate("business.businessNameController")}: ${ep.listFilter[index].business_name}"),
                      Text(
                          "${translate("business.rutController")}: ${ep.listFilter[index].rut}"),
                      Text(
                          "${translate("business.addressController")}: ${ep.listFilter[index].address}"),
                    ],
                  ),
                  GridResponsive(
                    isExternal: false,
                    tallaAll: 1,
                    children: [
                      Text(
                        translate("clients.title"),
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  _ClientTable(clients: ep.listFilter[index].clients!),
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}

class _ClientTable extends StatelessWidget {
  const _ClientTable({
    Key? key,
    required this.clients,
  }) : super(key: key);

  final List<ClientsModel> clients;

  @override
  Widget build(BuildContext context) {
    final ep = Provider.of<EmpresasProvider>(context);
    return GridResponsive(
      isExternal: false,
      children: List.generate(
        clients.length,
        (ic) => GridResponsive(
          isExternal: false,
          tallaAll: 1,
          children: [
            ElevatedButton(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const DetalleEmpresaPage()),
              ),
              child: GridResponsive(
                tallaAll: 1,
                isExternal: false,
                children: [
                  Text(clients[ic].name),
                  Text(
                      "Cotizaciones: ${clients[ic].quotation!.length}"),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
