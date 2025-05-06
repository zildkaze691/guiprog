import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'TODO App',
      theme: ThemeData(
        primarySwatch: Colors.lightBlue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: TodoListScreen(),
    );
  }
}

class TodoListScreen extends StatefulWidget {
  @override
  _TodoListScreenState createState() => _TodoListScreenState();
}

class _TodoListScreenState extends State<TodoListScreen> {
  List<String> todoItems = [];

  TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _addTodoItem(String task) {
    if (task.isNotEmpty) {
      setState(() {
        todoItems.add(task);

      });
      _controller.clear();
    }
  }

  void _deleteTodoItem(int index) {
    setState(() {
      todoItems.removeAt(index);
    });
  }
//AppBar Theme
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 252, 255, 103),
      appBar: AppBar(
        icon: Icon(Icons.school_sharp),
        backgroundColor:  const Color.fromARGB(255, 31, 126, 182),
        centerTitle: true,
        title: Text('TO-DO App'), titleTextStyle: TextStyle(fontSize: 30, color: const Color.fromARGB(255, 255, 17, 0), fontWeight: FontWeight.bold),
      ),
      //ToDo List view theme
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      hintText: 'Add a new task',
                      fillColor: Colors.black,
                      border: OutlineInputBorder(),
                    ),
                    onSubmitted: (value) {
                      _addTodoItem(value);
                    },
                  ),
                ),
                SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () {
                    _addTodoItem(_controller.text);
                  },
                  child: Text('Add'),
                ),
              ],
            ),
          ),

          Expanded(
            child: todoItems.isEmpty
                ? Center(child: Text('No tasks yet! Add some.'))
                : ListView.builder(
              itemCount: todoItems.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(todoItems[index]),
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      _deleteTodoItem(index);
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
