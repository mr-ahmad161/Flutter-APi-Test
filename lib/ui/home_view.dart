import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../view_model/user_model.dart';
import 'loading_list_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('List Of Users'),
      ),
      body: ChangeNotifierProvider(
        create: (context) => UserModel(),
        child: Builder(builder: (context) {
          final model = Provider.of<UserModel>(context);

          if (model.homeState == HomeState.Loading) {
            return const Center(child: LoadingListPage());
          }
          if (model.homeState == HomeState.Error) {
            return Center(child: Text('An Error Occured ${model.message}'));
          }
          final users = model.users;
          return ListView.builder(
            itemCount: users.length,
            itemBuilder: (context, index) {
              final user = users[index];
              return ListTile(
                leading: FadeInImage.assetNetwork(
                  placeholder: 'assets/images/Ahmad.jpeg',
                  image: 'https://loremflickr.com/320/240',
                ),
                title: Text(user.name),
                subtitle: Text(user.address.street),
              );
            },
          );
        }),
      ),
    );
  }
}
