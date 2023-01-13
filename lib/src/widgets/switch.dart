import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';

class SwitchGeneric extends StatelessWidget {
  const SwitchGeneric({super.key});

  @override
  Widget build(BuildContext context) {
    return FlutterSwitch(
      width: 52.0,
      height: 32.0,
      toggleSize: 24.0,
      value: true,
      borderRadius: 30.0,
      padding: 4.0,
      showOnOff: false,
      activeColor: const Color.fromARGB(255, 214, 228, 255),
      activeToggleColor: const Color.fromARGB(255, 71, 133, 255),
      onToggle: (bool value) {},
    );
  }
}
