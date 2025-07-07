import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_sample/helper.dart';
import 'package:riverpod_sample/providers.dart';

class LoginScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      home: Scaffold(
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Consumer(
                builder: (context, ref, child) {
                  final email = ref.watch(
                    authenticationProvider.select(
                      (loginModel) => loginModel.email,
                    ),
                  );
                  return TextFormField(
                    onChanged: (value) {
                      ref
                          .read(authenticationProvider.notifier)
                          .updateEmail(value);
                    },
                    decoration: InputDecoration(
                      hintText: "Email",
                      errorText: () {
                        if (email?.trim().isEmpty == true) {
                          return "Please enter email";
                        } else if (email != null && !validateEmail(email)) {
                          return "Enter valid email address";
                        }
                        return null;
                      }(),
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Consumer(
                builder: (context, ref, child) {
                  final password = ref.watch(
                    authenticationProvider.select(
                      (loginModel) => loginModel.password,
                    ),
                  );
                  return TextFormField(
                    onChanged: (value) {
                      ref
                          .read(authenticationProvider.notifier)
                          .updatePassword(value);
                    },
                    decoration: InputDecoration(
                      hintText: "Password",
                      errorText: () {
                        if (password?.trim().isEmpty == true) {
                          return "Please enter password";
                        }
                        return null;
                      }(),
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Consumer(
                builder: (context, ref, child) {
                  final loginModel = ref.watch(authenticationProvider);
                  return ElevatedButton(
                    onPressed: () {
                      if (loginModel.isValidCredential &&
                          !loginModel.isLoading) {
                        print("valid");
                        ref.read(authenticationProvider.notifier).loginUser();
                      }
                    },
                    style: ButtonStyle(
                      backgroundColor: WidgetStatePropertyAll<Color?>(
                        loginModel.isValidCredential
                            ? Colors.cyan
                            : Colors.grey.shade200,
                      ),
                    ),
                    child:
                        loginModel.isLoading
                            ? CircularProgressIndicator()
                            : Text(
                              "Login",
                              style: TextStyle(
                                color:
                                    loginModel.isValidCredential
                                        ? Colors.black
                                        : Colors.grey,
                              ),
                            ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
