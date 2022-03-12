import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/appointment_detail_controller.dart';

class AppointmentDetailView extends GetView<AppointmentDetailController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('AppointmentDetailView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'AppointmentDetailView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
