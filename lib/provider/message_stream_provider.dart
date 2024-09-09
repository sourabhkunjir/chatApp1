import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:simplechatapp/data/modal/message_data.dart';
import 'package:simplechatapp/repo/message_repo.dart';

// Define the provider
final messageStreamProvider =
    StreamProvider.autoDispose<Iterable<MessageData>>((ref) {
  return ref.watch(messageRepoProvider).getAllMessages();
});
