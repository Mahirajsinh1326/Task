// calculator_input.dart
import 'package:flutter/material.dart';

class CalculatorInput extends StatelessWidget {
  final TextEditingController firstNumberController;
  final TextEditingController secondNumberController;
  final VoidCallback onCalculate;
  final int? result;

  const CalculatorInput({
    Key? key,
    required this.firstNumberController,
    required this.secondNumberController,
    required this.onCalculate,
    this.result,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: firstNumberController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              hintText: 'Enter first number',
              border: OutlineInputBorder(),
            ),
          ),
        ),
        const SizedBox(width: 10),
        const Text('+'),
        const SizedBox(width: 10),
        Expanded(
          child: TextField(
            controller: secondNumberController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              hintText: 'Enter second number',
              border: OutlineInputBorder(),
            ),
          ),
        ),
        const SizedBox(width: 10),
        ElevatedButton(
          onPressed: onCalculate,
          child: const Text('='),
        ),
        const SizedBox(width: 10),
        Container(
          alignment: Alignment.center,
          width: 60,
          decoration: const BoxDecoration(
            border: Border(bottom: BorderSide(color: Colors.black, width: 1.0)),
          ),
          child: Text(
            result != null ? '$result' : ' ',
            style: const TextStyle(fontSize: 20),
          ),
        ),
      ],
    );
  }
}
