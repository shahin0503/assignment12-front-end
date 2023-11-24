import 'package:assignment12_front_end/data/models/user/user_model.dart';
import 'package:assignment12_front_end/data/repositories/contact_form_repository.dart';
import 'package:assignment12_front_end/logic/cubits/user_cubit/user_cubit.dart';
import 'package:assignment12_front_end/logic/cubits/user_cubit/user_state.dart';
import 'package:assignment12_front_end/presentation/widgets/gap_widget.dart';
import 'package:assignment12_front_end/presentation/widgets/primary_button.dart';
import 'package:assignment12_front_end/presentation/widgets/primary_textfield.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ContactFormScreen extends StatefulWidget {
  const ContactFormScreen({super.key});

  static const String routeName = 'contact-form';

  @override
  State<ContactFormScreen> createState() => _ContactFormScreenState();
}

class _ContactFormScreenState extends State<ContactFormScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final ContactFormRepository _contactFormRepository = ContactFormRepository();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contact form'),
      ),
      body: BlocBuilder<UserCubit, UserState>(
        builder: (context, state) {
          if (state is UserLoadingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is UserErrorState) {
            return Center(
              child: Text(state.message),
            );
          } else if (state is UserLoggedInState) {
            return contactForm(state.userModel);
          }
          return const Center(
            child: Text('An error occured!!'),
          );
        },
      ),
    );
  }

  Widget contactForm(UserModel userModel) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Column(
              children: [
                ClipOval(
                  child: CachedNetworkImage(
                    width: MediaQuery.of(context).size.width / 2,
                    height: MediaQuery.of(context).size.width / 2,
                    fit: BoxFit.cover,
                    imageUrl:
                        'https://www.spoton.com/blog/content/images/2023/07/Benefits_of_email_marketing.jpg',
                  ),
                ),
                const GapWidget(
                  size: 30,
                ),
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
                PrimaryButton(
                  onPressed: () async {
                    final title = _titleController.text;
                    final content = _descriptionController.text;
                    final email = userModel.email;
                    await _contactFormRepository.sendMail(
                      title,
                      content,
                      email!,
                    );
                    Navigator.pop(context);
                  },
                  text: 'Send',
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
