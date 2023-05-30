import 'package:flutter/material.dart';
import 'package:hive_todo_app/utils.dart';
// Localization
import 'package:intl/intl.dart';

//models
import 'package:hive_todo_app/Home/model/todo_model.dart';

// Riverpod
import 'package:hooks_riverpod/hooks_riverpod.dart';

//Providers
import '../provider/todo_provider.dart';

class EditScreen extends StatefulHookConsumerWidget {
  const EditScreen({
    Key? key,
    required this.description,
    required this.title,
    required this.isNew,
    required this.id,
    this.status,
    required this.index,
  }) : super(key: key);
  final String description;
  final String title;
  final bool isNew;
  final String id;
  final Status? status;
  final int index;
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _EditScreenState();
}

class _EditScreenState extends ConsumerState<EditScreen> {
  final titleController = TextEditingController();
  final categoryController = TextEditingController();

  @override
  void initState() {
    if (!widget.isNew) {
      titleController.text = widget.title;
      categoryController.text = widget.description;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final status = ref.watch(statusProvider);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.black,
              size: 30,
            )),
        title: Text(
          widget.isNew ? "Create Todo" : "Edit Todo",
          style: const TextStyle(
              color: Colors.purple, fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            TextField(
              controller: titleController,
              decoration: const InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.purple, width: 2),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.purple, width: 2),
                ),
                hintText: ' Enter title',
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: TextField(
                controller: categoryController,
                decoration: const InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.purple, width: 2),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.purple, width: 2),
                  ),
                  hintText: ' Enter category',
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            RadioListTile<Status>(
                title: const Text("Completed"),
                value: Status.completed,
                groupValue: status,
                activeColor: Colors.purple,
                onChanged: (v) {
                  ref.read(statusProvider.notifier).state = v!;
                }),
            RadioListTile<Status>(
              title: const Text("Pending"),
              value: Status.pending,
              groupValue: status,
              activeColor: Colors.purple,
              onChanged: (v) {
                ref.read(statusProvider.notifier).state = v!;
              },
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text(
                    'Cancel',
                  ),
                ),
                const SizedBox(
                  width: 30,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.purple,
                  ),
                  onPressed: () {
                    if (widget.isNew) {
                      ref.read(hiveData.notifier).addTodo(
                            Todo(
                              title: titleController.text,
                              createdAt: DateFormat("d MMM yyyy:h:ma")
                                  .format(DateTime.now()),
                              status: status.status,
                              description: categoryController.text,
                            ),
                          );
                    } else {
                      ref.read(hiveData.notifier).updateTodo(
                            widget.index,
                            Todo(
                              title: titleController.text,
                              createdAt: DateFormat("d MMM yyyy:h:ma")
                                  .format(DateTime.now()),
                              status: status.name,
                              description: categoryController.text,
                            ),
                          );
                    }
                    ref.invalidate(statusProvider);
                    Navigator.pop(context);
                  },
                  child: Text(
                    widget.isNew ? 'Create' : 'Update',
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
