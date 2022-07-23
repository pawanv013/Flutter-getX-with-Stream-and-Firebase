// ignore_for_file: prefer__ructors

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_firebase_getx/getX/counter_class.dart';
import 'package:get/get.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

int count = 0;
final CounterClass counterClass = Get.put(CounterClass());

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    log('init called');
    counterClass.streamCount();
    log('init end');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('GetX Stream Frirebase'),
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              StreamBuilder(
                stream: counterClass.streamController.stream,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    count = snapshot.data as int;
                    return Text('${count}', style: TextStyle(fontSize: 60));
                  } else {
                    return Text('No data ');
                  }
                },
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () {
              counterClass.updateCount(count);
            },
            child: Icon(Icons.add),
          ),
          SizedBox(height: 10),
          FloatingActionButton(
            onPressed: () {
              counterClass.minusCount(count);
            },
            child: Icon(Icons.remove),
          ),
        ],
      ),
    );
  }
}
