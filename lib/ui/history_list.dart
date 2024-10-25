// history_list.dart
import 'package:flutter/material.dart';

class HistoryList extends StatelessWidget {
  final List<String> history;

  const HistoryList({
    Key? key,
    required this.history,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        padding: EdgeInsets.zero,
        itemCount: history.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: const Text('•'),
            title: Text(history[index]),
          );
        },
      ),
    );
  }
}
