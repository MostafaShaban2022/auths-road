import 'package:auths_road/cubit/auth_cubit.dart';
import 'package:auths_road/cubit/page_cubit.dart';
import 'package:auths_road/pages/log_up.dart';
import 'package:auths_road/pages/phone_number.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyB-hoMrhsvuWlRIpgr9qdx0s8uL7vlVlTs",
      appId: "auths-road",
      messagingSenderId: "487985682399",
      projectId: "auths-road",
    ),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => PageCubit(),
        ),
        BlocProvider(
          create: (context) => AuthCubit(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: LogUp(
          controller: TextEditingController(),
        ),
      ),
    );
  }
}
