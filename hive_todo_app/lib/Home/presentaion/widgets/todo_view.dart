// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class TodoView extends HookConsumerWidget {
  final String title;
  final String description;
  final String date;
  final String time;
  final VoidCallback onEdit;
  final VoidCallback onDelete;
  const TodoView({
    Key? key,
    required this.title,
    required this.description,
    required this.date,
    required this.time,
    required this.onEdit,
    required this.onDelete,
  }) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        elevation: 3,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        child: ListTile(
          tileColor: Colors.black12.withOpacity(0.04),
          title: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                maxLines: 1,
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
              Text(
                date,
                maxLines: 1,
              ),
            ],
          ),
          subtitle: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  description,
                ),
                Text(
                  time,
                ),
              ],
            ),
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                  onPressed: onEdit,
                  icon: const Icon(
                    Icons.edit,
                    color: Colors.black,
                  )),
              IconButton(
                  onPressed: onDelete,
                  icon: const Icon(
                    Icons.delete,
                    color: Colors.red,
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
