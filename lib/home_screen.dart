import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:to_do_app/login_screen.dart';
import 'package:to_do_app/model/todomodel.dart';
import 'package:to_do_app/services/auth_services.dart';
import 'package:to_do_app/services/database_services.dart';
import 'package:to_do_app/widgets/completd_widgets.dart';
import 'package:to_do_app/widgets/pending_widgets.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<HomeScreen> {
  int _buttonIndex = 0;

  final List<Widget> _Widgets = [
    //pending tasks
    PendingWidgets(),

    //completed tasks
    CompletedWidgets(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF1d2630),
      appBar: AppBar(
        backgroundColor: Color(0xFF1d2630),
        foregroundColor: Colors.white,
        title: Text("ToDo"),
        actions: [
          IconButton(
              onPressed: () async {
                await AuthService().signOut();
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => LoginScreen()));
              },
              icon: Icon(Icons.exit_to_app)),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InkWell(
                  borderRadius: BorderRadius.circular(10),
                  onTap: () {
                    setState(() {
                      _buttonIndex = 0;
                    });
                  },
                  child: Container(
                    height: 50,
                    width: MediaQuery.of(context).size.width / 2.5,
                    decoration: BoxDecoration(
                      color: _buttonIndex == 0 ? Colors.indigo : Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: Text(
                        "Pending Tasks",
                        style: TextStyle(
                          color:
                              _buttonIndex == 0 ? Colors.white : Colors.black,
                          fontSize: _buttonIndex == 0 ? 18 : 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ),
                InkWell(
                  borderRadius: BorderRadius.circular(10),
                  onTap: () {
                    setState(() {
                      _buttonIndex = 1;
                    });
                  },
                  child: Container(
                    height: 50,
                    width: MediaQuery.of(context).size.width / 2.5,
                    decoration: BoxDecoration(
                      color: _buttonIndex == 1 ? Colors.indigo : Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: Text(
                        "Completed Tasks",
                        style: TextStyle(
                          color:
                              _buttonIndex == 1 ? Colors.white : Colors.black,
                          fontSize: _buttonIndex == 1 ? 18 : 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 30,
            ),
            _Widgets[_buttonIndex],
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        child: Icon(Icons.add, color: Colors.indigo),
        onPressed: () {
          _showTaskDialog(context);
        },
      ),
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
