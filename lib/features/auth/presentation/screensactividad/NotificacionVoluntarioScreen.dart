import 'package:flutter/material.dart';

class notificacionVoluntarioScreen extends StatelessWidget {
  notificacionVoluntarioScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Mis notificaciones ',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Color(0xFF3894B6),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: ListView(
        children: <Widget>[


        ],
      ),
    );
  }
}
