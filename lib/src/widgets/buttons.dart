import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:odee_front/src/providers/providers.dart';
import 'package:odee_front/src/widgets/icon_text.dart';

class SaveCreateButton<T extends MaintainerProvider> extends StatelessWidget {
  const SaveCreateButton({
    Key? key,
    this.onPressedStart,
    this.onPressedEnd,
    this.formKey,
  }) : super(key: key);

  final VoidCallback? onPressedStart;
  final VoidCallback? onPressedEnd;
  final GlobalKey<FormState>? formKey;

  @override
  Widget build(BuildContext context) {
    final cbp = Provider.of<T>(context);
    return ElevatedButton(
      onPressed: () async {
        if (formKey!.currentState!.validate()) {
          cbp.setFormCreate();
          if (onPressedStart != null) onPressedStart!();
          await cbp.create();
          onPressedEnd!();
        }
      },
      child: const Text("Guardar"),
    );
  }
}

class SaveDeletedButton<T extends MaintainerProvider> extends StatelessWidget {
  SaveDeletedButton(
    this.id, {
    Key? key,
  }) : super(key: key);
  String id;
  @override
  Widget build(BuildContext context) {
    final cbp = Provider.of<T>(context);
    return ElevatedButton(
      onPressed: () async {
        cbp.id = id;
        await cbp.deleted();
      },
      child: const Icon(Icons.delete),
    );
  }
}

class SaveUpdateButton<T extends MaintainerProvider> extends StatelessWidget {
  const SaveUpdateButton({
    Key? key,
    this.onPressedStart,
    this.onPressedEnd,
    this.formKey,
  }) : super(key: key);

  final VoidCallback? onPressedStart;
  final VoidCallback? onPressedEnd;
  final GlobalKey<FormState>? formKey;

  @override
  Widget build(BuildContext context) {
    final cbp = Provider.of<T>(context);
    return ElevatedButton(
      onPressed: () async {
        if (formKey!.currentState!.validate()) {
          cbp.setFormUpdate();
          if (onPressedStart != null) onPressedStart!();
          await cbp.update();
          onPressedEnd!();
        }
      },
      child: const Text("Guardar"),
      /* child: const IconText(
        icon: Icons.add,
        textAfterIcon: "Guardar",
      ), */
    );
  }
}

class CreateButton extends StatelessWidget {
  const CreateButton({
    Key? key,
    this.onPressed,
  }) : super(key: key);

  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: const IconText(
        icon: Icons.add,
        textAfterIcon: "Nuevo",
      ),
    );
  }
}

class CancelButton extends StatelessWidget {
  const CancelButton({
    Key? key,
    this.onPressed,
  }) : super(key: key);

  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      /* child: const IconText(
        icon: Icons.cancel,
        textAfterIcon: "Cancelar",
      ), */
      child: const Text("Cancelar"),
    );
  }
}
