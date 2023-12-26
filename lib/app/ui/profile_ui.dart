import 'package:flutter/material.dart';

import '../models/user_model.dart';

class ProfileUi extends StatefulWidget {
  const ProfileUi({
    super.key,
    required this.futureUser,
  });

  final Future<User> futureUser;

  @override
  State<ProfileUi> createState() => _ProfileUiState();
}

class _ProfileUiState extends State<ProfileUi> {
  //Future<User> getUser = UserRepository(Client()).getUser();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title:
            Text("Profile", style: Theme.of(context).textTheme.headlineMedium),
      ),
      body: FutureBuilder(
          future: widget.futureUser,
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
