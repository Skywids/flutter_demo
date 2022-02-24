import 'package:demo_project_new/Constant/CustomListData.dart';
import 'package:demo_project_new/DBService/database_helper.dart';
import 'package:demo_project_new/Repository/UserDataRepository.dart';
import 'package:demo_project_new/Model/user_data_model.dart';
import 'package:demo_project_new/Screens/AddNewData.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final key = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
        value: UserDataRepository(),
        child: Consumer<UserDataRepository>(
          builder: (context, provider, child) {
            if (provider.futurePost1 == null) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            return listWidget(provider, context, provider.futurePost1!);
          },
        ));
  }

  Widget listWidget(UserDataRepository provider, BuildContext context,
      List<UserDataModel> futurePost1) {
    return Scaffold(
      body: ListView.separated(
        scrollDirection: Axis.vertical,
        itemCount: futurePost1.length,
        shrinkWrap: true,
        itemBuilder: (context, int index) {
          return Dismissible(
            key: UniqueKey(),
            onDismissed: (direction) {
              var model = futurePost1[index];
              _deleteMessage(model, provider);
            },
            direction: DismissDirection.endToStart,
            background: Container(
              color: Colors.red,
              alignment: Alignment.centerRight,
              padding: EdgeInsets.symmetric(horizontal: 10.0),
              child: Icon(Icons.delete_forever),
            ),
            child: Container(
              color: Colors.grey[200],
              padding: const EdgeInsets.only(left: 10, top: 10, bottom: 10),
              margin: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomListData(
                    title: "User Id :",
                    value: futurePost1[index].userId.toString(),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  CustomListData(
                    title: "ID :",
                    value: futurePost1[index].id.toString(),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  CustomListData(
                    title: "Title :",
                    value: futurePost1[index].title,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  CustomListData(
                    title: "Body :",
                    value: futurePost1[index].body,
                  ),
                ],
              ),
            ),
          );
        },
        separatorBuilder: (context, int index) {
          return const SizedBox.shrink();
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.grey[350],
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddNewData(addUserDataModel: (model) {
                provider.insert(model);
              }),
            ),
          );
        },
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }

  void _deleteMessage(UserDataModel model, UserDataRepository dataRepository) {
    dataRepository.delete(model.id);
  }
}
