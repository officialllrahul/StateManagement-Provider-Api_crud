import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'jsonUsersDataModel.dart';
import 'jsonUsersProvider.dart';

class UserListWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User List'),
      ),
      body: Consumer<UserProvider>(
        builder: (context, userProvider, _) {
          // Fetch users when the widget is built
          userProvider.fetchUsers();
          return ListView.builder(
            itemCount: userProvider.users.length,
            itemBuilder: (context, index) {
              var user = userProvider.users[index];
              return ListTile(
                title: Text(user.name),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(user.email),
                    Text(user.phone),
                    Text('Address: ${user.address.street}, ${user.address.suite}, ${user.address.city}, ${user.address.zipcode}'),
                    Text('Latitude: ${user.address.geo.lat}'),
                    Text('Longitude: ${user.address.geo.lng}'),
                    // Update Button
                    ElevatedButton(
                      onPressed: () async {
                        User updatedUser = await userProvider.updateUser(user.copyWith(
                          name: 'Updated Name', // Replace with desired fields
                        ));
                        print('Updated User: $updatedUser');
                      },
                      child: Text('Update'),
                    ),

                    // Delete Button
                    ElevatedButton(
                      onPressed: () async {
                        await userProvider.deleteUser(user.id);
                        print('Deleted User: ${user.id}');
                      },
                      child: Text('Delete'),
                    ),
                  ],
                ),
                // Add more user details as needed
              );
            },
          );
        },
      ),
    );
  }
}
