import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Todo App',
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      home: const MyHomePage(title: 'Flutter Todo App'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class Todo {
  String? title;
  String? desc;
  bool? isDone;
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController todoTittleController = TextEditingController();
  TextEditingController todoDescController = TextEditingController();

  List<Todo> todoList = []; //array ["" "" "" ""]

  _addTodo() {
    Todo todoItem = Todo();
    todoItem.title = todoTittleController.text;
    todoItem.desc = todoDescController.text;
    todoItem.isDone = false;

    setState(() {
      if (todoItem.title != '' && todoItem.desc != '') {
        todoList.add(todoItem);
      } else {
        //do nothing
      }
    });
    todoTittleController.clear();
    todoDescController.clear();
  }

  toggleDone(index) {
    setState(() {
      todoList[index].isDone != todoList[index].isDone;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        children: [
          TextField(
            controller: todoTittleController,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Todo title',
            ),
          ),
          TextField(
            controller: todoDescController,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Todo description',
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: todoList.length,
              shrinkWrap: true,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  title: Text(todoList[index].title ?? ''),
                  subtitle: Text(todoList[index].desc ?? ''),
                  leading: InkWell(
                    onTap: null,
                    child: Icon(Icons.check_box,
                        color: todoList[index].isDone == true
                            ? Colors.green
                            : Colors.grey),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addTodo,
        tooltip: 'Add Todo',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
