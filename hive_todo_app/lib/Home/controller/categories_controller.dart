import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../model/categories_model.dart';
import '../provider/category_provider.dart';
import '../provider/todo_provider.dart';
import '../repo/todorepo.dart';

class CatsState extends StateNotifier<Cats?> {
  CatsState(this.ref) : super(null) {
    repo = ref!.read(providerHive);

    getCategories();
  }
  late TodoRepo? repo;

  final StateNotifierProviderRef? ref;

  ///fetch the all categoties by todo
  getCategories() {
    final data = ref!.watch(categoriesListprovider);
    final r = Cats.fromJson(data);
    state = r;
  }

  ///update  todo status
  Future<void> updateOption(String id, {bool? value}) async {
    state = state!.copyWith(
        categories: state!.categories!.map((e) {
      if (e.id == id) {
        return e.copyWith(selected: value ?? true);
      } else {
        return e.copyWith(selected: value ?? false);
      }
    }).toList());
  }
}
