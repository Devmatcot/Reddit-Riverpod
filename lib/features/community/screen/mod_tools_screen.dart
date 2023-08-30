import 'package:flutter/material.dart';
import 'package:routemaster/routemaster.dart';

class ModToolsScreen extends StatelessWidget {
  final String name;
  const ModToolsScreen({super.key, required this.name});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Community'),
      ),
      body: Column(
        children: [
          const ListTile(
            title: Text('Add Moderator'),
            leading: Icon(Icons.add_moderator),
          ),
          ListTile(
            title: const Text('Edit Community'),
            onTap: () {
              Routemaster.of(context).push('/edit-community/$name');
            },
            leading: const Icon(Icons.edit),
          )
        ],
      ),
    );
  }
}
