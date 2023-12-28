import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login_firebase/alert/show_dialog.dart';
import 'package:login_firebase/cubit/todo_cubit.dart';
import 'package:login_firebase/cubit/todo_state.dart';

class BuildToDo {
  static void showListTitle(BuildContext context) {
    TextEditingController newToDo = TextEditingController();
    showDialog(
      context: context,
      builder: (ct) {
        return AlertDialog(
          title: const Text('add to-do'),
          content: TextField(
            controller: newToDo,
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                if (newToDo.text.isNotEmpty) {
                  context.read<ToDoCubit>().createToDo(newToDo: newToDo.text);
                  if (kDebugMode) {
                    print(">>>>>>>create new todo");
                  }
                  Navigator.of(ct).pop();
                } else {
                  CustomDialog.showCustomDialog(
                      context, 'New todo isEmpty', 'enter your new todo');
                }
              },
              child: const Text('add'),
            ),
          ],
        );
      },
    );
  }
}
