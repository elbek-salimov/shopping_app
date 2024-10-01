import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_app/data/repositories/auth_repo/auth_repository.dart';
import 'package:shopping_app/data/services/api_service.dart';
import 'package:shopping_app/pages/home/dialogs/custom_dialog.dart';
import 'package:shopping_app/pages/routes.dart';

import '../../data/blocs/user/user_bloc.dart';
import '../../data/blocs/user/user_event.dart';
import '../../data/blocs/user/user_state.dart';
import '../../data/repositories/user_repo/user_repository.dart';

class HomePage extends StatefulWidget {
  final String token;

  const HomePage({super.key, required this.token});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final AuthRepository _authRepository =
      AuthRepository(apiService: ApiService());

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UserBloc(
        userRepository: UserRepository(apiService: ApiService()),
      )..add(LoadUserEvent(widget.token)),
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('dashboard'.tr()),
          backgroundColor: Colors.indigo,
          leading: PopupMenuButton(
            icon: const Icon(Icons.language),
            itemBuilder: (context) => [
              PopupMenuItem(
                onTap: () {
                  context.setLocale(const Locale('en', 'US'));
                  setState(() {});
                },
                child: const Text('English'),
              ),
              PopupMenuItem(
                onTap: () {
                  context.setLocale(const Locale('ru', 'RU'));
                  setState(() {});
                },
                child: const Text('Русский'),
              ),
              PopupMenuItem(
                onTap: () {
                  context.setLocale(const Locale('uz', 'UZ'));
                  setState(() {});
                },
                child: const Text("O'zbek"),
              ),
            ],
          ),
          actions: [
            IconButton(
              onPressed: () async {
                showDialog(
                    context: context,
                    builder: (context) {
                      return CustomDialog(
                        title: 'logout'.tr(),
                        onConfirm: () async {
                          await _authRepository.logout();
                          if (!context.mounted) return;
                          Navigator.pushReplacementNamed(
                              context, RouteNames.login);
                        },
                      );
                    });
              },
              icon: const Icon(Icons.logout),
            )
          ],
        ),
        body: BlocBuilder<UserBloc, UserState>(
          builder: (context, state) {
            if (state is UserLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is UserLoaded) {
              final userInfo = state.userInfo;
              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 20),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(20),
                      margin: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.white30,
                        borderRadius: BorderRadius.circular(18),
                      ),
                      child: Column(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(200),
                            child: Image.network(
                                width: 100,
                                height: 100,
                                "https://betaapi.theflyhigh.uz/api/Files/${userInfo.profilePicture}"),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            "${userInfo.firstName} ${userInfo.lastName}",
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                              fontSize: 20,
                            ),
                          ),
                          const SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              const Icon(Icons.phone, color: Colors.white),
                              Text(
                                userInfo.phone,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14,
                                ),
                              ),
                              const Icon(Icons.work, color: Colors.white),
                              Text(
                                userInfo.workPosition.toLowerCase().tr(),
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    _buildUserInfoTile('user_id'.tr(), userInfo.userId),
                    _buildUserInfoTile('active'.tr(), userInfo.active),
                    _buildUserInfoTile(
                        'total_invites'.tr(), userInfo.totalInvites),
                    _buildUserInfoTile(
                        'masters_count'.tr(), userInfo.mastersCount),
                    _buildUserInfoTile(
                        'managers_count'.tr(), userInfo.managersCount),
                    _buildUserInfoTile(
                        'liders_count'.tr(), userInfo.liedersCount),
                    _buildUserInfoTile(
                        'captains_count'.tr(), userInfo.captainsCount),
                    _buildUserInfoTile(
                        'barons_count'.tr(), userInfo.baronsCount),
                    _buildUserInfoTile(
                        'governors_count'.tr(), userInfo.governorsCount),
                    _buildUserInfoTile(
                        'supremes_count'.tr(), userInfo.supremesCount),
                    _buildUserInfoTile('boss_count'.tr(), userInfo.bossCount),
                  ],
                ),
              );
            } else if (state is UserError) {
              return Center(child: Text('Error: ${state.message}'));
            } else {
              return const Center(child: Text('No user info available'));
            }
          },
        ),
      ),
    );
  }

  Widget _buildUserInfoTile(String label, dynamic value) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white30,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Text(
        "$label   $value",
        style: const TextStyle(color: Colors.white, fontSize: 16),
      ),
    );
  }
}
