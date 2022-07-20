import 'package:flutter/material.dart';

class TestPage extends StatefulWidget {
  const TestPage({Key? key}) : super(key: key);

  @override
  State<TestPage> createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  double animCricleClear = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            height: 200,
            color: Colors.red,
          ),
          Align(
            alignment: const Alignment(1, -1),
            child: Transform.translate(
              offset: const Offset(20, -10),
              child: AnimatedScale(
                duration: const Duration(milliseconds: 500),
                scale: animCricleClear,
                child: Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25), color: Colors.green),
                ),
                onEnd: () {
                  animCricleClear = 0;
                  setState(() {});
                },
              ),
            ),
          ),
        
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          animCricleClear = 20;
          setState(() {});
        },
      ),
    );
  }
}
