import 'package:flutter/material.dart';
import 'package:flutter_test_chatapp/screen/message_list_screen.dart';

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
    return MaterialApp(
      title: 'Veiz Chat',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MessageListScreen(chatDocId: '3df091j2jdf9102980',),
    );
  }
}
