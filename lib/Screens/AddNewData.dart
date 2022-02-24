import 'dart:math';

import 'package:demo_project_new/Constant/CustomTextField.dart';
import 'package:demo_project_new/Screens/MyHomePage.dart';
import 'package:flutter/material.dart';

import '../Model/user_data_model.dart';

class AddNewData extends StatefulWidget {
  final Function(UserDataModel) addUserDataModel;
  const AddNewData({Key? key, required this.addUserDataModel})
      : super(key: key);

  @override
  _AddNewDataState createState() => _AddNewDataState();
}

class _AddNewDataState extends State<AddNewData> {
  TextEditingController userIdController = TextEditingController();
  TextEditingController titleController = TextEditingController();
  TextEditingController bodyController = TextEditingController();

  FocusNode idFocuse = FocusNode();
  FocusNode titleFocuse = FocusNode();
  FocusNode bodyFocuse = FocusNode();

  String? addId;
  String? addTitle;
  String? addBody;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: true,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.orange,
          title: const Text("Add New Data"),
        ),
        body: Column(
          children: [
            CustomTextField(
              controller: userIdController,
              focusNode: idFocuse,
              hintText: "User Id",
              onChanged: (value) {
                addId = value;
              },
            ),
            CustomTextField(
              controller: titleController,
              focusNode: titleFocuse,
              hintText: "Title",
              onChanged: (value) {
                addTitle = value;
              },
            ),
            CustomTextField(
              controller: bodyController,
              focusNode: bodyFocuse,
              hintText: "Body",
              onChanged: (value) {
                addBody = value;
              },
            ),
            FlatButton(
              minWidth: 200,
              color: Colors.orangeAccent,
              onPressed: () {
                widget.addUserDataModel(
                  UserDataModel(
                    userId: int.parse(addId ?? "0"),
                    id: Random().nextInt(1000),
                    title: addTitle,
                    body: addBody,
                  ),
                );
                Navigator.pop(context);
              },
              child: const Text(
                "Add",
                style: TextStyle(color: Colors.white),
              ),
            )
          ],
        ),
      ),
    );
  }
}
