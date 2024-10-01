import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_app/pages/routes.dart';

import '../../data/blocs/auth/auth_bloc.dart';
import '../../data/blocs/auth/auth_event.dart';
import '../../data/blocs/auth/auth_state.dart';
import '../../data/repositories/auth_repo/auth_repository.dart';
import '../../data/services/api_service.dart';

class LoginPage extends StatelessWidget {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocProvider(
          create: (context) => LoginBloc(
            authRepository: AuthRepository(
              apiService: ApiService(),
            ),
          ),
          child: BlocListener<LoginBloc, LoginState>(
            listener: (context, state) {
              if (state is LoginSuccess) {
                Navigator.of(context).pushReplacementNamed(RouteNames.home,
                    arguments: {'token':state.token});
              } else if (state is LoginFailure) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(state.error)),
                );
              }
            },
            child: BlocBuilder<LoginBloc, LoginState>(
              builder: (context, state) {
                return Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      const SizedBox(height: 100),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const FlutterLogo(
                            size: 50,
                          ),
                          const SizedBox(width: 10),
                          Text(
                            'login'.tr(),
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                              fontSize: 40,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 40),
                      Text(
                        'welcome_back'.tr(),
                        style: const TextStyle(
                            color: Colors.white60,
                            fontSize: 20,
                            fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(height: 30),
                      const Spacer(),
                      TextField(
                        style: const TextStyle(color: Colors.white),
                        controller: _usernameController,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.indigo.shade800,
                          labelText: 'username'.tr(),
                          labelStyle: const TextStyle(color: Colors.white38),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: const BorderSide(color: Colors.white),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      TextField(
                        style: const TextStyle(color: Colors.white),
                        controller: _passwordController,
                        decoration: InputDecoration(
                          labelText: 'password'.tr(),
                          filled: true,
                          fillColor: Colors.indigo.shade800,
                          labelStyle: const TextStyle(color: Colors.white38),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: const BorderSide(color: Colors.white),
                          ),
                        ),
                        obscureText: true,
                      ),
                      const SizedBox(height: 20),
                      state is LoginLoading
                          ? const CircularProgressIndicator()
                          : ElevatedButton(
                              onPressed: () {
                                final username = _usernameController.text;
                                final password = _passwordController.text;

                                if (username.isNotEmpty &&
                                    password.isNotEmpty) {
                                  context.read<LoginBloc>().add(
                                        LoginButtonPressed(
                                            username: username,
                                            password: password),
                                      );
                                }
                              },
                              child: Text('login_btn'.tr()),
                            ),
                      const Spacer(flex: 4),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
