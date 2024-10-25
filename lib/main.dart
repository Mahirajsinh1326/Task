import 'package:flutter/material.dart';
import 'package:task/ui/calculator_input.dart';
import 'package:task/ui/history_list.dart';
import 'package:task/ui/quote_widget.dart';
import 'quote_service.dart';
import 'calculator_service.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Task',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.lightBlue),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Task'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController _firstNumberController = TextEditingController();
  final TextEditingController _secondNumberController = TextEditingController();
  List<String> _history = [];
  int? _result;
  String _quote = "Loading...";

  @override
  void initState() {
    super.initState();
    _getQuote();
  }

  Future<void> _getQuote() async {
    String quote = await fetchQuote();
    setState(() {
      _quote = quote;
    });
  }

  void _calculate() {
    int num1 = int.tryParse(_firstNumberController.text) ?? 0;
    int num2 = int.tryParse(_secondNumberController.text) ?? 0;
    setState(() {
      _result = calculate(num1, num2);
      _history.add('$num1 + $num2 = $_result');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            QuoteWidget(
              quote: _quote,
              onNewQuote: _getQuote,
            ),
            const SizedBox(height: 20),
            CalculatorInput(
              firstNumberController: _firstNumberController,
              secondNumberController: _secondNumberController,
              onCalculate: _calculate,
              result: _result,
            ),
            const SizedBox(height: 20),
            HistoryList(history: _history),
          ],
        ),
      ),
    );
  }
}
