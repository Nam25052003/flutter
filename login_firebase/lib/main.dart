import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login_firebase/cubit/todo_cubit.dart';
import 'package:login_firebase/screen/home.dart';
import 'package:login_firebase/screen/login.dart';
import 'package:login_firebase/screen/signup.dart';
import 'package:login_firebase/share_preference/share_preference_singleton.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharePreferencesSingleton.instance.init();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  ToDoCubit toDoCubit = ToDoCubit();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'firebase',
      initialRoute: '/',
      routes: {
        '/': (context) => BlocProvider.value(
              value: toDoCubit,
              child: const MyPage(),
            ),
        '/login': (context) => BlocProvider.value(
              value: toDoCubit,
              child: const Login(),
            ),
        '/signup': (context) => BlocProvider.value(
              value: toDoCubit,
              child: const Signup(),
            ),
        '/homepage': (context) => BlocProvider.value(
              value: toDoCubit,
              child: const HomePage(),
            ),
      },
    );
  }
}

class MyPage extends StatefulWidget {
  const MyPage({super.key});

  @override
  State<MyPage> createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  @override
  Widget build(BuildContext context) {
    return const Login();
  }
}
