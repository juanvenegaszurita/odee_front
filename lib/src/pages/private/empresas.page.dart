import 'package:odee_front/src/pages/private/private.dart';
import 'package:odee_front/src/widgets/widgets.dart';
import 'package:flutter/material.dart';

class EmpresasPage extends StatelessWidget {
  static String title = "Empresa";
  static const route = 'empresa';

  const EmpresasPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ScaffoldGeneric(
      body: GridResponsive(
        children: List.generate(
          10,
          (index) => GestureDetector(
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const DetalleEmpresaPage()),
            ),
            child: Card(
              child: Text("Empresa $index"),
            ),
          ),
        ),
      ),
    );
  }
}
