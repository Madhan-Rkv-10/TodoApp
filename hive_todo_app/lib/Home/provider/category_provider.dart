import 'package:hive_todo_app/Home/provider/todo_provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../controller/categories_controller.dart';
import '../model/categories_model.dart';

final categoryListProvider = StateNotifierProvider<CatsState, Cats?>((ref) {
  return CatsState(ref);
});
final categoriesListprovider = Provider<List<String>>((ref) {
  final hiveDataProvider = ref.watch(hiveData);
  final categoryList =
      hiveDataProvider!.map((e) => e.description).toSet().toList();
  return categoryList;
});
final selectedFilterItemProvider = Provider<List<Cat>>((ref) {
  final filteredData = ref.watch(categoryListProvider);
  final selected =
      filteredData?.categories?.where((element) => element.selected).toList();
  List<Cat> d = [];
  return selected ?? d;
});

///whether the filter based on todo is selected or not
final enabledFilterProvider = StateProvider<bool>((ref) => false);
