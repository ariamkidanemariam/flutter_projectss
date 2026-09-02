import 'package:flutter/material.dart';

class CounterScreen extends StatefulWidget {
  const CounterScreen({super.key});

  @override
  State<CounterScreen> createState() {
    print("CreateSate");
    return _CounterScreenState();
  }
}

class _CounterScreenState extends State<CounterScreen> {
  late int _counter;

  @override
  void initState() {
    print("initstate");
    _counter = 0;
    super.initState();
  }

  @override
  void didChangeDependencies() {
    print('didChangeDependencies');
    super.didChangeDependencies();
  }

  @override
  void didUpdateWidget(covariant CounterScreen oldWidget) {
    print('didUpdateWidget');
    super.didUpdateWidget(oldWidget);
  }

  @override
  void deactivate() {
    print('deactivate');
    super.deactivate();
  }

  @override
  void dispose() {
    print('dispose');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print('build;');
    return Scaffold(
      appBar: AppBar(title: Text('Life Cycle Demo')),
      body: Column(
        children: [
          Text(_counter.toString()),

          ElevatedButton(
            onPressed: () {
              setState(() {
                _counter += 1;
              });
            },

            child: Text('Increment'),
          ),
        ],
      ),
    );
  }
}
