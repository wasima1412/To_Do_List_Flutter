class Todo{
  String? id;
  String? todoText;
  bool isDone;
  
  Todo({
    required this.id,
    required this.todoText,
    this.isDone = false,
  });

  static List <Todo> todoList(){
    return [
      Todo(id: '1', todoText: 'Wake up'),
      Todo(id: '2', todoText: 'Say prayers'),
      Todo(id: '3', todoText: 'Take Breakfast'),
      Todo(id: '4', todoText: 'Go university'),
      Todo(id: '5', todoText: 'Submit assignment'),
      Todo(id: '6', todoText: 'Enjoy')
    ];
  }
}