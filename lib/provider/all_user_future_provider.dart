import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:simplechatapp/data/modal/user_data.dart';

final allUsersFutureProvider = FutureProvider<List<UserData>>((ref) async {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  try {
    final value = await _firestore.collection('users').get();
    if (value.docs.isNotEmpty) {
      final users =
          value.docs.map((user) => UserData.fromJson(user.data())).toList();
      return users;
    } else {
       log("No users found");
      return Future.error('No users found');
    }
  } catch (error) {
    log("Failed to get users list");
    return Future.error(error);
  }
});


