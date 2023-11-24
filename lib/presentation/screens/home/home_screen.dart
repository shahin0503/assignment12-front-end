import 'package:assignment12_front_end/core/ui.dart';
import 'package:assignment12_front_end/logic/cubits/user_cubit/user_cubit.dart';
import 'package:assignment12_front_end/logic/cubits/user_cubit/user_state.dart';
import 'package:assignment12_front_end/presentation/screens/contact/contact_form_screen.dart';
import 'package:assignment12_front_end/presentation/screens/home/blogs_screen.dart';
import 'package:assignment12_front_end/presentation/screens/home/user_feed_screen.dart';
import 'package:assignment12_front_end/presentation/screens/home/profile_screen.dart';
import 'package:assignment12_front_end/presentation/screens/splash/splash_screen.dart';
import 'package:assignment12_front_end/presentation/widgets/gap_widget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  static const String routeName = 'home';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentIndex = 0;
  List<Widget> screens = const [
    UserFeedScreen(),
    BlogsScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocListener<UserCubit, UserState>(
      listener: (context, state) {
        if (state is UserLoggedOutState) {
          Navigator.pushReplacementNamed(context, SplashScreen.routeName);
        }
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 248, 233, 251),
          title: Row(
            children: [
              ClipOval(
                child: CachedNetworkImage(
                  width: MediaQuery.of(context).size.width / 12,
                  height: MediaQuery.of(context).size.width / 12,
                  fit: BoxFit.cover,
                  imageUrl:
                      'https://image.freepik.com/vector-gratis/concepto-blogs-personajes_23-2148653962.jpg',
                ),
              ),
              const GapWidget(
                size: -10,
              ),
              Text(
                'Blogfolio',
                style: TextStyles.heading3.copyWith(
                  color: AppColors.accent,
                ),
              ),
            ],
          ),
          actions: [
            IconButton(
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  ContactFormScreen.routeName,
                );
              },
              iconSize: MediaQuery.of(context).size.width / 12,
              color: AppColors.accent,
              icon: const Icon(
                Icons.contact_page,
              ),
            ),
          ],
        ),
        body: screens[currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: currentIndex,
          onTap: (index) {
            setState(() {
              currentIndex = index;
            });
          },
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Portfolios',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.category),
              label: 'Blogs',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Profile',
            ),
          ],
          backgroundColor: const Color.fromARGB(255, 248, 233, 251),
        ),
      ),
    );
  }
}
