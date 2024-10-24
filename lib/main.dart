import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Adder with Quotes',
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
    _fetchQuote();
  }

  Future<void> _fetchQuote() async {
    final response = await http.get(Uri.parse('https://zenquotes.io/api/random'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      setState(() {
        _quote = data[0]['q'] + " - " + data[0]['a'];
      });
    } else {
      setState(() {
        _quote = "Failed to load quote";
      });
    }
  }

  void _calculate() {
    int num1 = int.tryParse(_firstNumberController.text) ?? 0;
    int num2 = int.tryParse(_secondNumberController.text) ?? 0;
    setState(() {
      _result = num1 + num2;
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
            Text("Quote of the day"),
            const SizedBox(height: 10),
            Text(
              _quote,
              style: const TextStyle(fontSize: 18, fontStyle: FontStyle.italic),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: _fetchQuote, // Calls _fetchQuote to fetch new quotes
              child: const Text('New Quote'),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _firstNumberController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(hintText: 'Enter first number',border: OutlineInputBorder()),
                  ),
                ),
                const SizedBox(width: 10),
                const Text('+'),
                const SizedBox(width: 10),
                Expanded(
                  child: TextField(
                    controller: _secondNumberController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(hintText: 'Enter second number',
                    border: OutlineInputBorder()),
                  ),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: _calculate,
                  child: const Text('='), // Performs calculation and clears fields
                ),
                const SizedBox(height: 20),
                Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(left: 10),
                  width: 60,
                  decoration: BoxDecoration(
                    border: Border(bottom: BorderSide(color: Colors.black,width: 1.0))
                  ),
                  child: Text(
                    _result != null ? '$_result' : ' ',
                    style: const TextStyle(fontSize: 20),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.all(0),
                itemCount: _history.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: const Text('•'),
                    title: Text(_history[index]),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
