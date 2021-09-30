import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pankaj_pure_technlogy_test/model/employee_model.dart';

class AddEmployeeScreen extends StatefulWidget {

  final EmployeeModel? employee;

  const AddEmployeeScreen({this.employee, Key? key}) : super(key: key);

  @override
  _AddEmployeeScreenState createState() => _AddEmployeeScreenState();
}

class _AddEmployeeScreenState extends State<AddEmployeeScreen> {
  TextEditingController edtName = TextEditingController();
  TextEditingController edtEmail = TextEditingController();
  TextEditingController edtMobile = TextEditingController();
  TextEditingController edtSalary = TextEditingController();

  @override
  void initState() {
    if(widget.employee!=null){
      edtName.text = widget.employee!.name;
      edtEmail.text = widget.employee!.email;
      edtMobile.text = widget.employee!.mobile;
      edtSalary.text = widget.employee!.salary;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.employee != null ? widget.employee!.name  : "Add Employee"),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(15),
          child: Column(
            children: [
              TextFormField(
                controller: edtName,
                decoration: const InputDecoration(
                  labelText: "Name",
                  hintText: "Enter name",
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              TextFormField(
                controller: edtMobile,
                keyboardType: TextInputType.phone,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                decoration: const InputDecoration(
                  labelText: "Mobile",
                  hintText: "Enter mobile number",
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              TextFormField(
                controller: edtEmail,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  labelText: "E-mail",
                  hintText: "Enter email address",
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              TextFormField(
                controller: edtSalary,
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                decoration: const InputDecoration(
                  labelText: "Salary",
                  hintText: "Enter salary",
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              MaterialButton(
                onPressed: () {
                  save();
                },
                color: Colors.blue,
                child: const Text(
                  "Save",
                  style: TextStyle(color: Colors.white),
                ),
              )
            ],
          ),
        ));
  }

  bool isEmail(String em) {

    String p = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

    RegExp regExp = RegExp(p);

    return regExp.hasMatch(em);
  }

  void save() async {
    if (edtName.text.trim().isEmpty) {
      Fluttertoast.showToast(msg: "Please enter name");
    } else if (edtMobile.text.trim().isEmpty) {
      Fluttertoast.showToast(msg: "Please enter mobile");
    } else if (edtMobile.text.trim().length!=10) {
      Fluttertoast.showToast(msg: "Please enter valid mobile");
    }else if (edtEmail.text.trim().isEmpty) {
      Fluttertoast.showToast(msg: "Please enter email");
    }else if (!isEmail(edtEmail.text.trim())) {
      Fluttertoast.showToast(msg: "Please enter valid email");
    }else if (edtSalary.text.trim().isEmpty) {
      Fluttertoast.showToast(msg: "Please enter salary");
    }else{
      DatabaseReference employeeRef =
      FirebaseDatabase.instance.reference().child('employee');



      try{

        if(widget.employee!=null){
        var d =  await employeeRef.orderByChild("emp_id").equalTo(widget.employee!.id).once();
        Map<dynamic,dynamic> da = d.value;

        employeeRef.child(da.keys.first).update({"emp_salary": "200",});



        employeeRef.child(da.keys.first).update({
            "emp_name": edtName.text.trim(),
            "emp_mobile": edtMobile.text.trim(),
            "emp_email": edtEmail.text.trim(),
            "emp_salary": edtSalary.text.trim(),

          }).whenComplete(() {
            Fluttertoast.showToast(msg: "Employee updated successfully");
            Navigator.pop(context);
          });
        }else{
          await employeeRef.push().set({
            "emp_name": edtName.text.trim(),
            "emp_mobile": edtMobile.text.trim(),
            "emp_email": edtEmail.text.trim(),
            "emp_salary": edtSalary.text.trim(),
            "emp_id": DateTime.now().millisecondsSinceEpoch.toString(),
          }).whenComplete(() {
            Fluttertoast.showToast(msg: "Employee added success");
            Navigator.pop(context);
          });
        }


      }catch(exception){
        debugPrint("exception-->$exception");

      }

    }


  }
}
