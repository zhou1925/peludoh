import 'package:animated_widgets/widgets/opacity_animated.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/initial_controller.dart';

// ignore: must_be_immutable
class InitialView extends GetView<InitialController> {
  InitialController controller = Get.put(InitialController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
          Container(
            margin: EdgeInsets.all(50),
            child: Center(
              child: OpacityAnimatedWidget(
                enabled: true,
                values: [0,1],
                duration: Duration(seconds: 1),
                curve: Curves.easeIn,
                child: Text(
                  'Peludo Heart',
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 30,
                    fontWeight: FontWeight.bold
                  ),
                ),
              ),
            ),
          )
        ]
        ),
      )
    );
  }
}
