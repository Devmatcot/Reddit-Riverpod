import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class EditGroupScreen extends ConsumerStatefulWidget {
  final String name;
  const EditGroupScreen({super.key, required this.name});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _EditGroupScreenState();
}

class _EditGroupScreenState extends ConsumerState<EditGroupScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Group'),
        actions: [TextButton(onPressed: () {}, child: const Text('Save'))],
      ),
      body: Column(
        children: [
          
        ],
      ),
    );
  }
}
