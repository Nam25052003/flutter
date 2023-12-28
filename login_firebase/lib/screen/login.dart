import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login_firebase/alert/show_dialog.dart';
import 'package:login_firebase/cubit/todo_cubit.dart';
import 'package:login_firebase/cubit/todo_state.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController emailCtrl = TextEditingController();
  TextEditingController passwordCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Firebase'),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: TextField(
                controller: emailCtrl,
                decoration: const InputDecoration(
                    labelText: 'email',
                    prefixIcon: Icon(
                      Icons.email,
                      color: Colors.black,
                    )),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: TextField(
                obscureText: true,
                controller: passwordCtrl,
                decoration: const InputDecoration(
                    labelText: 'password',
                    prefixIcon: Icon(
                      Icons.lock,
                      color: Colors.black,
                    )),
              ),
            ),
            BlocBuilder<ToDoCubit, ToDo>(
              builder: (context, state) {
                return Padding(
                  padding: const EdgeInsets.all(16),
                  child: ElevatedButton(
                    onPressed: () async {
                      if (emailCtrl.text.isNotEmpty &&
                          passwordCtrl.text.isNotEmpty) {
                        User? user = await context.read<ToDoCubit>().loginAuthF(
                            email: emailCtrl.text,
                            password: passwordCtrl.text,
                            context: context);
                        if (user != null) {
                          if (kDebugMode) {
                            print(
                                "-------------------login success------------------------");
                          }
                          // ignore: use_build_context_synchronously
                          Navigator.pushNamed(context, '/homepage');
                        }
                      } else {
                        CustomDialog.showCustomDialog(
                            context, 'alert login', 'email or password isEmty');
                      }
                    },
                    child: const Text('Login'),
                  ),
                );
              },
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/signup');
                },
                child: const Text('sign up'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
