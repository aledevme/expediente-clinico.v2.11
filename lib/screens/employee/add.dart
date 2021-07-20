import 'dart:convert';

import 'package:expediente_clinico/models/Clinic.dart';
import 'package:expediente_clinico/models/Enterprise.dart';
import 'package:expediente_clinico/providers/app.dart';
import 'package:expediente_clinico/services/enterprise.dart';
import 'package:expediente_clinico/services/staff.dart';
import 'package:expediente_clinico/widgets/button.dart';
import 'package:expediente_clinico/widgets/dropdown.dart';
import 'package:expediente_clinico/widgets/header.dart';
import 'package:expediente_clinico/widgets/textfield.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddEmployeeScreen extends StatefulWidget {
  @override
  _AddEmployeeScreenState createState() => _AddEmployeeScreenState();
}

class _AddEmployeeScreenState extends State<AddEmployeeScreen> {
  EnterpriseService service = EnterpriseService();
  StaffService staffService = StaffService();
  late AppProvider provider;

  bool isLoadingEnterprises = true;
  List<Enterprise> enterprises = [];

  bool hasPermissionToViewAll = false;

  late String name;
  late String lastname;
  late String email;
  late String password;
  late String dui;
  late String location;
  late String selectedRole;
  late Enterprise selectedEnterprise;
  late Clinic selectedClinic;

  List<String> roles = ['Doctor', 'Asistente', 'Secretaria'];

  @override
  void initState() {
    super.initState();
    getEnterprises();
  }

  @override
  Widget build(BuildContext context) {
    provider = Provider.of<AppProvider>(context);
    return Scaffold(
      body: Column(
        children: [
          Header(
            children: HeaderOnlyBack(
              headerTitle: 'Añadir empleado',
            ),
          ),
          SizedBox(height: 20),
          Expanded(
            child: ListView(
              padding: EdgeInsets.only(top: 0, left: 20, right: 20, bottom: 20),
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
                  hint: 'Nombre del empleado',
                  onChange: (text) {
                    name = text;
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
                  hint: 'Apellido del empleado',
                  onChange: (text) {
                    lastname = text;
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
                  hint: 'Email del empleado',
                  onChange: (text) {
                    email = text;
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
                  hint: 'Contraseña empleado',
                  needHideText: true,
                  onChange: (text) {
                    password = text;
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
                  hint: 'Dui del empleado',
                  onChange: (text) {
                    dui = text;
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
                  hint: 'Dirección de vivienda',
                  onChange: (text) {
                    location = text;
                  },
                ),
                SizedBox(height: 20),
                CustomDropDown(
                  hintText: 'Seleccione un rol',
                  actualValue: selectedRole,
                  children: roles
                      .map((String role) =>
                          DropdownMenuItem(value: role, child: Text(role)))
                      .toList(),
                  onChange: (value) {
                    setState(() {
                      selectedRole = value;
                    });
                  },
                ),
                SizedBox(height: 20),
                Text('Empresas.'),
                SizedBox(height: 20),
                !hasPermissionToViewAll
                    ? isLoadingEnterprises
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [CircularProgressIndicator()],
                          )
                        : CustomDropDown(
                            hintText: 'Seleccione una empresa',
                            actualValue: selectedEnterprise,
                            children: enterprises
                                .map((Enterprise enterprise) =>
                                    DropdownMenuItem(
                                        value: enterprise,
                                        child: Text(enterprise.name)))
                                .toList(),
                            onChange: (value) {
                              setState(() {
                                print(value.clinics);
                                selectedEnterprise = value;
                              });
                            },
                          )
                    : Container(),
                SizedBox(height: 20),
                Text('Sucursales clinicas.'),
                SizedBox(height: 20),
                !hasPermissionToViewAll
                    ? selectedEnterprise == null
                        ? Container()
                        : selectedEnterprise.clinics.length == 0
                            ? Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [Text('No hay clinicas añadidas')],
                              )
                            : CustomDropDown(
                                hintText: 'Seleccione una clinica',
                                actualValue: selectedClinic,
                                children: selectedEnterprise.clinics
                                    .map((Clinic clinic) => DropdownMenuItem(
                                        value: clinic,
                                        child: Text(clinic.name)))
                                    .toList(),
                                onChange: (value) {
                                  setState(() {
                                    selectedClinic = value;
                                  });
                                },
                              )
                    : Container(),
                SizedBox(height: 20),
                CustomButton(
                    titleButton: 'Añadir', onPressed: () => addEmployee())
              ],
            ),
          )
        ],
      ),
    );
  }

  void getEnterprises() async {
    provider = Provider.of<AppProvider>(context, listen: false);
    var res = await service.getMyEnterprises(
        provider.role != 'Dueño' ? provider.enterpriseOwnerId : provider.id);
    setState(() {
      enterprises = res;
      isLoadingEnterprises = false;
    });
  }

  void addEmployee() async {
    var data = jsonEncode({
      "name": name,
      "lastname": lastname,
      "email": email,
      "password": password,
      "dui": dui,
      "direction": location,
      "role": selectedRole,
      "clinic": selectedClinic.id,
      "enterprise": selectedEnterprise.id,
    });

    var res = await staffService.addStaff(data);

    if (res['success']) {
      Navigator.popAndPushNamed(context, '/admin');
    } else {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              content: Text('No se puede agregar el staff'),
            );
          });
    }
  }
}
