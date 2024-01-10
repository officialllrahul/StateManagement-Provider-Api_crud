
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:statemanagementflutter/PostmanApi/Items/itemDataModel.dart';

import 'itemProvider.dart';

class itemsHomepage extends StatefulWidget {
  @override
  State<itemsHomepage> createState() => _itemsHomepageState();
}

class _itemsHomepageState extends State<itemsHomepage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController amountController = TextEditingController();

  Future<void> _submitForm(BuildContext context) async {
    final String name = nameController.text.trim();
    final String description = descriptionController.text.trim();
    final int amount = int.parse(amountController.text.trim());

    if (name.isNotEmpty && description.isNotEmpty && amount != null) {
      try {
        await Provider.of<RazorPayItemsProvider>(context, listen: false)
            .createItems(name, description, amount);
        nameController.clear();
        descriptionController.clear();
        amountController.clear();
      } catch (e) {
        print('Error creating customer: $e');
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please fill in all fields'),
        ),
      );
    }
  }

  Future<void> _updateCustomer(BuildContext context, String itemId) async {
    final String newName = nameController.text.trim();
    final String newDescription = descriptionController.text.trim();
    final int amount = int.parse(amountController.text.trim()); // Parse amount as int

    if (newName.isNotEmpty && newDescription.isNotEmpty) {
      try {
        await Provider.of<RazorPayItemsProvider>(context, listen: false)
            .updateItem(itemId, newName, newDescription, amount);
        nameController.clear();
        descriptionController.clear();
        amountController.clear();
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
                  labelText: 'Name',
                  hintText: currentItem.name,
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: descriptionController,
                decoration: InputDecoration(
                  labelText: 'Description',
                  hintText: currentItem.description,
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: amountController,
                decoration: InputDecoration(
                  labelText: 'Amount',
                  hintText: currentItem.amount.toString(),
                ),
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


  void _showDeleteDialog(BuildContext context, String itemId) {
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
                _deleteItem(context, itemId);
                Navigator.pop(context);
              },
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );
  }
  Future<void> _deleteItem(BuildContext context, String itemId) async {
    try {
      await Provider.of<RazorPayItemsProvider>(context, listen: false)
          .deleteItem(itemId);
    } catch (e) {
      print('Error deleting item: $e');
      // Handle error
    }
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
              controller: descriptionController,
              decoration: const InputDecoration(labelText: 'Description'),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: amountController,
              decoration: const InputDecoration(labelText: 'Amount'),
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
              create: (_) => RazorPayItemsProvider().fetchData(),
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
                            subtitle: Column(
                              children: [
                                Text(currentItem.description.toString()),
                                Text('₹-${currentItem.amount.toString()}'),
                                Text(currentItem.currency.toString()),
                              ],
                            ),
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
