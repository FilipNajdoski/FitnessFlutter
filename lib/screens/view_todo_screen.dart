import 'package:flutter/material.dart';
import 'package:untitled/shared/locationsProvider.dart';
import '../models/todo.dart';
import '../models/location.dart';
import 'package:provider/provider.dart';

class ViewTodoScreen extends StatelessWidget {
  final Todo todo;

  const ViewTodoScreen({super.key, required this.todo});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(todo.title)),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Description: ${todo.description}'),
            const SizedBox(height: 10),
            Text(
                'Due Date: ${todo.dueDate?.toLocal().toString().split(' ')[0] ?? 'None'}'),
            const SizedBox(height: 10),
            Text('Priority: ${todo.priority}'),
            const SizedBox(height: 10),
            Text('Completed: ${todo.isCompleted ? 'Yes' : 'No'}'),
            const SizedBox(height: 10),
            Text(
              'Location: ${Provider.of<LocationsProvider>(context, listen: false).locations.firstWhere(
                    (x) => x.id == todo.locationId,
                    orElse: () => Location('', name: 'No Location'),
                  ).name}',
            ),
          ],
        ),
      ),
    );
  }
}
