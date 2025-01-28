import 'package:flutter/material.dart';
import 'package:untitled/models/location.dart';

class CreateLocationScreen extends StatefulWidget {
  const CreateLocationScreen({super.key});

  @override
  _CreateLocationScreenState createState() => _CreateLocationScreenState();
}

class _CreateLocationScreenState extends State<CreateLocationScreen> {
  final _formKey = GlobalKey<FormState>();
  String _name = '';
  bool _isActive = false;

  void _createLocation() {
    if (_formKey.currentState?.validate() ?? false) {
      _formKey.currentState?.save();
      final newLocation = Location(
        DateTime.now().toString(),
        name: _name,
        isActive: _isActive,
      );
      Navigator.pop(context, newLocation);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Location'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: const InputDecoration(labelText: 'Location Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a location name';
                  }
                  return null;
                },
                onSaved: (value) {
                  _name = value ?? '';
                },
              ),
              const SizedBox(height: 16),
              SwitchListTile(
                title: const Text('Active'),
                value: _isActive,
                onChanged: (value) {
                  setState(() {
                    _isActive = value;
                  });
                },
              ),
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: _createLocation,
                child: const Text('Create Location'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
