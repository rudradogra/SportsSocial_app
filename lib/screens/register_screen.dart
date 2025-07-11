import 'package:flutter/material.dart';
import '../constants/app_constants.dart';
import '../services/api_service.dart';
import '../models/user.dart';
import 'home_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _bioController = TextEditingController();
  final _sportsController = TextEditingController();
  final _tagsController = TextEditingController();

  bool _isPasswordObscured = true;
  bool _isConfirmPasswordObscured = true;
  bool _agreeToTerms = false;
  bool _showPasswordRequirements = false;
  bool _isLoading = false;

  // Password strength tracking
  bool _hasMinLength = false;
  bool _hasUppercase = false;
  bool _hasNumber = false;
  double _passwordStrength = 0.0;

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _bioController.dispose();
    _sportsController.dispose();
    _tagsController.dispose();
    super.dispose();
  }

  void _checkPasswordStrength(String password) {
    setState(() {
      _hasMinLength = password.length >= 6;
      _hasUppercase = password.contains(RegExp(r'[A-Z]'));
      _hasNumber = password.contains(RegExp(r'[0-9]'));

      int strengthCount = 0;
      if (_hasMinLength) strengthCount++;
      if (_hasUppercase) strengthCount++;
      if (_hasNumber) strengthCount++;

      _passwordStrength = strengthCount / 3;
    });
  }

  Color _getPasswordStrengthColor() {
    if (_passwordStrength <= 0.33) return AppColors.error;
    if (_passwordStrength <= 0.66) return AppColors.warning;
    return AppColors.success;
  }

  String _getPasswordStrengthText() {
    if (_passwordStrength <= 0.33) return 'Weak';
    if (_passwordStrength <= 0.66) return 'Medium';
    return 'Strong';
  }

  Future<void> _register() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isLoading = true;
    });

    try {
      final response = await ApiService.register(
        username: _usernameController.text.trim(),
        email: _emailController.text.trim(),
        password: _passwordController.text,
        bio: _bioController.text.trim().isEmpty
            ? null
            : _bioController.text.trim(),
        sports: _sportsController.text.trim().isEmpty
            ? null
            : _sportsController.text.trim(),
        tags: _tagsController.text.trim().isEmpty
            ? null
            : _tagsController.text.trim(),
      );

      // Registration successful
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const HomeScreen()),
        );
      }
    } catch (e) {
      // Show error message
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(e.toString().replaceFirst('ApiException: ', '')),
            backgroundColor: AppColors.error,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
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

                    // Title
                    const Text(
                      'Join Our Community',
                      style: AppTextStyles.heading2,
                    ),
                    const SizedBox(height: 8),

                    // Subtitle
                    SizedBox(
                      width: 300,
                      child: const Text(
                        'Create your Sports Social account to connect with athletes, discover local events, and build your sports community.',
                        textAlign: TextAlign.center,
                        style: AppTextStyles.bodyMedium,
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Username Field
                    TextFormField(
                      controller: _usernameController,
                      style: AppTextStyles.bodyLarge,
                      decoration: InputDecoration(
                        hintText: 'Username',
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
                          return 'Please enter a username';
                        }
                        if (value.length < 3) {
                          return 'Username must be at least 3 characters';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: AppDimensions.spacingM),

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
                      obscureText: _isPasswordObscured,
                      style: AppTextStyles.bodyLarge,
                      onChanged: (value) {
                        _checkPasswordStrength(value);
                        setState(() {
                          _showPasswordRequirements = value.isNotEmpty;
                        });
                      },
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
                          borderSide: BorderSide(
                            color: _passwordController.text.isNotEmpty
                                ? _getPasswordStrengthColor()
                                : AppColors.primaryOrange,
                            width: 2,
                          ),
                        ),
                        contentPadding: const EdgeInsets.all(
                          AppDimensions.spacingM,
                        ),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _isPasswordObscured
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: AppColors.textTertiary,
                          ),
                          onPressed: () {
                            setState(() {
                              _isPasswordObscured = !_isPasswordObscured;
                            });
                          },
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a password';
                        }
                        if (!_hasMinLength) {
                          return 'Password must be at least 6 characters';
                        }
                        return null;
                      },
                    ),

                    // Password Strength Indicator
                    if (_showPasswordRequirements &&
                        _passwordController.text.isNotEmpty) ...[
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Expanded(
                            child: LinearProgressIndicator(
                              value: _passwordStrength,
                              backgroundColor: AppColors.borderPrimary,
                              valueColor: AlwaysStoppedAnimation<Color>(
                                _getPasswordStrengthColor(),
                              ),
                              minHeight: 4,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            _getPasswordStrengthText(),
                            style: TextStyle(
                              color: _getPasswordStrengthColor(),
                              fontSize: AppTextStyles.fontSizeXS,
                              fontWeight: AppTextStyles.fontWeightMedium,
                            ),
                          ),
                        ],
                      ),
                    ],

                    // Password Requirements
                    if (_showPasswordRequirements) ...[
                      const SizedBox(height: 12),
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: AppColors.backgroundPrimary,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: AppColors.borderSecondary,
                            width: 1,
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Password Requirements:',
                              style: TextStyle(
                                color: AppColors.textPrimary,
                                fontSize: AppTextStyles.fontSizeS,
                                fontWeight: AppTextStyles.fontWeightMedium,
                              ),
                            ),
                            const SizedBox(height: 8),
                            _buildRequirementItem(
                              'At least 6 characters long',
                              _hasMinLength,
                            ),
                            _buildRequirementItem(
                              'One uppercase letter (recommended)',
                              _hasUppercase,
                            ),
                            _buildRequirementItem(
                              'One number (recommended)',
                              _hasNumber,
                            ),
                          ],
                        ),
                      ),
                    ],

                    const SizedBox(height: AppDimensions.spacingM),

                    // Confirm Password Field
                    TextFormField(
                      controller: _confirmPasswordController,
                      obscureText: _isConfirmPasswordObscured,
                      style: AppTextStyles.bodyLarge,
                      decoration: InputDecoration(
                        hintText: 'Confirm Password',
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
                            _isConfirmPasswordObscured
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: AppColors.textTertiary,
                          ),
                          onPressed: () {
                            setState(() {
                              _isConfirmPasswordObscured =
                                  !_isConfirmPasswordObscured;
                            });
                          },
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please confirm your password';
                        }
                        if (value != _passwordController.text) {
                          return 'Passwords do not match';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: AppDimensions.spacingM),

                    // Bio Field
                    TextFormField(
                      controller: _bioController,
                      maxLines: 3,
                      style: AppTextStyles.bodyLarge,
                      decoration: InputDecoration(
                        hintText: 'Tell us about yourself (optional)',
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
                    ),
                    const SizedBox(height: AppDimensions.spacingM),

                    // Sports Field
                    TextFormField(
                      controller: _sportsController,
                      style: AppTextStyles.bodyLarge,
                      decoration: InputDecoration(
                        hintText: 'Sports you play (comma separated)',
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
                    ),
                    const SizedBox(height: AppDimensions.spacingM),

                    // Tags/Interests Field
                    TextFormField(
                      controller: _tagsController,
                      style: AppTextStyles.bodyLarge,
                      decoration: InputDecoration(
                        hintText: 'Tags/Interests (comma separated)',
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
                    ),
                    const SizedBox(height: AppDimensions.spacingL),

                    // Terms and Conditions Checkbox
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Checkbox(
                          value: _agreeToTerms,
                          onChanged: (value) {
                            setState(() {
                              _agreeToTerms = value ?? false;
                            });
                          },
                          activeColor: AppColors.primaryOrange,
                          checkColor: Colors.white,
                          side: const BorderSide(
                            color: AppColors.textTertiary,
                            width: 1.5,
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(top: 12),
                            child: RichText(
                              text: const TextSpan(
                                style: AppTextStyles.bodySmall,
                                children: [
                                  TextSpan(
                                    text: 'I have read and agree to the ',
                                    style: TextStyle(
                                      color: AppColors.textSecondary,
                                    ),
                                  ),
                                  TextSpan(
                                    text: 'Terms and Conditions',
                                    style: TextStyle(
                                      color: AppColors.primaryOrange,
                                      decoration: TextDecoration.underline,
                                    ),
                                  ),
                                  TextSpan(
                                    text: ' and ',
                                    style: TextStyle(
                                      color: AppColors.textSecondary,
                                    ),
                                  ),
                                  TextSpan(
                                    text: 'Privacy Policy',
                                    style: TextStyle(
                                      color: AppColors.primaryOrange,
                                      decoration: TextDecoration.underline,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: AppDimensions.spacingL),

                    // Create Account Button
                    SizedBox(
                      width: double.infinity,
                      height: AppDimensions.buttonHeight,
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: _agreeToTerms && !_isLoading
                              ? AppColors.primaryGradient
                              : const LinearGradient(
                                  colors: [
                                    AppColors.textTertiary,
                                    AppColors.textTertiary,
                                  ],
                                ),
                          borderRadius: BorderRadius.circular(
                            AppDimensions.borderRadiusS,
                          ),
                        ),
                        child: ElevatedButton(
                          onPressed: _agreeToTerms && !_isLoading
                              ? _register
                              : null,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.transparent,
                            shadowColor: Colors.transparent,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                AppDimensions.borderRadiusS,
                              ),
                            ),
                          ),
                          child: _isLoading
                              ? const SizedBox(
                                  width: 20,
                                  height: 20,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                      Colors.white,
                                    ),
                                  ),
                                )
                              : const Text(
                                  'Create Account',
                                  style: TextStyle(
                                    fontSize: AppTextStyles.fontSizeM,
                                    fontWeight:
                                        AppTextStyles.fontWeightSemiBold,
                                    color: AppColors.textPrimary,
                                  ),
                                ),
                        ),
                      ),
                    ),
                    const SizedBox(height: AppDimensions.spacingL),

                    // Sign In Link
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Already have an account? ',
                          style: AppTextStyles.bodyMedium,
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text(
                            'Sign in here',
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

  Widget _buildRequirementItem(String text, bool isMet) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        children: [
          Icon(
            isMet ? Icons.check_circle : Icons.circle_outlined,
            size: 16,
            color: isMet ? AppColors.success : AppColors.textTertiary,
          ),
          const SizedBox(width: 8),
          Text(
            text,
            style: TextStyle(
              color: isMet ? AppColors.success : AppColors.textTertiary,
              fontSize: AppTextStyles.fontSizeXS,
            ),
          ),
        ],
      ),
    );
  }
}
