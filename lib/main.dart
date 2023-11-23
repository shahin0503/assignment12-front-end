import 'dart:developer';

import 'package:assignment12_front_end/core/routes.dart';
import 'package:assignment12_front_end/core/ui.dart';
import 'package:assignment12_front_end/logic/cubits/blog_cubit/blog_cubit.dart';
import 'package:assignment12_front_end/logic/cubits/comment_cubit/comment_cubit.dart';
import 'package:assignment12_front_end/logic/cubits/project_cubit/project_cubit.dart';
import 'package:assignment12_front_end/logic/cubits/user_cubit/user_cubit.dart';
import 'package:assignment12_front_end/logic/cubits/users_cubit/users_cubit.dart';
import 'package:assignment12_front_end/presentation/screens/splash/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  Bloc.observer = MyBlocObserver();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => UserCubit(),
        ),
        BlocProvider(
          create: (context) => UsersCubit(),
        ),
        BlocProvider(
          create: (context) => BlogCubit(),
        ),
        BlocProvider(
          create: (context) => ProjectCubit(),
        ),
        BlocProvider(
          create: (context) => CommentCubit(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: Themes.defaultTheme,
        debugShowCheckedModeBanner: false,
        onGenerateRoute: Routes.onGenerateRoute,
        initialRoute: SplashScreen.routeName,
      ),
    );
  }
}

class MyBlocObserver extends BlocObserver {
  @override
  void onCreate(BlocBase bloc) {
    log('Created: $bloc');
    super.onCreate(bloc);
  }

  @override
  void onChange(BlocBase bloc, Change change) {
    log('Changed in $bloc: $change');
    super.onChange(bloc, change);
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    log('Changed in $bloc: $transition');
    super.onTransition(bloc, transition);
  }

  @override
  void onClose(BlocBase bloc) {
    log('Closed: $bloc');
    super.onClose(bloc);
  }
}
