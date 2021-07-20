import 'dart:convert';

import 'package:expediente_clinico/providers/app.dart';
import 'package:expediente_clinico/services/enterprise.dart';
import 'package:expediente_clinico/widgets/button.dart';
import 'package:expediente_clinico/widgets/header.dart';
import 'package:expediente_clinico/widgets/textfield.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddEnterprise extends StatefulWidget {
  @override
  _AddEnterpriseState createState() => _AddEnterpriseState();
}

class _AddEnterpriseState extends State<AddEnterprise> {
  late AppProvider provider;
  EnterpriseService service = EnterpriseService();

  late String name;
  late String socialReason;
  late String direction;

  @override
  Widget build(BuildContext context) {
    provider = Provider.of<AppProvider>(context);
    return Scaffold(
      body: Container(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Header(
            children: HeaderOnlyBack(
              headerTitle: 'Agregar Empresa',
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 30, horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomTextField(
                  onTap: () {},
                  iconOnLeft: null,
                  iconOnRight: null,
                  value: null,
                  controller: null,
                  helperText: "",
                  keyboardType: TextInputType.text,
                  maxLenght: 100,
                  hint: 'Nombre',
                  onChange: (text) {
                    setState(() {
                      name = text;
                    });
                  },
                ),
                SizedBox(height: 20),
                CustomTextField(
                  onTap: () {},
                  iconOnLeft: null,
                  iconOnRight: null,
                  value: null,
                  controller: null,
                  helperText: "",
                  keyboardType: TextInputType.text,
                  maxLenght: 100,
                  hint: 'Razon social',
                  onChange: (text) {
                    setState(() {
                      socialReason = text;
                    });
                  },
                ),
                SizedBox(height: 20),
                CustomTextField(
                  onTap: () {},
                  iconOnLeft: null,
                  iconOnRight: null,
                  value: null,
                  controller: null,
                  helperText: "",
                  keyboardType: TextInputType.text,
                  maxLenght: 100,
                  hint: 'Dirección',
                  onChange: (text) {
                    setState(() {
                      direction = text;
                    });
                  },
                ),
                SizedBox(height: 20),
                CustomButton(
                  onPressed: () => addEnterprise(),
                  titleButton: 'Añadir',
                )
              ],
            ),
          )
        ],
      )),
    );
  }

  Widget enterpriseTextField() => CustomTextField(
      onTap: () {},
      iconOnLeft: null,
      iconOnRight: null,
      value: null,
      controller: null,
      helperText: "",
      keyboardType: TextInputType.text,
      maxLenght: 100,
      onChange: (value) => setState(() => {}),
      hint: 'Nombre');

  void addEnterprise() async {
    var data = jsonEncode({
      'name': name,
      'socialReason': socialReason,
      'direction': direction,
      'doctor':
          provider.role != 'Dueño' ? provider.enterpriseOwnerId : provider.id
    });

    var res = await service.addEnterprise(data);

    if (res['success']) {
      provider.role != 'Dueño'
          ? Navigator.popAndPushNamed(context, provider.homeRoute)
          : Navigator.popAndPushNamed(context, '/admin');
    } else {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              content: Text('No se puede agregar la empresa'),
            );
          });
    }
  }
}
