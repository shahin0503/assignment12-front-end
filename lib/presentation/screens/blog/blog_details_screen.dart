import 'package:assignment12_front_end/data/models/blog/blog_model.dart';
import 'package:flutter/material.dart';

class BlogDetailsScreen extends StatefulWidget {
  final BlogModel blogModel;

  const BlogDetailsScreen({super.key, required this.blogModel,});

    static const routeName = 'blog-details';


  @override
  State<BlogDetailsScreen> createState() => _BlogDetailsScreenState();
}

class _BlogDetailsScreenState extends State<BlogDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.blogModel.title}'),
      ),
    );
  }
}