import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recon/core/constants/colors_const.dart';
import 'package:recon/core/constants/images_const.dart';
import 'package:recon/core/services/biometrice_auth.dart';
import 'package:recon/core/utils/utils.dart';
import 'package:recon/presentation/bloc/login/login_bloc.dart';
import 'package:recon/presentation/bloc/login/login_state.dart';
import 'package:recon/presentation/routes/app_router.gr.dart';
import 'package:recon/presentation/widgets/button/mainbutton_widget.dart';

@RoutePage()
class SigninPage extends StatefulWidget {
  const SigninPage({super.key});

  @override
  State<SigninPage> createState() => _SigninPageState();
}

class _SigninPageState extends State<SigninPage> {
  final TextEditingController _corpIdController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool showPassword = false;
  bool _isBiometricSupported = false;

  final List<String> corpIds = ['TVCQLOLA', 'QLA1', 'Corp003'];
  String selectedLanguage = 'ID';
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _checkBiometrics();
  }

  void _checkBiometrics() async {
    final isSupported = await BiometriceAuth.isDeviceSupported();
    if (!mounted) return;

    debugPrint('Biometrik Supported: $isSupported');
    setState(() {
      _isBiometricSupported = isSupported;
    });
  }

  void _handleSeamlessLogin(BuildContext context) async {
    if (_isBiometricSupported) {
      final isAuthenticated = await BiometriceAuth.authenticate(
        title: 'Login dengan Sidik Jari',
        hint: 'Silakan scan sidik jari untuk melanjutkan.',
      );
      if (isAuthenticated) {
        context.read<LoginBloc>().add(LoginFormSubmitted());
        context.router.replace(HomeRoute());
      }
    }
  }

  void _showHelpPopup() {
    showDialog(
      context: context,
      builder:
          (_) => AlertDialog(
            title: const Text('Help Center'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ElevatedButton(onPressed: () {}, child: const Text('Call 911')),
                ElevatedButton(onPressed: () {}, child: const Text('WhatsApp')),
                ElevatedButton(
                  onPressed: () {},
                  child: const Text('Email Support'),
                ),
              ],
            ),
          ),
    );
  }

  void _showLanguageSelector() {
    showModalBottomSheet(
      context: context,
      builder:
          (_) => Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: const Text('Indonesia'),
                onTap: () => setState(() => selectedLanguage = 'ID'),
              ),
              ListTile(
                title: const Text('English'),
                onTap: () => setState(() => selectedLanguage = 'EN'),
              ),
              ListTile(
                title: const Text('Chinese'),
                onTap: () => setState(() => selectedLanguage = 'CH'),
              ),
            ],
          ),
    );
  }

  void _openForgotPassword(BuildContext context) {
    context.router.push(ForgetpasswordRoute());
  }

  void _navigateToTerms(BuildContext context) {
    context.router.push(TermsconditionRoute());
  }

  void _login(BuildContext context) {
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
    return BlocProvider(
      create: (context) => LoginBloc(),
      child: BlocBuilder<LoginBloc, LoginState>(
        builder: (context, state) {
          return Scaffold(
            backgroundColor: Colors.grey.shade900,
            body: LayoutBuilder(
              builder: (context, constraints) {
                return Stack(
                  children: [
                    Column(
                      children: [
                        Expanded(
                          child: Image.network(
                            "https://upload.wikimedia.org/wikipedia/commons/thumb/2/2c/Kantor_Pusat_Bank_Rakyat_Indonesia_%282025%29.jpg/500px-Kantor_Pusat_Bank_Rakyat_Indonesia_%282025%29.jpg",
                            fit: BoxFit.cover,
                            width: double.infinity,
                            loadingBuilder: (context, child, progress) {
                              if (progress == null) return child;
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            },
                            errorBuilder: (context, error, stackTrace) {
                              return const Center(
                                child: Icon(Icons.broken_image),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                    SingleChildScrollView(
                      child: ConstrainedBox(
                        constraints: BoxConstraints(
                          minHeight: constraints.maxHeight,
                        ),
                        child: IntrinsicHeight(
                          child: Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(
                                  left: 16.0,
                                  right: 16.0,
                                  top: MediaQuery.of(context).padding.top,
                                ),
                                child: Row(
                                  children: [
                                    Image.network(
                                      AppImages.logoQlolaWhite,
                                      width: 40,
                                      loadingBuilder: (
                                        context,
                                        child,
                                        progress,
                                      ) {
                                        if (progress == null) return child;
                                        return const Center(
                                          child: CircularProgressIndicator(),
                                        );
                                      },
                                      errorBuilder: (
                                        context,
                                        error,
                                        stackTrace,
                                      ) {
                                        return const Center(
                                          child: Icon(Icons.broken_image),
                                        );
                                      },
                                    ),
                                    const Spacer(),
                                    GestureDetector(
                                      onTap: _showLanguageSelector,
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 12,
                                          vertical: 6,
                                        ),
                                        decoration: BoxDecoration(
                                          color: Colors.black45,
                                          borderRadius: BorderRadius.circular(
                                            20,
                                          ),
                                        ),
                                        child: Row(
                                          children: [
                                            Text(
                                              selectedLanguage,
                                              style: const TextStyle(
                                                color: Colors.white,
                                              ),
                                            ),
                                            const Icon(
                                              Icons.swap_vert,
                                              color: Colors.white,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 40),
                              const Spacer(),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  TextButton.icon(
                                    onPressed: _showHelpPopup,
                                    icon: const Icon(
                                      Icons.headset_mic_outlined,
                                      color: Colors.white,
                                    ),
                                    label: const Text(
                                      'Help Center',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    style: TextButton.styleFrom(
                                      backgroundColor: MainColors.black
                                          .withAlpha(100),
                                      shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.only(
                                          topRight: Radius.circular(16),
                                          bottomRight: Radius.circular(16),
                                        ),
                                      ),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      // Navigasi ke halaman Help Center atau Syarat & Ketentuan
                                      _navigateToTerms(context);
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 16,
                                        vertical: 8,
                                      ),
                                      decoration: BoxDecoration(
                                        color:  MainColors.black
                                          .withAlpha(50),
                                        borderRadius: const BorderRadius.only(
                                          topLeft: Radius.circular(16),
                                          bottomLeft: Radius.circular(16),
                                        ),
                                      ),
                                      child: 
                                          Text(
                                            'Syarat Ketentuan',
                                            style: TextStyle(
                                              color: Colors.white,
                                            ),
                                        
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 16),
                              Container(
                                width: double.infinity,
                                padding: EdgeInsets.only(
                                  left: 16.0,
                                  right: 16.0,
                                  top: 16.0,
                                  bottom: MediaQuery.of(context).padding.bottom,
                                ),
                                decoration: const BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(24),
                                  ),
                                ),
                                child: Center(
                                  child: ConstrainedBox(
                                    constraints: const BoxConstraints(),
                                    child: Form(
                                      key: _formKey,
                                      child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          'Login',
                                          style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Align(
                                          alignment: Alignment.topRight,
                                          child: TextButton(
                                            onPressed:
                                                () => _openForgotPassword(
                                                  context,
                                                ),
                                            child: const Text('Lupa Password'),
                                          ),
                                        ),
                                        const SizedBox(height: 8),
                                        TextField(
                                          controller: _corpIdController,
                                          decoration: const InputDecoration(
                                            prefixIcon: Icon(
                                              Icons.person_outline,
                                            ),
                                            labelText: 'Corp ID',
                                            border: OutlineInputBorder(),
                                          ),
                                        ),
                                        const SizedBox(height: 12),
                                        TextField(
                                          controller: _usernameController,
                                          decoration: const InputDecoration(
                                            prefixIcon: Icon(
                                              Icons.person_outline,
                                            ),
                                            labelText: 'Username',
                                            border: OutlineInputBorder(),
                                          ),
                                        ),
                                        const SizedBox(height: 12),
                                        TextField(
                                          controller: _passwordController,
                                          obscureText: !showPassword,
                                          decoration: InputDecoration(
                                            prefixIcon: const Icon(
                                              Icons.lock_outline,
                                            ),
                                            labelText: 'Password',
                                            border: const OutlineInputBorder(),
                                            suffixIcon: IconButton(
                                              icon: Icon(
                                                showPassword
                                                    ? Icons.visibility_off
                                                    : Icons.visibility,
                                              ),
                                              onPressed:
                                                  () => setState(
                                                    () =>
                                                        showPassword =
                                                            !showPassword,
                                                  ),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(height: 16),
                                        BlocBuilder<LoginBloc, LoginState>(
                                          builder: (context, state) {
                                            if (state.isLoginSuccess) {
                                              context.router.replace(
                                                HomeRoute(),
                                              );
                                            }
                                            return Row(
                                              children: [
                                                Expanded(
                                                  child: MainbuttonWidget(
                                                    text: 'Login',
                                                    onPressed:
                                                        () => _login(context),
                                                    justify:
                                                        MainAxisAlignment.center,
                                                    colorType: ColorType.blue,
                                                    size: ButtonSize.medium,
                                                    type: ButtonType.fullfilled,
                                                  ),
                                                ),
                                                const SizedBox(width: 12),
                                                if (_isBiometricSupported) 
                                                  IconButton(
                                                    onPressed: () {
                                                      _handleSeamlessLogin(context);
                                                    },
                                                    icon: const Icon(Icons.fingerprint),
                                                    style: IconButton.styleFrom(
                                                      backgroundColor: Colors.blue,
                                                      foregroundColor: Colors.white,
                                                    ),
                                                  ),
                                              ],
                                            );
                                          },
                                        ),
                                      ],
                                    ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          );
        },
      ),
    );
  }
}
