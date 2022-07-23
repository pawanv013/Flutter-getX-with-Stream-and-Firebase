import 'dart:async';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class CounterClass extends GetxController {
  StreamController<int> streamController = StreamController<int>();
  final _firestore = FirebaseFirestore.instance;

  void streamCount() async {
    try {
      await for (var snapshot
          in _firestore.collection('streamDB').snapshots()) {
        for (var countdt in snapshot.docs) {
          streamController.sink.add(countdt.data()['count']);
        }
      }
    } on FirebaseException catch (e) {
      log(e.message.toString());
    }
  }

  void updateCount(int count) {
    try {
      Map<String, int> upDatet = {"count": count + 1};
      _firestore.collection("streamDB").doc("countTbl").update(upDatet);
    } on FirebaseException catch (e) {
      log(e.message.toString());
    }
  }

  void minusCount(int count) {
    try {
      Map<String, int> upDatet = {"count": count - 1};
      _firestore.collection("streamDB").doc("countTbl").update(upDatet);
    } on FirebaseException catch (e) {
      log(e.message.toString());
    }
  }

  @override
  void onClose() {
    streamController.close();
  }
}
