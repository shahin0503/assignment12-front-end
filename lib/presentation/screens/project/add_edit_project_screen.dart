import 'package:assignment12_front_end/presentation/widgets/primary_textfield.dart';
import 'package:flutter/material.dart';

class CreateEditProjectScreen extends StatefulWidget {
  const CreateEditProjectScreen({super.key});

  static const routeName = 'create-edit-project';

  @override
  State<CreateEditProjectScreen> createState() =>
      _CreateEditProjectScreenState();
}

class _CreateEditProjectScreenState extends State<CreateEditProjectScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _gitUrlController = TextEditingController();
  final TextEditingController _demoUrlController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          PrimaryTextField(
            labelText: 'Title',
            controller: _titleController,
          ),
          PrimaryTextField(
            labelText: 'Description',
            controller: _descriptionController,
          ),
          
          PrimaryTextField(
            labelText: 'GitURL',
            controller: _gitUrlController,
          ),
          PrimaryTextField(
            labelText: 'DemoURL',
            controller: _demoUrlController,
          )
        ],
      ),
    );
  }
}
