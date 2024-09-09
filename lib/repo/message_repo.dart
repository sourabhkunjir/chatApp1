import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:simplechatapp/data/modal/message_data.dart';

class MessageRepo {
  final Ref ref;
  final FirebaseFirestore _firestore;

  MessageRepo({required this.ref}) : _firestore = FirebaseFirestore.instance;

  Future<void> sendMessage({required MessageData messageData}) async {
    try {
      await _firestore.collection('messages').add(messageData.toJson());
    } catch (e) {
      return Future.error(e);
    }
  }

  Stream<Iterable<MessageData>> getAllMessages() async* {
    yield* _firestore
        .collection('messages')
        .orderBy('timeStamp',
            descending: true) // Ensure this matches the Firestore field exactly
        .snapshots()
        .map((snapshot) {
      log("Fetched ${snapshot.docs.length} messages"); // Debugging log
      return snapshot.docs.map((doc) => MessageData.fromJson(doc.data()));
    }).handleError((e) {
      log("Error in getting messages: $e");
    });
  }
}

final messageRepoProvider = Provider(
  (ref) => MessageRepo(ref: ref),
);
