import 'package:expediente_clinico/models/Staff.dart';
import 'package:expediente_clinico/providers/app.dart';
import 'package:expediente_clinico/services/staff.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ListOfStaff extends StatefulWidget {
  final String enterpriseId;
  final StaffService staffService;
  ListOfStaff({required this.enterpriseId, required this.staffService});
  @override
  _ListOfStaffState createState() => _ListOfStaffState();
}

class _ListOfStaffState extends State<ListOfStaff> {
  late AppProvider provider;
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: widget.staffService.getStaffByEnteprise(widget.enterpriseId),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              padding: EdgeInsets.zero,
              itemCount: (snapshot.data as List<Staff>).length,
              itemBuilder: (BuildContext context, int index) {
                Staff staff = snapshot.data[index];
                return ListTile(
                  onTap: () => Navigator.pushNamed(context, '/employees/detail',
                      arguments: staff),
                  title: Text('${staff.name} ${staff.lastname}'),
                );
              },
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }
}
