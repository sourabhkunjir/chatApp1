import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:simplechatapp/data/modal/message_data.dart';
import 'package:simplechatapp/data/modal/user_data.dart';
import 'package:simplechatapp/provider/message_stream_provider.dart';
import 'package:simplechatapp/repo/message_repo.dart';
import 'package:simplechatapp/utils/build_context_extension.dart';

class ChatScreen extends ConsumerWidget {
  ChatScreen({required this.userData, super.key});
  final UserData userData;

  final TextEditingController _messageController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final messageStream = ref.watch(messageStreamProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text(userData.name!),
      ),
      body: Stack(
        children: [
          messageStream.when(
            data: (messageList) {
              log("Number of messages received: ${messageList.length}"); 
              return Positioned(
                top: 0,
                bottom: 90,
                left: 0,
                right: 0,
                child: ListView.builder(
                  reverse: true,
                  itemCount: messageList.length,
                  itemBuilder: (context, index) {
                    final messageData = messageList.elementAt(index);
                    return ListTile(
                      title: Text(
                          messageData.message ?? "No Message"), 
                    );
                  },
                ),
              );
            },
            error: (error, stackTrace) {
              log("Error in stream: $error"); 
              return Center(
                child: Text(error.toString()),
              );
            },
            loading: () => Center(child: CircularProgressIndicator()),
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: SizedBox(
              height: context.getHeight(0.8),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              height: 70,
              alignment: Alignment.topCenter,
              color: Colors.red[200],
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: context.getWidth(0.8),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        controller: _messageController,
                        decoration: InputDecoration(hintText: "Type a message"),
                      ),
                    ),
                  ),
                  IconButton(
                      onPressed: () async {
                        // send message
                        final MessageData messageData = MessageData(
                            message: _messageController.text.trim(),
                            recieverId: userData.uid,
                            senderId: FirebaseAuth.instance.currentUser!.uid,
                            timeStamp: DateTime.now()
                                .millisecondsSinceEpoch
                                .toString(),
                            type: "text");
                        await ref
                            .read(messageRepoProvider)
                            .sendMessage(messageData: messageData)
                            .then(
                          (value) {
                            _messageController.clear();
                          },
                        );
                      },
                      icon: Icon(Icons.send))
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
