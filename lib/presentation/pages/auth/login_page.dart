// pages/home_screen.dart
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recon/core/services/biometrice_auth.dart';
import 'package:recon/core/utils/utils.dart';
import 'package:recon/presentation/bloc/login/login_bloc.dart';
import 'package:recon/presentation/bloc/login/login_state.dart';
import 'package:recon/presentation/routes/app_router.gr.dart';

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
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final _corpIdController = TextEditingController();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  // update biometrics
  bool _isBiometricSupported = false;

  @override
  void initState() {
    super.initState();
    _checkBiometrics();
  }

  // pengecekan biometrics
  void _checkBiometrics() async {
    final isSupported = await BiometriceAuth.isDeviceSupported();
    if (!mounted) return;

    debugPrint('Biometrik Supported: $isSupported');
    setState(() {
      _isBiometricSupported = isSupported;
    });
  }

  void _triggerBiometricLogin() async {
    if (_isBiometricSupported) {
      final isAuthenticated = await BiometriceAuth.authenticate(
        title: 'Login dengan Sidik Jari',
        description: 'Silakan scan sidik jari untuk melanjutkan.',
      );
      if (isAuthenticated) {
        context.read<LoginBloc>().add(LoginFormSubmitted());
        context.router.replace(HomeRoute());
      }
    }
  }

  void _onLogin(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      final corpId = _corpIdController.text;
      final username = _usernameController.text;
      final password = Utils.encryptWithKey(_passwordController.text);
      context.read<LoginBloc>().add(
        LoginSubmitted(
          corporateId: corpId,
          username: username,
          password: password,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextField(
                controller: _corpIdController,
                decoration: InputDecoration(labelText: 'Corp ID'),
              ),
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
                  final isLoading = state.isLogin;
                  final isSuccess = state.username;
                  final isFailure = state.isLoginFailure;

                  if (state.isLogin) {
                    context.router.replace(
                      HomeRoute(),
                    );
                  }

                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (isFailure.isNotEmpty)
                        Text(
                          state.isLoginFailure,
                          style: const TextStyle(color: Colors.red),
                        ),
                      if (isSuccess.isNotEmpty)
                        const Text(
                          'Login Berhasil!',
                          style: TextStyle(color: Colors.green),
                        ),
                      ElevatedButton(
                        onPressed:
                            isLoading
                                ? null // disable saat loading
                                : () => _onLogin(context),
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
              const SizedBox(height: 12),
              if (_isBiometricSupported)
                ElevatedButton.icon(
                  icon: const Icon(Icons.fingerprint),
                  label: const Text('Login dengan Biometrik'),
                  onPressed: () {
                    _triggerBiometricLogin();
                  },
                ),
            ],
          ),
        ),
      ),
    );
  }
}
