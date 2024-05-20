


import 'package:flutter/material.dart';

import '../constants/colors.dart';
import '../models/todo.dart';
import '../widgets/todoitems.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final todoList = Todo.todoList();
  List<Todo> foundToDo = [];

  final todocontroller = TextEditingController();
  @override
  void initState(){
    foundToDo = todoList;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: appBarBuild(),
        body: Stack(
          children: [
            Container(
              padding: EdgeInsets.all(15),
              child: Column(
                children: [
                  searchBox(),
                  Expanded(
                    child: ListView(
                      children: [
                        Container(
                          margin: EdgeInsets.only(
                            top: 50,
                            bottom: 20,
                          ),
                          child: Text(
                            'Things To-Do',
                            style: TextStyle(
                                fontSize: 30, fontWeight: FontWeight.w100),
                          ),
                        ),
                        for (Todo td in foundToDo)
                          ToDoitem(
                            todo: td,
                            onTodochange: _handletodochange,
                            onDeleteItem:  _deleteToItem,

                          ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.only(
                        bottom: 20,
                        right: 20,
                        left: 20,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: const [
                          BoxShadow(
                              color: Colors.grey,
                              offset: Offset(0.0, 0.0),
                              blurRadius: 10.0,
                              spreadRadius: 0.0),
                        ],
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: TextField(
                        controller: todocontroller,
                        decoration: InputDecoration(
                          hintText: 'Add a new activity',
                          border: InputBorder.none,
                          contentPadding:
                              EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                      bottom: 20,
                      right: 20,
                    ),
                    child: ElevatedButton(
                      onPressed: () {
                        _addtodoitem(todocontroller.text);
                      },
                      child: Text(
                        '+',
                        style: TextStyle(fontSize: 40),
                      ),
                      style: ElevatedButton.styleFrom(
                        shadowColor: tdBlue,
                        elevation: 10,
                        minimumSize: Size(60, 60),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ));
  }

  Widget searchBox() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(
              color: const Color.fromARGB(255, 26, 25, 25), width: 2)),
      child: TextField(
        onChanged: (value)=>_searchfilter(value),
        decoration: InputDecoration(
          contentPadding: EdgeInsets.all(0),
          prefixIcon: Icon(
            Icons.search,
            color: tdBlack,
            size: 25,
          ),
          prefixIconConstraints: BoxConstraints(maxHeight: 20, minWidth: 25),
          border: InputBorder.none,
          hintText: 'Search',
          hintStyle: TextStyle(color: Colors.blueGrey),
        ),
      ),
    );
  }

  AppBar appBarBuild() {
    return AppBar(
      elevation: 10,
      backgroundColor: tdBGColor,
      title: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Icon(
          Icons.menu,
          color: tdBlack,
          size: 30,
        ),
        Container(
          height: 40,
          width: 50,
          child: ClipRRect(
            child: Image.asset('assets/images/profile.jpg'),
          ),
        )
      ]),
    );
  }

  void _handletodochange(Todo todo) {
    setState(() {
      todo.isDone = !todo.isDone;
    });
  }
  void _deleteToItem(String id){
    setState(() {
      todoList.removeWhere((item) => item.id == id);
    });
    
  }
  void _addtodoitem(String todotext){
    setState(() {
      todoList.add(Todo(id: DateTime.now().millisecondsSinceEpoch.toString(), todoText: todotext));
    });
    todocontroller.clear();
  }
  void _searchfilter(String enteredKeyword){
     List<Todo> results = [];
    if (enteredKeyword.isEmpty) {
      results = todoList;
    } else {
      results = todoList
          .where((item) => item.todoText!
              .toLowerCase()
              .contains(enteredKeyword.toLowerCase()))
          .toList();
    }

    setState(() {
      foundToDo = results;
    });
  }
}