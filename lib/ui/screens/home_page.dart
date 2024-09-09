import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:simplechatapp/provider/all_user_future_provider.dart';
import 'package:simplechatapp/provider/user_provider.dart';
import 'package:simplechatapp/ui/screens/chat_screen.dart';
import 'package:simplechatapp/ui/screens/splash_screen.dart';
import 'package:simplechatapp/utils/build_context_extension.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  @override
  Widget build(BuildContext context) {
    final AsyncValue allUsers = ref.watch(allUsersFutureProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text("Home Page"),
        backgroundColor: Colors.red,
        actions: [
          IconButton(
            onPressed: () async {
              await ref.read(userProvider.notifier).logout().then(
                (value) {
                  context.navigateToScreen(SplashScreen(), isReplace: true);
                },
              );
            },
            icon: Icon(Icons.logout),
          ),
        ],
      ),
      body: allUsers.when(
        data: (data) {
          return ListView.separated(
            separatorBuilder: (context, index) => Divider(),
            itemCount: data.length,
            itemBuilder: (context, index) {
              final user = data[index];
              return ListTile(
                onTap: () {
                  context.navigateToScreen(ChatScreen(userData: user,));
                },
                title: Text(user.name),
                subtitle: Text(user.email),
              );
            },
          );
        },
        error: (error, stackTrace) {
          return Center(
            child: Text("Error occurred: ${error.toString()}"),
          );
        },
        loading: () => Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
