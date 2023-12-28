import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login_firebase/alert/show_dialog.dart';
import 'package:login_firebase/cubit/todo_state.dart';
import 'package:login_firebase/share_preference/share_preference_singleton.dart';

class ToDoCubit extends Cubit<ToDo> {
  ToDoCubit()
      : super(InitialToDoState(id: '', content: '', date: null, account: ''));
  FirebaseAuth auth = FirebaseAuth.instance;

  Future<User?> loginAuthF(
      {required String email,
      required String password,
      required BuildContext context}) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;
    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      user = userCredential.user;
    } on FirebaseAuthException catch (e) {
      // ignore: use_build_context_synchronously
      CustomDialog.showCustomDialog(
          context, 'Login', 'check username & password');
      if (kDebugMode) {
        print('log error (login): $e');
      }
    }
    return user;
  }

  // ignore: non_constant_identifier_names
  Future SignupAuthF(
      {required String email,
      required String password,
      required BuildContext context}) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    try {
      await auth.createUserWithEmailAndPassword(
          email: email, password: password);
    } catch (e) {
      if (kDebugMode) {
        print('log error (sign up): $e');
      }
    }
  }

  Future<void> createToDo({required String newToDo}) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    // Reference to document
    final docToDo = FirebaseFirestore.instance.collection('todo').doc();
    ToDo toDo = CurrentToDoState(
        id: docToDo.id,
        content: newToDo,
        date: DateTime.now(),
        account: auth.currentUser!.email.toString());
    // ToDo(
    //     id: docToDo.id,
    //     content: newToDo,
    //     date: DateTime.now(),
    //     account: auth.currentUser!.email.toString());

    emit(toDo);
    final json = toDo.toJson();
    await docToDo.set(json);
  }

  // Future<void> editToDo(
  //     BuildContext context, String collectionToDo, String idToDo) async {
  //   final docToDo =
  //       FirebaseFirestore.instance.collection(collectionToDo).doc(idToDo);
  // }

  Future<void> deleteToDo(
      BuildContext context, String collectionToDo, String idToDo) async {
    final docToDo =
        FirebaseFirestore.instance.collection(collectionToDo).doc(idToDo);
    docToDo.delete().then((value) {
      CustomDialog.showCustomDialog(context, 'delete', 'delete success');
    }).catchError((onError) {
      CustomDialog.showCustomDialog(context, 'delete', 'delete fail');
    });
  }

  Stream<List<ToDo>> readToDo() {
    return FirebaseFirestore.instance.collection('todo').snapshots().map(
        (snapshot) => snapshot.docs
            .map((doc) => ToDo.fromJson(doc.data()))
            .where((todo) => todo.account == auth.currentUser!.email)
            .toList());
  }

  // Stream<List<ToDo>> readToDo() {
  //   return FirebaseFirestore.instance
  //       .collection('todo')
  //       .snapshots()
  //       .asyncMap((snapshot) async {
  //     // Get the user account from SharedPreferences
  //     String storedAccount =
  //     SharePreferencesSingleton.instance.getString(key: 'account');
  //
  //     // If there's a stored account, use it; otherwise, use the current user's email
  //     String currentUserAccount =
  //     storedAccount.isNotEmpty ? storedAccount : auth.currentUser!.email!;
  //
  //     // Filter todos based on the user account
  //     List<ToDo> todos = snapshot.docs
  //         .map((doc) => ToDo.fromJson(doc.data()))
  //         .where((todo) => todo.account == currentUserAccount)
  //         .toList();
  //
  //     return todos;
  //   });
  // }
}
