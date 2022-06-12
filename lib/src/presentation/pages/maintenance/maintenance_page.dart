import 'package:flutter/material.dart';
import 'package:occam/occam.dart';

import 'maintenance_controller.dart';

class MaintenancePage extends StateWidget<MaintenanceController> {
  const MaintenancePage({Key? key}) : super(key: key);

  @override
  MaintenanceController createState() => MaintenanceController();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: Center(
          child: Container(
            margin: const EdgeInsets.all(28.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/offline_logo.png',
                  width: 250,
                ),
                const SizedBox(height: 60),
                Image.asset('assets/images/maintenence.png', width: 120),
                const SizedBox(height: 35),
                const Text(
                  '¡En mantenimiento!',
                  style: TextStyle(fontFamily: 'Exo', fontSize: 18),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Por favor, intenta en unos minutos.\nGracias',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'Exo',
                    fontSize: 16,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 35),
                // CustomMaterialButton(
                //   label: 'Intentar nuevamente',
                //   onTap: state.onTap,
                //   isLoading: false,
                // )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
