import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:to_do_app/model/todomodel.dart';
import 'package:to_do_app/services/database_services.dart';

class PendingWidgets extends StatefulWidget {
  const PendingWidgets({super.key});

  @override
  State<PendingWidgets> createState() => _PendingWidgetsState();
}

class _PendingWidgetsState extends State<PendingWidgets> {
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
      stream: _databaseServices.todos,
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
                          backgroundColor: Colors.green,
                          foregroundColor: Colors.white,
                          icon: Icons.done,
                          label: "Mark as Done",
                          onPressed: (context) {
                            _databaseServices.updateTodoStatus(todo.id, true);
                          })
                    ],
                  ),
                  startActionPane: ActionPane(
                    motion: DrawerMotion(),
                    children: [
                      SlidableAction(
                          backgroundColor: Colors.amber,
                          foregroundColor: Colors.white,
                          icon: Icons.edit,
                          label: "Edit",
                          onPressed: (context) {
                            _showTaskDialog(context, todo: todo);
                          }),
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
                      ),
                    ),
                    subtitle: Text(
                      todo.description,
                      style: TextStyle(
                          color: Colors.indigo,
                          fontSize: 15,
                          fontWeight: FontWeight.w500),
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

  void _showTaskDialog(BuildContext context, {ToDo? todo}) {
    final TextEditingController _titleController =
        TextEditingController(text: todo?.title);
    final TextEditingController _descriptionController =
        TextEditingController(text: todo?.description);
    final DatabaseServices _databaseServices = DatabaseServices();

    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: Colors.white,
            title: Text(
              todo == null ? "Add Task" : "Edit Task",
              style: TextStyle(
                fontWeight: FontWeight.w500,
              ),
            ),
            content: SingleChildScrollView(
              child: Container(
                width: MediaQuery.of(context).size.width,
                child: Column(
                  children: [
                    TextField(
                      controller: _titleController,
                      decoration: InputDecoration(
                          labelText: "title", border: OutlineInputBorder()),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextField(
                      controller: _descriptionController,
                      decoration: InputDecoration(
                          labelText: "description",
                          border: OutlineInputBorder()),
                    ),
                  ],
                ),
              ),
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    "cancel",
                    style: TextStyle(fontSize: 15),
                  )),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.indigo,
                    foregroundColor: Colors.white,
                  ),
                  onPressed: () async {
                    if (todo == null) {
                      await _databaseServices.addToDoItem(
                          _titleController.text, _descriptionController.text);
                    } else {
                      await _databaseServices.updateTodoItem(todo.id,
                          _titleController.text, _descriptionController.text);
                    }
                    Navigator.pop(context);
                  },
                  child: Text(
                    todo == null ? "Add" : "Edit",
                  ))
            ],
          );
        });
  }
}
