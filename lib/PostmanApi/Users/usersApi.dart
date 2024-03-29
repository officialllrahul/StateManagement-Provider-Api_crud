import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:statemanagementflutter/PostmanApi/Users/usersDataModel.dart';
import 'package:statemanagementflutter/PostmanApi/Users/usersProvider.dart';

class CustomerHomePage extends StatefulWidget {
  @override
  State<CustomerHomePage> createState() => _CustomerHomePageState();
}

class _CustomerHomePageState extends State<CustomerHomePage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  Future<void> _submitForm(BuildContext context) async {
    final String name = nameController.text.trim();
    final String email = emailController.text.trim();

    if (name.isNotEmpty && email.isNotEmpty) {
      try {
        await Provider.of<CustomersProvider>(context, listen: false)
            .createCustomer(name, email);
        // Optionally, clear the text fields after successful submission
        nameController.clear();
        emailController.clear();
      } catch (e) {
        print('Error creating customer: $e');
      }
    } else {
      // Display a message or alert about empty fields
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please fill in all fields'),
        ),
      );
    }
  }

  Future<void> _updateCustomer(BuildContext context, String customerId) async {
    final String newName = nameController.text.trim();
    final String newEmail = emailController.text.trim();

    if (newName.isNotEmpty && newEmail.isNotEmpty) {
      try {
        await Provider.of<CustomersProvider>(context, listen: false)
            .updateCustomer(customerId, newName, newEmail);

        // Optionally, clear the text fields after successful update
        nameController.clear();
        emailController.clear();
      } catch (e) {
        print('Error updating customer: $e');
        // Handle error
      }
    } else {
      // Display a message or alert about empty fields
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please fill in all fields'),
        ),
      );
    }
  }

  void _showUpdateDialog(BuildContext context, Item currentItem) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Update User'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: InputDecoration(
                    labelText: 'Name', hintText: currentItem.name),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: emailController,
                decoration: InputDecoration(
                    labelText: 'Email', hintText: currentItem.email),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                _updateCustomer(context, currentItem.id.toString());
                Navigator.pop(context);
              },
              child: const Text('Update'),
            ),
          ],
        );
      },
    );
  }

  void _showDeleteDialog(BuildContext context, String customerId) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Delete User'),
          content: const Text('Are you sure you want to delete this user?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Fluttertoast.showToast(
                  msg: "Sorry, you are not allowed to delete this user",
                  toastLength: Toast.LENGTH_SHORT,
                );
              },
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User List'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: 'Name'),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: emailController,
              decoration: const InputDecoration(labelText: 'Email'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                _submitForm(context);
              },
              child: const Text('Create User'),
            ),
            const SizedBox(height: 20),
            FutureProvider<List<Item>?>(
              create: (_) => CustomersProvider().fetchData(),
              catchError: (_, error) {
                print('Error fetching data: $error');
                return null;
              },
              initialData: null,
              child: Consumer<List<Item>?>(
                builder: (context, items, _) {
                  if (items == null || items.isEmpty) {
                    return const Center(child: CircularProgressIndicator());
                  } else {
                    return Expanded(
                      child: ListView.builder(
                        itemCount: items.length,
                        itemBuilder: (context, index) {
                          Item currentItem = items[index];
                          return ListTile(
                            title: Text(currentItem.name.toString()),
                            subtitle: Text(currentItem.email.toString()),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.edit),
                                  onPressed: () {
                                    _showUpdateDialog(context, currentItem);
                                  },
                                ),
                                IconButton(
                                  icon: const Icon(Icons.delete),
                                  onPressed: () {
                                    _showDeleteDialog(
                                        context, currentItem.id.toString());
                                  },
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

}
