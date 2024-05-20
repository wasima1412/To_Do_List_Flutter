import 'package:todo_app/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/models/todo.dart';

class ToDoitem extends StatelessWidget{
  final Todo todo;
  final onTodochange;
  final onDeleteItem;
  const ToDoitem({
    super.key, 
    required this.todo,
    required this.onDeleteItem,
    required this.onTodochange,
  });

  Widget build(BuildContext context){
    return Container(
      margin: EdgeInsets.only(bottom: 15),
      child: ListTile(
        onTap: (){
          onTodochange(todo);
        },
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        tileColor: tdBGColor,
        contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        leading: Icon(todo.isDone? Icons.check_box: Icons.check_box_outline_blank, color: tdBlue,),
        title: Text(todo.todoText!,style: TextStyle(fontSize: 15,decoration: todo.isDone? TextDecoration.lineThrough : null)),
        trailing: Container(
          padding: EdgeInsets.all(0),
          margin: EdgeInsets.symmetric(vertical: 10),
          height: 30,
          width: 30,
          decoration: BoxDecoration(
            color: tdRed,
            borderRadius: BorderRadius.circular(5),
            
          ),
          child: IconButton(
            color: Colors.white,
            iconSize: 15 ,
            icon: Icon(Icons.delete),
            onPressed:() {
              onDeleteItem(todo.id);
            },
          ),
        ),
      ),
    );
  }

}