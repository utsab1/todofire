import 'package:flutter/cupertino.dart';
import 'package:todofire/api/firebase_api.dart';
import '../model/todo.dart';

class TodosProvider extends ChangeNotifier {
  List<Todo>? _todos = [
    //For retrive todo from firestore
//For initially inside todos to with provider
//     Todo(
//       createdTime: DateTime.now(),
//       title: 'Buy Food 😋',
//       description: '''- Eggs
// - Milk
// - Bread
// - Water''',
//     ),
//     Todo(
//       createdTime: DateTime.now(),
//       title: 'Plan family trip to Norway',
//       description: '''- Rent some hotels
// - Rent a car
// - Pack suitcase''',
//     ),
//     Todo(
//       createdTime: DateTime.now(),
//       title: 'Plan family trip to Nepal',
//       description: '''- Rent some hotels
// - Rent a car
// - Pack suitcase''',
//     ),
//     Todo(
//       createdTime: DateTime.now(),
//       title: 'Walk the Dog 🐕',
//     ),
//     Todo(
//       createdTime: DateTime.now(),
//       title: 'Plan Jacobs birthday party 🎉🥳',
//     ),
  ];

  List<Todo> get todos => _todos!.where((todo) => todo.isDone == false).toList();
  List<Todo> get todosCompleted =>
      _todos!.where((todo) => todo.isDone == true).toList();

  void setTodos(List<Todo>? todos) =>
      WidgetsBinding.instance!.addPersistentFrameCallback((_) {
        _todos = todos;
        notifyListeners();
      });
  void addTodo(Todo todo) {
    //_todos.add(todo);  //this is for local provider storage
    FirebaseApi.createTodo(
        todo); //This is for store todo locally and in firebase
    notifyListeners();
  }

  void removeTodo(Todo todo) {
    // _todos.remove(todo); for remove to do locally
    FirebaseApi.deleteTodo(todo); //remove todo locally and from firebase

    notifyListeners();
  }

  bool? toggleTodoStatus(Todo todo) {
    todo.isDone = !todo.isDone!;

    FirebaseApi.updateTodo(todo);

    return todo.isDone;
  }

  void updateTodo(Todo todo, String? title, String? description) {
    todo.title = title;
    todo.description = description;

    FirebaseApi.updateTodo(todo);
  }
}
