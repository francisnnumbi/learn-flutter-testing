import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:learn_flutter_testing/app/ui/profile_ui.dart';

import 'app/repositories/user_repository.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: ProfileUi(
        userRepository: UserRepository(Client()),
      ),
    );
  }
}
