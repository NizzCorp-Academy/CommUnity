import 'package:community_helpboard/features/auth/application/bloc/auth_bloc.dart';

import 'package:community_helpboard/features/auth/domain/repositories/i_auth_repository.dart';
import 'package:community_helpboard/features/auth/infrastructure/auth_repository_impl.dart';
import 'package:community_helpboard/features/communities/application/bloc/community_bloc.dart';
import 'package:community_helpboard/features/communities/domain/repositories/i_community_repository.dart';
import 'package:community_helpboard/features/communities/infrastructure/community_repository_impl.dart';

import 'package:community_helpboard/features/core/app_colors.dart';
import 'package:community_helpboard/features/core/app_theme.dart';
import 'package:community_helpboard/features/core/app_text_styles.dart';
import 'package:community_helpboard/features/profile/application/bloc/profile_bloc.dart';
import 'package:community_helpboard/features/profile/domain/repositories/i_profile_repository.dart';
import 'package:community_helpboard/features/profile/infrastructure/profile_repository_impl.dart';

import 'package:community_helpboard/features/posts/application/bloc/post_bloc.dart';
import 'package:community_helpboard/features/posts/domain/repositories/i_post_repository.dart';
import 'package:community_helpboard/features/posts/infrastructure/repositories/post_repository_impl.dart';
import 'package:community_helpboard/features/splash/presentation/screens/splash_screen.dart';

import 'package:firebase_core/firebase_core.dart';

import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(
    MultiRepositoryProvider(
      providers: [
        //AUTH
        RepositoryProvider<IAuthRepository>(
          create: (_) => AuthRepositoryImpl(),
        ),
        //COMMUNITY
        RepositoryProvider<ICommunityRepository>(
          create: (_) => CommunityRepositoryImpl(),
        ),
        //POST
        RepositoryProvider<IPostRepository>(
          create: (_) => PostRepositoryImpl(),
        ),
        //PROFILE
        RepositoryProvider<IProfileRepository>(
          create: (_) => ProfileRepositoryImpl(),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          //AUTH
          BlocProvider<AuthBloc>(
            create: (context) => AuthBloc(context.read<IAuthRepository>()),
          ),
          //POST
          BlocProvider<PostBloc>(
            create: (context) => PostBloc(context.read<IPostRepository>()),
          ),

          //COMMUNITY
          BlocProvider<CommunityBloc>(
            create: (context) =>
                CommunityBloc(context.read<ICommunityRepository>()),
          ),
          //PROFILE
          BlocProvider<ProfileBloc>(
            create: (context) =>
                ProfileBloc(context.read<IProfileRepository>()),
          ),
        ],
        child: MyApp(),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SplashScreen(),

      theme: ThemeData(
        scaffoldBackgroundColor: AppColors.background,
        inputDecorationTheme: AppTheme.theme,
        textTheme: TextTheme(
          headlineSmall: AppTextStyles.headlineSmall,
          headlineLarge: AppTextStyles.headlineLarge,
          bodySmall: AppTextStyles.bodySmall,
          bodyMedium: AppTextStyles.bodyMedium,
          titleSmall: AppTextStyles.titleSmall,
        ),
      ),

      debugShowCheckedModeBanner: false,
    );
  }
}
