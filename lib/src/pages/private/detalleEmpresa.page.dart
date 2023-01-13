import 'package:odee_front/src/widgets/widgets.dart';
import 'package:flutter/material.dart';

class DetalleEmpresaPage extends StatelessWidget {
  static String title = "Detalle Empresa";
  static const route = 'detalleEmpresa';

  const DetalleEmpresaPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ScaffoldGeneric(
      withMenu: false,
      body: GridResponsive(
        tallaAll: 1,
        children: [
          const Text("Nombre: Empresa 1"),
          const Text("Dirección: Av. mi casa 80, Santiago"),
          GridResponsive(
            isExternal: false,
            xl: 8,
            lg: 6,
            md: 4,
            children: [
              GestureDetector(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const DetalleEmpresaPage()),
                ),
                child: const Card(
                  color: Colors.grey,
                  child: SizedBox(
                    height: 50,
                    child: Text("Generar Cotización"),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
