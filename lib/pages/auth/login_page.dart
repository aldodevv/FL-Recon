// pages/home_screen.dart
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recon/bloc/login_bloc/login_bloc.dart';
import 'package:recon/bloc/login_bloc/login_state.dart';
import 'package:recon/router/app_router.gr.dart';

@RoutePage()
class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (_) => LoginBloc(), child: const LoginForm());
  }
}

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _corpIdController = TextEditingController();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _usernameController,
              decoration: InputDecoration(labelText: 'Username'),
            ),
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: InputDecoration(labelText: 'Password'),
            ),
            const SizedBox(height: 16),
            BlocBuilder<LoginBloc, LoginState>(
              builder: (context, state) {
                final isLoading = state is LoginLoading;
                final isSuccess = state is LoginSuccess;
                final isFailure = state is LoginFailure;

                if (state is LoginSuccess) {
                  context.router.replace(
                    HomeRoute(
                      username: state.username,
                    ), // ← kirim data ke halaman
                  );
                }

                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (isFailure)
                      Text(
                        (state).message,
                        style: const TextStyle(color: Colors.red),
                      ),
                    if (isSuccess)
                      const Text(
                        'Login Berhasil!',
                        style: TextStyle(color: Colors.green),
                      ),
                    ElevatedButton(
                      onPressed:
                          isLoading
                              ? null // disable saat loading
                              : () {
                                final corpid = _corpIdController.text;
                                final username = _usernameController.text;
                                final password = _passwordController.text;
                                context.read<LoginBloc>().add(
                                  LoginSubmitted(corpid, username, password),
                                );
                              },
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Text('Login'),
                          if (isLoading) ...[
                            const SizedBox(width: 8),
                            const SizedBox(
                              height: 16,
                              width: 16,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                valueColor: AlwaysStoppedAnimation<Color>(
                                  Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
