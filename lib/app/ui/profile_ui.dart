import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:learn_flutter_testing/app/repositories/user_repository.dart';

import '../models/user_model.dart';

class ProfileUi extends StatefulWidget {
  const ProfileUi({
    super.key,
  });

  @override
  State<ProfileUi> createState() => _ProfileUiState();
}

class _ProfileUiState extends State<ProfileUi> {
  Future<User> getUsers = UserRepository(Client()).getUser();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title:
            Text("Profile", style: Theme.of(context).textTheme.headlineMedium),
      ),
      body: FutureBuilder(
          future: getUsers,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            return Center(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '${snapshot.data!.name}',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                Text(
                  '${snapshot.data!.email}',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                Text(
                  '${snapshot.data!.website}',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
              ],
            ));
          }),
    );
  }
}
