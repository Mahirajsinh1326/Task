// quote_widget.dart
import 'package:flutter/material.dart';

class QuoteWidget extends StatelessWidget {
  final String quote;
  final VoidCallback onNewQuote;

  const QuoteWidget({
    Key? key,
    required this.quote,
    required this.onNewQuote,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text("Quote of the day"),
        const SizedBox(height: 10),
        Text(
          quote,
          style: const TextStyle(fontSize: 18, fontStyle: FontStyle.italic),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 10),
        ElevatedButton(
          onPressed: onNewQuote,
          child: const Text('New Quote'),
        ),
      ],
    );
  }
}
