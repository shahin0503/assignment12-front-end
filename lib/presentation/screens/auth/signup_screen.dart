import 'package:assignment12_front_end/core/ui.dart';
import 'package:assignment12_front_end/presentation/screens/auth/providers/signup_provider.dart';
import 'package:assignment12_front_end/presentation/screens/splash/splash_screen.dart';
import 'package:assignment12_front_end/presentation/widgets/gap_widget.dart';
import 'package:assignment12_front_end/presentation/widgets/link_button.dart';
import 'package:assignment12_front_end/presentation/widgets/primary_button.dart';
import 'package:assignment12_front_end/presentation/widgets/primary_textfield.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  static const String routeName = 'signup';

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool _isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<SignupProvider>(context);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        title: Text(
          'Blogfolio',
          style: TextStyles.heading2.copyWith(
            color: AppColors.accent,
          ),
        ),
      ),
      body: SafeArea(
          child: Form(
        key: provider.formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Center(
              child: ClipOval(
                child: CachedNetworkImage(
                  width: MediaQuery.of(context).size.width / 2,
                  height: MediaQuery.of(context).size.width / 2,
                  fit: BoxFit.cover,
                  imageUrl:
                      'https://image.freepik.com/vector-gratis/concepto-blogs-personajes_23-2148653962.jpg',
                ),
              ),
            ),
            Center(
              child: Text(
                'Create Account',
                style: TextStyles.heading2.copyWith(
                  color: AppColors.accent,
                ),
              ),
            ),
            const GapWidget(
              size: -10,
            ),
            (provider.error != '')
                ? Text(
                    provider.error,
                    style: const TextStyle(color: Colors.red),
                  )
                : const SizedBox(),
            const GapWidget(
              size: 5,
            ),
            PrimaryTextField(
              controller: provider.fullNameController,
              labelText: 'Full Name',
              prefixIcon: const Icon(
                Icons.person,
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Full name is required!';
                }
                return null;
              },
            ),
            const GapWidget(),
            PrimaryTextField(
              controller: provider.emailController,
              labelText: 'Email Address',
              prefixIcon: const Icon(Icons.email),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Email Address is required!';
                } else if (!EmailValidator.validate(value.trim())) {
                  return 'Invalid email address';
                }
                return null;
              },
            ),
            const GapWidget(),
            PrimaryTextField(
              controller: provider.passwordController,
              labelText: 'Password',
              obscureText: !_isPasswordVisible,
              prefixIcon: const Icon(Icons.key),
              suffixIcon: IconButton(
                onPressed: () {
                  setState(() {
                    _isPasswordVisible = !_isPasswordVisible;
                  });
                },
                icon: Icon(
                  _isPasswordVisible ? Icons.visibility_off : Icons.visibility,
                ),
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Password is required!';
                }
                return null;
              },
            ),
            const GapWidget(),
            PrimaryButton(
              onPressed: provider.createAccount,
              text: (provider.isLoading) ? '...' : 'Create Account',
            ),
            const GapWidget(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Already have an account?",
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
                const GapWidget(),
                LinkButton(
                  onPressed: () {
                    Navigator.pushNamed(
                      context,
                      SplashScreen.routeName,
                    );
                  },
                  text: 'Log In',
                ),
              ],
            )
          ],
        ),
      )),
    );
  }
}
