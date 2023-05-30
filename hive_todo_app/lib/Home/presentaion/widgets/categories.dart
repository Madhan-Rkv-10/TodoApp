import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../provider/category_provider.dart';

class Categories extends HookConsumerWidget {
  const Categories({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedItem = ref.watch(selectedFilterItemProvider);
    return Padding(
      padding: const EdgeInsets.only(left: 5.0, bottom: 5),
      child: IconButton(
        onPressed: () {
          if (selectedItem.isEmpty) {
            ref.read(enabledFilterProvider.notifier).state = false;
          }
          showModalBottomSheet(
              isScrollControlled: true,
              useSafeArea: true,
              context: context,
              builder: (context) {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    HookConsumer(builder: (context, ref, child) {
                      final data = ref.watch(categoryListProvider);
                      // final selectedValue = ref.watch(selectedRadioProvider);
                      return SizedBox(
                        height: MediaQuery.of(context).size.height * 0.70,
                        child: Column(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(10),
                              height: 50,
                              child: const Text(
                                "Select categories",
                                style:
                                    TextStyle(fontSize: 17, color: Colors.grey),
                              ),
                            ),
                            Flexible(
                              child: ListView.builder(
                                itemCount: data!.categories!.length,
                                itemBuilder: (context, index) {
                                  final element =
                                      data.categories!.elementAt(index);
                                  return ListTile(
                                    leading: Checkbox(
                                      autofocus: true,
                                      value: element.selected,
                                      onChanged: (value) async {
                                        if (element.selected == true) {}
                                        ref
                                            .read(categoryListProvider.notifier)
                                            .updateOption(
                                              element.id,
                                            );
                                      },
                                    ),
                                    title: Text(
                                      element.category.toString(),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      );
                    }),
                    Container(
                      color: Colors.white,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            height: 40,
                            width: 80,
                            margin: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 5),
                            child: ElevatedButton(
                                onPressed: () {
                                  ref
                                      .read(enabledFilterProvider.notifier)
                                      .state = true;

                                  Navigator.of(context).pop();
                                },
                                child: const Text('Apply')),
                          ),
                          Container(
                            height: 40,
                            width: 80,
                            margin: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 5),
                            child: ElevatedButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: const Text('Cancel')),
                          ),
                        ],
                      ),
                    )
                  ],
                );
              });
        },
        icon: const Icon(
          Icons.filter_alt_sharp,
          size: 35,
        ),
      ),
    );
  }
}
