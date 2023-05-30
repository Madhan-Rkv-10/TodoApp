//State Management
import 'package:hooks_riverpod/hooks_riverpod.dart';
//todo model
import '../model/todo_model.dart';
//todo Controller
import '../provider/todo_provider.dart';
//todo reposoitory
import '../repo/todorepo.dart';

class TodoHive extends StateNotifier<List<Todo>?> {
  TodoHive(this.ref) : super(null) {
    repo = ref.read(providerHive);
    fetchTodo();
  }
  late TodoRepo? repo;
  final StateNotifierProviderRef ref;

  ///fetch all todo from to local Storage

  void fetchTodo() {
    state = repo!.getValue();
  }

  ///add todo to local Storage

  void addTodo(Todo todo) {
    state = repo!.addValue(todo);
  }

  ///remove todo from local Storage
  void removeTodo(String id) {
    state = repo!.removeTodo(id);
  }

  ///Update  current todo from local Storage

  void updateTodo(int index, Todo todo) {
    state = repo!.updateTodo(index, todo);
  }
}
