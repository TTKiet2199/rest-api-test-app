import 'package:flutter/material.dart';
import 'package:rest_api_test_app/data_sources/api_services.dart';
import 'package:rest_api_test_app/models/user_model.dart';


class UserListView extends StatefulWidget {
  const UserListView({Key? key}) : super(key: key);

  @override
  State<UserListView> createState() => _UserListViewState();
}

class _UserListViewState extends State<UserListView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('User List')),
      ),
      body: Container(
        padding: const EdgeInsets.only(left: 10),
        child: FutureBuilder<List<UserModel>>(
          future: ApiServices().fetchUserModel(),
          builder: (context, snapshot) {
            if ((snapshot.hasError) || (!snapshot.hasData)) {
              return const Center(child: CircularProgressIndicator());
            }
            List<UserModel>? userList = snapshot.data;
            return ListView.builder(
              itemCount: (userList ?? []).length,
              itemBuilder: (context, index) {
                return userItem(userList![index]);
              },
            );
          },
        ),
      ),
    );
  }

  Widget userItem(UserModel userModel) {
    return Container(
      margin: const EdgeInsets.only(top: 20),
      child: Row(
        children: [
          Container(
            height: 80,
            width: 80,
            margin: const EdgeInsets.only(right: 20),
            child: CircleAvatar(
              backgroundImage: NetworkImage(userModel.picture!.medium!),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${userModel.name!.first!} ${userModel.name!.last!}',
                style: const TextStyle(fontSize: 20, color: Colors.black),
              ),
              Container(
                margin: const EdgeInsets.only(top: 10),
                child: Text(
                  userModel.email!,
                  style:
                      const TextStyle(fontSize: 15, color: Colors.lightGreen),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
