import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:simplechatapp/data/modal/user_data.dart';
import 'package:simplechatapp/repo/auth_repo.dart';

class UserController {
  final bool isError;
  final String message;
  final bool isLoading;
  final UserData? userData;

  UserController({
    required this.isError,
    required this.message,
    required this.isLoading,
    required this.userData,
  });

  UserController copyWith({
    bool? isError,
    String? message,
    bool? isLoading,
    UserData? userData,
  }) {
    return UserController(
      isError: isError ?? this.isError,
      message: message ?? this.message,
      isLoading: isLoading ?? this.isLoading,
      userData: userData ?? this.userData,
    );
  }
}

class UserProvider extends StateNotifier<UserController> {
  final Ref ref;

  UserProvider(this.ref)
      : super(UserController(
          isError: false,
          message: "",
          isLoading: false,
          userData: null,
        ));

  Future<void> signUpWithEmailAndPassword({
    required String email,
    required String password,
    required String name,
  }) async {
    state = state.copyWith(isLoading: true, isError: false, message: "");
    try {
      final UserData? data =
          await ref.read(authRepoProvider).signUpWithEmailAndPassword(
                email: email,
                password: password,
                name: name,
              );
      if (data != null) {
        state = state.copyWith(
          userData: data,
          isLoading: false,
          isError: false,
          message: "",
        );
      } else {
        state = state.copyWith(
          isLoading: false,
          isError: true,
          message: "Sign-up failed. Please try again.",
        );
      }
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        isError: true,
        message: e.toString(),
      );
    }
  }

  // login
  Future signInwithEmailAndPassword(
      {required String email, required String password}) async {
    try {
      state = state.copyWith(isLoading: true);
      final userData = await ref
          .read(authRepoProvider)
          .signInWithEmailAndPassword(email: email, password: password);
      state = state.copyWith(
          userData: userData,
          isLoading: false,
          isError: false,
          message: "user loggin successfully");
    } catch (e) {
      state = state.copyWith(
          userData: null,
          isError: true,
          isLoading: false,
          message: e.toString());
    }
  }

  // logout function
  Future logout() async {
    await ref.read(authRepoProvider).signOut();
    state = state.copyWith(
        userData: null,
        isLoading: false,
        isError: false,
        message: "User Logout suceessfully");
  }
}

final userProvider = StateNotifierProvider<UserProvider, UserController>(
  (ref) {
    return UserProvider(ref);
  },
);
