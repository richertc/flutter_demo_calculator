import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Demo Rechner',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Rechner'),
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
  String _result = "";
  List<String> _inputs = [];

  bool _isOperand(String str) {
    return ["+", "-", "*", "/"].contains(str);
  }

  void _setInput(String char) {
    if (_inputs.isEmpty || _isOperand(_inputs.last)) {
      setState(() {
        _inputs.add(char);
      });
    } else {
      setState(() {
        _inputs.last += char;
      });
    }

    _overrideResultOutput();
  }

  void _overrideResultOutput() {
    String resultOutput = "";
    for (var element in _inputs) {
      resultOutput += "$element ";
    }

    setState(() {
      _result = resultOutput;
    });
  }

  void _setOperand(String char) {
    if (_inputs.isNotEmpty) {
      if (!_isOperand(_inputs.last)) {
        setState(() {
          _inputs.add(char);
        });
      } else {
        setState(() {
          _inputs.last = char;
        });
      }
    }

    _overrideResultOutput();
  }

  void _runOperation() {
    Parser p = Parser();
    Expression exp = p.parse(_result);
    setState(() {
      _result = exp.evaluate(EvaluationType.REAL, ContextModel()).toString();
      _inputs = [_result];
    });
  }

  void _clearInput() {
    setState(() {
      _inputs = [];
      _result = "";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Text(_result),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () => _setInput("1"),
                  child: const Text("1"),
                ),
                ElevatedButton(
                  onPressed: () => _setInput("2"),
                  child: const Text("2"),
                ),
                ElevatedButton(
                  onPressed: () => _setInput("3"),
                  child: const Text("3"),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () => _setInput("4"),
                  child: const Text("4"),
                ),
                ElevatedButton(
                  onPressed: () => _setInput("5"),
                  child: const Text("5"),
                ),
                ElevatedButton(
                  onPressed: () => _setInput("6"),
                  child: const Text("6"),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () => _setInput("7"),
                  child: const Text("7"),
                ),
                ElevatedButton(
                  onPressed: () => _setInput("8"),
                  child: const Text("8"),
                ),
                ElevatedButton(
                  onPressed: () => _setInput("9"),
                  child: const Text("9"),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: _clearInput,
                  child: const Text("A/C"),
                ),
                ElevatedButton(
                  onPressed: () => _setInput("0"),
                  child: const Text("0"),
                ),
                ElevatedButton(
                  onPressed: () => _setInput("."),
                  child: const Text("."),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () => _setOperand("+"),
                  child: const Text("+"),
                ),
                ElevatedButton(
                  onPressed: () => _setOperand("-"),
                  child: const Text("-"),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () => _setOperand("*"),
                  child: const Text("*"),
                ),
                ElevatedButton(
                  onPressed: () => _setOperand("/"),
                  child: const Text("/"),
                ),
              ],
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _runOperation,
        tooltip: 'Run Calculation',
        child: const Text("="),
      ),
    );
  }
}
