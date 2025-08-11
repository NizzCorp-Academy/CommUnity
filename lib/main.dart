import 'package:community_helpboard/features/communities/application/bloc/community_bloc.dart';
import 'package:community_helpboard/features/communities/domain/repositories/i_community_repository.dart';
import 'package:community_helpboard/features/communities/infrastructure/community_repository_impl.dart';
import 'package:community_helpboard/features/communities/presentation/pages/home_screen.dart';
import 'package:community_helpboard/features/core/app_colors.dart';
import 'package:community_helpboard/features/posts/application/bloc/post_bloc.dart';
import 'package:community_helpboard/features/posts/domain/repositories/i_post_repository.dart';
import 'package:community_helpboard/features/posts/infrastructure/repositories/post_repository_impl.dart';
import 'package:community_helpboard/features/posts/presentation/pages/post_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    MultiRepositoryProvider(
      providers: [
        RepositoryProvider<ICommunityRepository>(
          create: (_) => CommunityRepositoryImpl(),
        ),
        RepositoryProvider<IPostRepository>(
          create: (_) => PostRepositoryImpl(),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<CommunityBloc>(
            create: (context) =>
                CommunityBloc(context.read<ICommunityRepository>()),
          ),
          BlocProvider<PostBloc>(
            create: (context) => PostBloc(context.read<IPostRepository>()),
          ),
        ],
        child: const MyApp(),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeScreen(),
      theme: ThemeData(
        scaffoldBackgroundColor: AppColors.background,
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Color.fromRGBO(255, 255, 255, 1),
          hintStyle: TextStyle(
            color: Color.fromRGBO(110, 110, 110, 1),
            fontSize: 16,
            fontWeight: FontWeight.w400,
            fontFamily: 'Inter-regular',
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(12)),
            borderSide: BorderSide(
              color: Color.fromRGBO(0, 0, 0, 0.1),
              width: 1,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(12)),
            borderSide: BorderSide(
              color: Color.fromRGBO(0, 0, 0, 0.1),
              width: 1,
            ),
          ),
        ),
        textTheme: TextTheme(
          headlineSmall: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.w600,
            fontFamily: 'Inter-SemiBold',
            color: Color.fromRGBO(46, 46, 46, 1),
          ),
          bodySmall: TextStyle(
            color: Color.fromRGBO(110, 110, 110, 1),
            fontSize: 12.0,
            fontWeight: FontWeight.w400,
            fontFamily: 'Inter-Regular',
            overflow: TextOverflow.ellipsis,
          ),
          bodyMedium: TextStyle(
            color: Color.fromRGBO(46, 46, 46, 1),
            fontWeight: FontWeight.w500,
            fontSize: 16,
            fontFamily: 'Inter-Regular',
          ),
        ),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
