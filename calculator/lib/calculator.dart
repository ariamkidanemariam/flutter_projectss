import 'package:calculator/lifecylcle.dart';
import 'package:flutter/material.dart';

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  State<CalculatorScreen> createState() {
    return _CalculatorScreenState();
  }
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  final _num1Controller = TextEditingController();
  final _num2Controller = TextEditingController();

  String _result = "";

  void _calculate(String operation) {
    final _num1 = double.tryParse(_num1Controller.text);
    final _num2 = double.tryParse(_num2Controller.text);

    if (_num1 == null || _num2 == null) {
      setState(() {
        _result = 'Enter a valid number';
      });
      return;
    }
    setState(() {
      switch (operation) {
        case "+":
          _result = (_num1 + _num2).toString();
        case "-":
          _result = (_num1 - _num2).toString();
        case "*":
          _result = (_num1 * _num2).toString();
        case "/":
          _result = (_num1 / _num2).toString();
        default:
          _result = 'Invalid Operator';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Calculator')),
      body: Container(
        padding: EdgeInsets.all(24),
        child: Column(
          children: [
            TextField(
              controller: _num1Controller,
              decoration: InputDecoration(labelText: 'Enter num 1'),
              keyboardType: TextInputType.numberWithOptions(decimal: true),
            ),

            SizedBox(height: 24),

            TextField(
              controller: _num2Controller,
              decoration: InputDecoration(labelText: 'Enter num 2'),
              keyboardType: TextInputType.numberWithOptions(decimal: true),
            ),

            SizedBox(height: 24),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CalculatorButton(label: '+', onPressed: () => _calculate('+')),
                CalculatorButton(label: '-', onPressed: () => _calculate('-')),
                CalculatorButton(label: '*', onPressed: () => _calculate('*')),
                CalculatorButton(label: '/', onPressed: () => _calculate('/')),
              ],
            ),

            SizedBox(height: 24),

            Text(
              _result,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),


            SizedBox(height: 24),
            
            
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CounterScreen()),
                );
              },
              child: Text('Lifecycle'),
            ),
          ],
        ),
      ),
    );
  }
 @override
  void dispose() {
   _num1Controller.dispose();
   _num2Controller.dispose();
    super.dispose();
  }
}

class CalculatorButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;

  const CalculatorButton({
    super.key,
    required this.label,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(onPressed: onPressed, child: Text(label));
  }
  
}
