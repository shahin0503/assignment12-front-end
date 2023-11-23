import 'package:assignment12_front_end/core/ui.dart';
import 'package:assignment12_front_end/data/models/blog/blog_model.dart';
import 'package:assignment12_front_end/logic/cubits/blog_cubit/blog_cubit.dart';
import 'package:assignment12_front_end/presentation/widgets/gap_widget.dart';
import 'package:assignment12_front_end/presentation/widgets/primary_button.dart';
import 'package:assignment12_front_end/presentation/widgets/primary_textfield.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CreateEditBlogScreen extends StatefulWidget {
  final BlogModel? blog;
  const CreateEditBlogScreen({
    super.key,
    this.blog,
  });

  static const routeName = 'create-edit-blog';

  @override
  State<CreateEditBlogScreen> createState() => _CreateEditBlogScreenState();
}

class _CreateEditBlogScreenState extends State<CreateEditBlogScreen> {
  late TextEditingController _titleController;
  late TextEditingController _descriptionController;
  String _selectedCategory = 'Comedy';

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.blog?.title ?? '');
    _descriptionController =
        TextEditingController(text: widget.blog?.description ?? '');
    print(widget.blog);
    if (widget.blog != null) {
      _selectedCategory = widget.blog!.category!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.blog == null ? 'Create Blog' : 'Edit Blog'),
      ),
      body: SafeArea(
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8.0),
                    child: CachedNetworkImage(
                      width: MediaQuery.of(context).size.width / 2,
                      height: MediaQuery.of(context).size.width / 2,
                      fit: BoxFit.cover,
                      imageUrl: '${widget.blog?.image}',
                    ),
                  ),
                  const GapWidget(),
                  PrimaryTextField(
                    labelText: 'Title',
                    controller: _titleController,
                  ),
                  const GapWidget(),
                  PrimaryTextField(
                    labelText: 'Description',
                    controller: _descriptionController,
                  ),
                  const GapWidget(),
                  Row(
                    children: [
                      Text(
                        'Select category: ',
                        style: TextStyles.body1,
                      ),
                      const GapWidget(),
                      Expanded(
                        child: DropdownButton<String>(
                          value: _selectedCategory,
                          onChanged: (String? newValue) {
                            setState(() {
                              _selectedCategory = newValue!;
                            });
                          },
                          items: <String>[
                            'Comedy',
                            'Science',
                            'Physics',
                            'Artificial technology'
                          ].map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                      ),
                    ],
                  ),
                  const GapWidget(
                    size: 10,
                  ),
                  PrimaryButton(
                    onPressed: () {
                      if (widget.blog == null) {
                        final newBlog = BlogModel(
                          title: _titleController.text,
                          description: _descriptionController.text,
                          category: _selectedCategory,
                        );
                        context.read<BlogCubit>().addBlog(newBlog);
                      }
                    },
                    text: 'Save',
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
