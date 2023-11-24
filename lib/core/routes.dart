import 'package:assignment12_front_end/data/models/blog/blog_model.dart';
import 'package:assignment12_front_end/data/models/project/project_model.dart';
import 'package:assignment12_front_end/data/models/user/user_model.dart';
import 'package:assignment12_front_end/presentation/screens/auth/login_screen.dart';
import 'package:assignment12_front_end/presentation/screens/auth/providers/login_provider.dart';
import 'package:assignment12_front_end/presentation/screens/auth/providers/signup_provider.dart';
import 'package:assignment12_front_end/presentation/screens/auth/signup_screen.dart';
import 'package:assignment12_front_end/presentation/screens/blog/blog_details_screen.dart';
import 'package:assignment12_front_end/presentation/screens/blog/create_edit_blog_screen.dart';
import 'package:assignment12_front_end/presentation/screens/contact/contact_form_screen.dart';
import 'package:assignment12_front_end/presentation/screens/home/home_screen.dart';
import 'package:assignment12_front_end/presentation/screens/project/create_edit_project_screen.dart';
import 'package:assignment12_front_end/presentation/screens/project/project_list_screen.dart';
import 'package:assignment12_front_end/presentation/screens/splash/splash_screen.dart';
import 'package:assignment12_front_end/presentation/screens/user/edit_profile_screen.dart';
import 'package:assignment12_front_end/presentation/screens/user/user_details_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class Routes {
  static Route? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case LoginScreen.routeName:
        return CupertinoPageRoute(
          builder: (context) => ChangeNotifierProvider(
              create: (BuildContext context) => LoginProvider(context),
              child: const LoginScreen()),
        );
      case SignUpScreen.routeName:
        return CupertinoPageRoute(
          builder: (context) => ChangeNotifierProvider(
              create: (BuildContext context) => SignupProvider(context),
              child: const SignUpScreen()),
        );
      case HomeScreen.routeName:
        return CupertinoPageRoute(
          builder: (context) => const HomeScreen(),
        );
      case SplashScreen.routeName:
        return CupertinoPageRoute(
          builder: (context) => const SplashScreen(),
        );
      case UserDetailsScreen.routeName:
        return CupertinoPageRoute(
            builder: (context) => UserDetailsScreen(
                  userModel: settings.arguments as UserModel,
                ));
      case EditProfileScreen.routeName:
        return CupertinoPageRoute(
          builder: (context) => const EditProfileScreen(),
        );
      case CreateEditBlogScreen.routeName:
        return CupertinoPageRoute(
          builder: (context) => CreateEditBlogScreen(
            blogPreferences: settings.arguments as BlogPreferences,
          ),
        );
      case BlogDetailsScreen.routeName:
        return CupertinoPageRoute(
          builder: (context) => BlogDetailsScreen(
            blogModel: settings.arguments as BlogModel,
          ),
        );

      case ProjectListScreen.routeName:
        return CupertinoPageRoute(
          builder: (context) => ProjectListScreen(
            userId: settings.arguments as String,
          ),
        );
      case CreateEditProjectScreen.routeName:
        return CupertinoPageRoute(
          builder: (context) => CreateEditProjectScreen(
            projectPreferences: settings.arguments as ProjectPreferences,
          ),
        );
      case ContactFormScreen.routeName:
        return CupertinoPageRoute(
          builder: (context) => const ContactFormScreen(),
        );

      default:
        return null;
    }
  }
}
