import 'dart:developer';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:pankaj_pure_technlogy_test/add_employee_screen.dart';
import 'package:pankaj_pure_technlogy_test/model/employee_model.dart';

class EmployeeScreen extends StatefulWidget {
  const EmployeeScreen({Key? key}) : super(key: key);

  @override
  _EmployeeScreenState createState() => _EmployeeScreenState();
}

class _EmployeeScreenState extends State<EmployeeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Employees"),
      ),
      body: StreamBuilder(
        stream: FirebaseDatabase.instance.reference().child("employee").onValue,
        builder: (context, AsyncSnapshot<Event> snapshot) {
          if (snapshot.hasData) {
            List<EmployeeModel> empList = [];
            DataSnapshot dataValues = snapshot.data!.snapshot;
            Map<dynamic, dynamic> values = dataValues.value;
            log("data->$values");
            values.forEach((key, value) {
              log("$key->$value");
              EmployeeModel employeeModel = EmployeeModel(
                email: value["emp_email"],
                id: value["emp_id"],
                mobile: value["emp_mobile"],
                name: value["emp_name"],
                salary: value["emp_salary"],
              );
              empList.add(employeeModel);
            });
            return ListView.separated(
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) =>  AddEmployeeScreen(
                                    employee: empList[index],
                                  )));
                    },
                    child: Container(
                      padding: const EdgeInsets.all(15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            empList[index].name,
                            style: const TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.bold,
                                fontSize: 20),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                            "E-mail : " + empList[index].email,
                            style: const TextStyle(
                                color: Colors.black, fontSize: 18),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                            "Mobile : " + empList[index].mobile,
                            style: const TextStyle(
                                color: Colors.black, fontSize: 18),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                            "Salary : " + empList[index].salary,
                            style: const TextStyle(
                                color: Colors.black, fontSize: 18),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                        ],
                      ),
                    ),
                  );
                },
                separatorBuilder: (context, index) {
                  return Divider(height: 1, color: Colors.grey.shade300);
                },
                itemCount: empList.length);
          }
          return const Center(
            child: Text("Employees not found!"),
          );
        },
      ),
      bottomNavigationBar: MaterialButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (_) => const AddEmployeeScreen()));
        },
        child: const Text("Add employee",
            style: TextStyle(color: Colors.white),),
        color: Colors.blue,
        height: 50,
      ),
    );
  }
}
