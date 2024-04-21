import 'package:flutter/material.dart';
import 'package:mvvm_example/models/person.dart';
import 'package:mvvm_example/view_model/person_view_model.dart';
import 'package:provider/provider.dart';


class PersonScreen extends StatelessWidget {
  const PersonScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Person List')),
      body: Consumer<PersonViewModel>(
        builder: (context, viewModel, child) {
          return ListView.builder(
            itemCount: viewModel.persons.length,
            itemBuilder: (context, index) {
              final person = viewModel.persons[index];
              return ListTile(
                title: Text(person.name),
                subtitle: Text('Age: ${person.age}'),
                trailing: IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () => viewModel.removePerson(person),
                        ),
                onTap: () => _showEditDialog(context, viewModel, person),
                );
              },
            );
          },
        ),
      floatingActionButton: FloatingActionButton(
      child: Icon(Icons.add),
      onPressed: () => _showAddDialog(context),
      ),
    );
  }
  void _showAddDialog(BuildContext context) {
    final nameController = TextEditingController();
    final ageController = TextEditingController();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Add Person'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(labelText: 'Name'),
            ),
            TextField(
              controller: ageController,
              decoration: InputDecoration(labelText: 'Age'),
              keyboardType: TextInputType.number,
            ),
          ],
        ),
        actions: [
          TextButton(
            child: Text('Cancel'),
            onPressed: () => Navigator.of(context).pop(),
          ),
          TextButton(
            child: Text('Add'),
            onPressed: () {
              final name = nameController.text;
              final age = int.parse(ageController.text);
              final person = Person(name: name, age: age);
              final viewModel =
                  Provider.of<PersonViewModel>(context, listen: false);
              viewModel.addPerson(person);
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }
  void _showEditDialog(
    BuildContext context, PersonViewModel viewModel, Person person) {
      final nameController = TextEditingController(text: person.name);
      final ageController = TextEditingController(text: person.age.toString());
      showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Edit Person'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(labelText: 'Name'),
            ),
            TextField(
              controller: ageController,
              decoration: InputDecoration(labelText: 'Age'),
              keyboardType: TextInputType.number,
            ),
          ],
        ),
        actions: [
          TextButton(
            child: Text('Cancel'),
            onPressed: () => Navigator.of(context).pop(),
          ),
          TextButton(
            child: Text('Save'),
            onPressed: () {
              final name = nameController.text;
              final age = int.parse(ageController.text);
              final oldPerson = person;
              final newPerson = Person(name: name, age: age);
              viewModel.updatePerson(oldPerson, newPerson);
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }
}