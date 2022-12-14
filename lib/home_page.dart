import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:livetracking/socket_io_clinets.dart';
import 'package:snippet_coder_utils/FormHelper.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  double? lattitude;
  double? longitude;
  static final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  SocketClient socketClient = SocketClient.instance;

  @override
  void initState() {
    super.initState();
 
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(''),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FormHelper.inputFieldWidget(
              context,
              'Latitude',
              'latitude',
              (onValidate) {
                if (onValidate == null || onValidate.isEmpty) {
                  return 'Latitude is required';
                }
                return null;
              },
              (onSaved) {
                lattitude = double.parse(onSaved!);
              },
            ),
            SizedBox(
              height: 20,
            ),
            FormHelper.inputFieldWidget(
              context,
              'Longtitude',
              'Longtitude',
              (onValidate) {
                if (onValidate == null || onValidate.isEmpty) {
                  return 'Latitude is required';
                }
                return null;
              },
              (onSaved) {
                longitude = double.parse(onSaved!);
              },
            ),
            SizedBox(
              height: 30,
            ),
            FormHelper.submitButton('Send Location', () {
              log('clciked');
              if (validateANdSave()) {
                var cords = {
                  'lat': lattitude,
                  'long': longitude,
                };
                socketClient.socket!.emit('position-change', cords);
              }
            })
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    socketClient.socket!.disconnect();
    super.dispose();
  }

  bool validateANdSave() {
    final FormState form = _formKey.currentState!;
    if (form.validate()) {
      form.save();
      return true;
    } else {
      return false;
    }
  }
}
