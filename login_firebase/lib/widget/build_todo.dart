import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login_firebase/cubit/todo_cubit.dart';
import 'package:login_firebase/cubit/todo_state.dart';

class BuildToDo {
  static void showListTitle(BuildContext context, String collectionToDo, [String? content, String? id]) {
    BlocBuilder<ToDoCubit,ToDo>(
      builder: (context, state) {
        return ListTile(
          title: Text(content!),
          onLongPress: () {},
          trailing: TextButton(
              onPressed: () {
                context.read<ToDoCubit>().deleteToDo(context, collectionToDo, id!);
              },
              child: const Icon(Icons.delete)),
        );
      },
    );
  }
}
