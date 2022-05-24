import 'package:flutter/material.dart';
import 'package:flutter_test_chatapp/routes.dart';
import 'package:flutter_test_chatapp/screen/chat/message_list_screen.dart';
import 'package:flutter_test_chatapp/screen/splash_screen.dart';
import 'package:flutter_test_chatapp/screen/unkown_screen.dart';
import 'package:flutter_test_chatapp/state/user_state.dart';
import 'package:provider/provider.dart';

import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) {
            return UserState();
          },
        )
      ],
      child: MaterialApp(
        title: 'IZ Talk',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
          onGenerateRoute:(settings) {
            return Routes().getRoutes(context, settings: settings);
          } ,
        home: SplashScreen()
      ),
    );
  }
}
