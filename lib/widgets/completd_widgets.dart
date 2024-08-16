import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:to_do_app/model/todomodel.dart';
import 'package:to_do_app/services/database_services.dart';

class CompletedWidgets extends StatefulWidget {
  const CompletedWidgets({super.key});

  @override
  State<CompletedWidgets> createState() => _CompletedWidgetsState();
}

class _CompletedWidgetsState extends State<CompletedWidgets> {
  User? user = FirebaseAuth.instance.currentUser;

  late String uid;
  late String email;

  final DatabaseServices _databaseServices = DatabaseServices();

  @override
  void initState() {
    super.initState();
    uid = FirebaseAuth.instance.currentUser!.uid;
    email = FirebaseAuth.instance.currentUser!.email!;

    print("Current User UID: $uid");
    print("Current User Email: $email");
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<ToDo>>(
      stream: _databaseServices.completedtodos,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<ToDo> todos = snapshot.data!;
          print(snapshot.hasData);
          print(todos);
          print(todos.length);
          return ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: todos.length,
            itemBuilder: (context, index) {
              ToDo todo = todos[index];
              final DateTime dt = todo.timestamp.toDate();
              return Container(
                margin: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Slidable(
                  key: ValueKey(todo.id),
                  endActionPane: ActionPane(
                    motion: DrawerMotion(),
                    children: [
                      SlidableAction(
                          backgroundColor: Colors.red,
                          foregroundColor: Colors.white,
                          icon: Icons.delete,
                          label: "Delete",
                          onPressed: (context) async {
                            await _databaseServices.deleteTodoItem(todo.id);
                          })
                    ],
                  ),
                  child: ListTile(
                    title: Text(
                      todo.title,
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          decoration: TextDecoration.lineThrough),
                    ),
                    subtitle: Text(
                      todo.description,
                      style: TextStyle(
                        color: Colors.indigo,
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        decoration: TextDecoration.lineThrough,
                      ),
                    ),
                    trailing: Text(
                      '${dt.day}/${dt.month}/${dt.year}',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
              );
            },
          );
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
