import 'package:flutter/material.dart';
import '../models/todo.dart';
import '../shared/locationsProvider.dart';
import 'package:provider/provider.dart';

class CreateTodoScreen extends StatefulWidget {
  const CreateTodoScreen({super.key});

  @override
  State<CreateTodoScreen> createState() => _CreateTodoScreenState();
}

class _CreateTodoScreenState extends State<CreateTodoScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  DateTime? _selectedDueDate;
  String _selectedPriority = 'Low';
  String? _selectedLocationId;

  Future<void> _pickDueDate() async {
    final selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );
    if (selectedDate != null) {
      setState(() {
        _selectedDueDate = selectedDate;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Create Todo')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(labelText: 'Title'),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _descriptionController,
              decoration: const InputDecoration(labelText: 'Description'),
            ),
            const SizedBox(height: 10),
            ListTile(
              title: const Text('Due Date'),
              subtitle: Text(_selectedDueDate == null
                  ? 'Select a date'
                  : _selectedDueDate!.toLocal().toString().split(' ')[0]),
              trailing: const Icon(Icons.calendar_today),
              onTap: _pickDueDate,
            ),
            const SizedBox(height: 10),
            DropdownButtonFormField<String>(
              value: _selectedPriority,
              items: ['Low', 'Medium', 'High']
                  .map((priority) => DropdownMenuItem(
                        value: priority,
                        child: Text(priority),
                      ))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  _selectedPriority = value!;
                });
              },
              decoration: const InputDecoration(labelText: 'Priority'),
            ),
            const SizedBox(height: 10),
            Consumer<LocationsProvider>(
              builder: (context, locationsProvider, child) {
                final locations = locationsProvider.locations;
                if (locations == null) {
                  return const CircularProgressIndicator();
                }
                return DropdownButtonFormField<String>(
                  value: _selectedLocationId,
                  items: locations
                      .map((location) => DropdownMenuItem(
                            value: location.id,
                            child: Text(location.name),
                          ))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedLocationId = value;
                    });
                  },
                  decoration: const InputDecoration(labelText: 'Location'),
                );
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (_titleController.text.isNotEmpty) {
                  Navigator.pop(
                    context,
                    Todo(
                      _titleController.text,
                      _descriptionController.text,
                      dueDate: _selectedDueDate,
                      priority: _selectedPriority,
                      locationId: _selectedLocationId,
                    ),
                  );
                }
              },
              child: const Text('Create'),
            ),
          ],
        ),
      ),
    );
  }
}
