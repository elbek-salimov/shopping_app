import 'package:flutter/material.dart';
import 'package:shopping_app/data/services/api_service.dart';
import 'package:shopping_app/pages/routes.dart';

import '../../data/repositories/auth_repo/auth_repository.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  final AuthRepository _authRepository =
      AuthRepository(apiService: ApiService());

  @override
  void initState() {
    super.initState();
    _checkLoginStatus();
  }

  void _checkLoginStatus() async {
    bool isLoggedIn = await _authRepository.isLoggedIn();
    String? token;
    await Future.delayed(const Duration(seconds: 3));

    if (isLoggedIn) {
      token = await _authRepository.getToken();
      if (!mounted) return;
      Navigator.pushReplacementNamed(context, RouteNames.home,
          arguments: {'token': token});
    } else {
      if (!mounted) return;
      Navigator.pushReplacementNamed(context, RouteNames.login);
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FlutterLogo(size: 60),
            Text(
              'Shopping App',
              style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.w800,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
