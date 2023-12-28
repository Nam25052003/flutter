import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login_firebase/cubit/todo_cubit.dart';
import 'package:login_firebase/cubit/todo_state.dart';

import '../widget/create_todo.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

FirebaseAuth auth = FirebaseAuth.instance;

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Home'),
          actions: [
            ElevatedButton(
              onPressed: () async {
                FirebaseAuth auth = FirebaseAuth.instance;
                await auth.signOut();
                if (kDebugMode) {
                  print(
                      '--------------------------------sign out----------------------------------------------');
                }
                // ignore: use_build_context_synchronously
                Navigator.pushNamed(context, '/login');
              },
              child: const Icon(Icons.logout),
            ),
          ],
        ),
        body: BlocBuilder<ToDoCubit, ToDo>(
          builder: (context, state) {
            return ListView(
              children: [

              ],
            );
          },
        ),
        floatingActionButton: BlocBuilder<ToDoCubit,ToDo>(
          builder: (context, state) {
            return FloatingActionButton(
              onPressed: () {
                BuildToDo.showListTitle(context);
              },
              child: const Icon(Icons.add),
            );
          },
        ));
  }
}
