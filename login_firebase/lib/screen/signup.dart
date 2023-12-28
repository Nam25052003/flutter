import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login_firebase/alert/show_dialog.dart';
import 'package:login_firebase/cubit/todo_cubit.dart';
import 'package:login_firebase/cubit/todo_state.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  TextEditingController emailCtrl = TextEditingController();
  TextEditingController passwordCtrl = TextEditingController();
  TextEditingController passwordConfirmCtrl = TextEditingController();

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
            Padding(
              padding: const EdgeInsets.all(16),
              child: TextField(
                controller: passwordConfirmCtrl,
                decoration: const InputDecoration(
                    labelText: 'password confirm',
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
                      if (emailCtrl.text.isNotEmpty && passwordCtrl.text.isNotEmpty) {
                        if (passwordCtrl.text.length >= 6) {
                          if (passwordCtrl.text == passwordConfirmCtrl.text) {
                            context.read<ToDoCubit>().SignupAuthF(
                                email: emailCtrl.text,
                                password: passwordCtrl.text,
                                context: context);
                            if (kDebugMode) {
                              print(
                                  '--------------------------sign up success------------------------------------');
                            }
                            Navigator.pushNamed(context, '/homepage');
                          } else {
                            CustomDialog.showCustomDialog(
                                context,
                                'alert signup',
                                'check password & password confirm');
                          }
                        } else {
                          CustomDialog.showCustomDialog(
                              context, 'alert signup', ' password length > 6');
                        }
                      } else {
                        CustomDialog.showCustomDialog(context, 'alert signup',
                            'enter your email, password & password confirm');
                      }
                    },
                    child: const Text('Login'),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
