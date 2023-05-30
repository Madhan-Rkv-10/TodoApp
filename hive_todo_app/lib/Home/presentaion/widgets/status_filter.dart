import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../utils.dart';
import '../../provider/todo_provider.dart';

class StatusFilter extends HookConsumerWidget {
  const StatusFilter({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final status = ref.watch(filterProvider);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: Status.values
          .map(
            (type) => InkWell(
              child: SizedBox(
                width: 110,
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                      backgroundColor: status == type
                          ? Colors.purple.withOpacity(0.7)
                          : null,
                      foregroundColor: status != type
                          ? Colors.purple.withOpacity(0.7)
                          : Colors.white),
                  onPressed: () {
                    ref.read(filterProvider.notifier).state = type;
                  },
                  child: Text(
                    type.name,
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),
            ),
          )
          .toList(),
    );
  }
}
