import 'package:flutter/material.dart';
import '../constants/app_constants.dart';
import 'register_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isObscured = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundPrimary,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(AppDimensions.spacingL),
            child: Container(
              constraints: const BoxConstraints(
                maxWidth: AppDimensions.containerMaxWidth,
              ),
              padding: const EdgeInsets.all(AppDimensions.spacingXL),
              decoration: BoxDecoration(
                color: AppColors.backgroundSecondary,
                borderRadius: BorderRadius.circular(
                  AppDimensions.borderRadiusM,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Logo
                    Container(
                      width: 60,
                      height: 60,
                      child: ClipOval(
                        child: Image.asset(
                          'assets/images/newlogo.png',
                          width: 56,
                          height: 56,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return const Icon(
                              Icons.sports_soccer,
                              color: AppColors.primaryOrange,
                              size: 30,
                            );
                          },
                        ),
                      ),
                    ),
                    const SizedBox(height: AppDimensions.spacingM),

                    // App Name
                    ShaderMask(
                      shaderCallback: (bounds) =>
                          AppColors.primaryGradient.createShader(bounds),
                      child: const Text(
                        'Sports Social',
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    const SizedBox(height: AppDimensions.spacingL),

                    // Welcome Back Title
                    const Text('Welcome Back', style: AppTextStyles.heading2),
                    const SizedBox(height: 8),

                    // Subtitle
                    SizedBox(
                      width: 280,
                      child: const Text(
                        'Sign in to your Sports Social account to connect with athletes, find local games, and build your sports community.',
                        textAlign: TextAlign.center,
                        style: AppTextStyles.bodyMedium,
                      ),
                    ),
                    const SizedBox(height: 32),

                    // Email Field
                    TextFormField(
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      style: AppTextStyles.bodyLarge,
                      decoration: InputDecoration(
                        hintText: 'Email address',
                        hintStyle: const TextStyle(
                          color: AppColors.textTertiary,
                        ),
                        filled: true,
                        fillColor: AppColors.borderPrimary,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(
                            AppDimensions.borderRadiusS,
                          ),
                          borderSide: BorderSide.none,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(
                            AppDimensions.borderRadiusS,
                          ),
                          borderSide: const BorderSide(
                            color: AppColors.primaryOrange,
                            width: 2,
                          ),
                        ),
                        contentPadding: const EdgeInsets.all(
                          AppDimensions.spacingM,
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your email';
                        }
                        if (!value.contains('@')) {
                          return 'Please enter a valid email';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: AppDimensions.spacingM),

                    // Password Field
                    TextFormField(
                      controller: _passwordController,
                      obscureText: _isObscured,
                      style: AppTextStyles.bodyLarge,
                      decoration: InputDecoration(
                        hintText: 'Password',
                        hintStyle: const TextStyle(
                          color: AppColors.textTertiary,
                        ),
                        filled: true,
                        fillColor: AppColors.borderPrimary,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(
                            AppDimensions.borderRadiusS,
                          ),
                          borderSide: BorderSide.none,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(
                            AppDimensions.borderRadiusS,
                          ),
                          borderSide: const BorderSide(
                            color: AppColors.primaryOrange,
                            width: 2,
                          ),
                        ),
                        contentPadding: const EdgeInsets.all(
                          AppDimensions.spacingM,
                        ),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _isObscured
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: AppColors.textTertiary,
                          ),
                          onPressed: () {
                            setState(() {
                              _isObscured = !_isObscured;
                            });
                          },
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your password';
                        }
                        if (value.length < 6) {
                          return 'Password must be at least 6 characters';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: AppDimensions.spacingS),

                    // Forgot Password Link
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {
                          // TODO: Implement forgot password functionality
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                'Forgot password functionality coming soon',
                              ),
                            ),
                          );
                        },
                        child: const Text(
                          'Forgot your password?',
                          style: TextStyle(
                            color: AppColors.primaryOrange,
                            fontWeight: AppTextStyles.fontWeightMedium,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: AppDimensions.spacingS),

                    // Sign In Button
                    SizedBox(
                      width: double.infinity,
                      height: AppDimensions.buttonHeight,
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: AppColors.primaryGradient,
                          borderRadius: BorderRadius.circular(
                            AppDimensions.borderRadiusS,
                          ),
                        ),
                        child: ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              // TODO: Implement sign in functionality
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                    'Sign in functionality coming soon',
                                  ),
                                ),
                              );
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.transparent,
                            shadowColor: Colors.transparent,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                AppDimensions.borderRadiusS,
                              ),
                            ),
                          ),
                          child: const Text(
                            'Sign In',
                            style: TextStyle(
                              fontSize: AppTextStyles.fontSizeM,
                              fontWeight: AppTextStyles.fontWeightSemiBold,
                              color: AppColors.textPrimary,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: AppDimensions.spacingL),

                    // Sign Up Link
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Don't have an account? ",
                          style: AppTextStyles.bodyMedium,
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const RegisterScreen(),
                              ),
                            );
                          },
                          child: const Text(
                            'Sign up for free',
                            style: TextStyle(
                              color: AppColors.primaryOrange,
                              fontWeight: AppTextStyles.fontWeightMedium,
                              fontSize: AppTextStyles.fontSizeS,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: AppDimensions.spacingS),

                    // Footer Links
                    Wrap(
                      alignment: WrapAlignment.center,
                      children: [
                        TextButton(
                          onPressed: () {},
                          style: TextButton.styleFrom(
                            padding: const EdgeInsets.symmetric(horizontal: 4),
                            minimumSize: Size.zero,
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          ),
                          child: const Text(
                            'Privacy Policy',
                            style: TextStyle(
                              color: AppColors.textTertiary,
                              fontSize: 10,
                              fontWeight: AppTextStyles.fontWeightNormal,
                            ),
                          ),
                        ),
                        const Text(
                          ' • ',
                          style: TextStyle(
                            color: AppColors.textTertiary,
                            fontSize: 10,
                          ),
                        ),
                        TextButton(
                          onPressed: () {},
                          style: TextButton.styleFrom(
                            padding: const EdgeInsets.symmetric(horizontal: 4),
                            minimumSize: Size.zero,
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          ),
                          child: const Text(
                            'Terms of Service',
                            style: TextStyle(
                              color: AppColors.textTertiary,
                              fontSize: 10,
                              fontWeight: AppTextStyles.fontWeightNormal,
                            ),
                          ),
                        ),
                        const Text(
                          ' • ',
                          style: TextStyle(
                            color: AppColors.textTertiary,
                            fontSize: 10,
                          ),
                        ),
                        TextButton(
                          onPressed: () {},
                          style: TextButton.styleFrom(
                            padding: const EdgeInsets.symmetric(horizontal: 4),
                            minimumSize: Size.zero,
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          ),
                          child: const Text(
                            'About Us',
                            style: TextStyle(
                              color: AppColors.textTertiary,
                              fontSize: 10,
                              fontWeight: AppTextStyles.fontWeightNormal,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
