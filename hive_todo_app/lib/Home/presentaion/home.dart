import 'package:flutter/material.dart';
//Screens
import 'package:hive_todo_app/Home/presentaion/create.dart';
//Widgets
import 'package:hive_todo_app/Home/presentaion/widgets/categories.dart';
import 'package:hive_todo_app/Home/presentaion/widgets/status_filter.dart';
import 'package:hive_todo_app/Home/presentaion/widgets/todo_view.dart';
//Utils
import 'package:hive_todo_app/utils.dart';
// Riverpod
import 'package:hooks_riverpod/hooks_riverpod.dart';
//Providers
import '../provider/category_provider.dart';
import '../provider/todo_provider.dart';

class HomePage extends StatefulHookConsumerWidget {
  const HomePage({super.key});
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  @override
  Widget build(BuildContext context) {
    ///List of Todo  without Filter Provider
    final provider = ref.watch(hiveData);
    debugPrint(provider?.length.toString());

    ///List of Todo with Filter Provider data

    final data = ref.watch(filteredDataProvider);

    ///whether the filter is selected or not

    final enabledFilter = ref.watch(enabledFilterProvider);

    ///selected filter items Provider data

    final selectedItem = ref.watch(selectedFilterItemProvider);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          "Todo App ",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 5.0),
            child: IconButton(
                onPressed: () {
                  ref.invalidate(statusProvider);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const EditScreen(
                        isNew: true,
                        id: '',
                        description: '',
                        title: '',
                        index: 0,
                      ),
                    ),
                  );
                },
                icon: const Icon(
                  Icons.add_box_outlined,
                  color: Colors.green,
                  size: 30,
                )),
          )
        ],
      ),
      body: Column(
        children: [
          const SizedBox(height: 40, child: StatusFilter()),
          const SizedBox(
            height: 20,
          ),
          Container(
              height: 40,
              alignment: Alignment.center,
              child: Row(
                mainAxisSize: !(enabledFilter && selectedItem.isNotEmpty)
                    ? MainAxisSize.max
                    : MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Categories(),
                  if (enabledFilter && selectedItem.isNotEmpty)
                    Flexible(
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: selectedItem.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.only(top: 2),
                              child: OutlinedButton(
                                  style: OutlinedButton.styleFrom(
                                    foregroundColor: Colors.white,
                                    backgroundColor: Colors.green,
                                  ),
                                  onPressed: () async {
                                    await ref
                                        .read(categoryListProvider.notifier)
                                        .updateOption(selectedItem[index].id,
                                            value: false);

                                    if (selectedItem.isEmpty) {
                                      ref
                                          .read(enabledFilterProvider.notifier)
                                          .state = false;
                                    } else {
                                      ref
                                          .read(enabledFilterProvider.notifier)
                                          .state = true;
                                    }
                                  },
                                  child: Text(
                                    selectedItem[index].category.toString(),
                                  )),
                            );
                          }),
                    ),
                ],
              )),
          const SizedBox(
            height: 20,
          ),
          data.isEmpty
              ? const Center(
                  child: Text("No data"),
                )
              : Expanded(
                  child: ListView.builder(
                    itemCount: data.length,
                    itemBuilder: (context, index) {
                      return TodoView(
                        title: data[index].title,
                        description: data[index].description,
                        date: data[index].createdAt.substring(0, 11),
                        time: data[index].createdAt.substring(12),
                        onEdit: () {
                          ref.read(statusProvider.notifier).state =
                              data[index].status == 'pending'
                                  ? Status.pending
                                  : Status.completed;
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => EditScreen(
                                isNew: false,
                                id: data[index].id,
                                index: index,
                                description: data[index].description,
                                title: data[index].title,
                                status: data[index].status == 'pending'
                                    ? Status.pending
                                    : Status.completed,
                              ),
                            ),
                          );
                        },
                        onDelete: () {
                          ref
                              .read(hiveData.notifier)
                              .removeTodo(data[index].id);
                        },
                      );
                    },
                  ),
                ),
        ],
      ),
    );
  }
}
