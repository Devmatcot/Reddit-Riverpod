import 'package:flutter/material.dart';
import 'package:routemaster/routemaster.dart';

class ModToolsScreen extends StatelessWidget {
  final String name;
  const ModToolsScreen({super.key, required this.name});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Community'),
      ),
      body: Column(
        children: [
          ListTile(
            title: Text('Add Moderator'),
            leading: Icon(Icons.add_moderator),
          ),
          ListTile(
            title: Text('Edit Group'),
            onTap: () {
              Routemaster.of(context).push('/edit-group/$name');
            },
            leading: Icon(Icons.edit),
          )
        ],
      ),
    );
  }
}
