import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../data/blocs/auth/auth_bloc.dart';
import '../data/repositories/auth_repo/auth_repository.dart';
import '../data/services/api_service.dart';
import '../pages/routes.dart';

class App extends StatelessWidget {
  App({super.key});

  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (_) => AuthRepository(
            apiService: ApiService(),
          ),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) =>
                LoginBloc(authRepository: context.read<AuthRepository>()),
          ),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            useMaterial3: false,
            scaffoldBackgroundColor: const Color(0xFF0A1733),
          ),
          navigatorKey: navigatorKey,
          initialRoute: RouteNames.splash,
          onGenerateRoute: AppRoutes.generateRoute,
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          locale: context.locale,
        ),
      ),
    );
  }
}
