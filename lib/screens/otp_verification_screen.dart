import 'package:flutter/material.dart';
import '../services/api_service.dart';
import 'home_screen.dart';

class OtpVerificationScreen extends StatefulWidget {
  final String email;
  final String username;
  final String password;
  final String? bio;
  final List<String> sports;
  final List<String> tags;

  const OtpVerificationScreen({
    super.key,
    required this.email,
    required this.username,
    required this.password,
    this.bio,
    required this.sports,
    required this.tags,
  });

  @override
  State<OtpVerificationScreen> createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends State<OtpVerificationScreen> {
  final _formKey = GlobalKey<FormState>();
  final _otpController = TextEditingController();
  bool _isLoading = false;
  String? _errorMessage;
  bool _isResending = false;
  String? _resendMessage;
  int _resendCooldown = 0;

  @override
  void dispose() {
    _otpController.dispose();
    super.dispose();
  }

  void _startResendCooldown() {
    setState(() {
      _resendCooldown = 30;
    });
    Future.doWhile(() async {
      await Future.delayed(const Duration(seconds: 1));
      if (!mounted) return false;
      setState(() {
        _resendCooldown--;
      });
      return _resendCooldown > 0;
    });
  }

  Future<void> _resendOtp() async {
    setState(() {
      _isResending = true;
      _resendMessage = null;
    });
    try {
      await ApiService.sendOtp(
        username: widget.username,
        email: widget.email,
        password: widget.password,
        bio: widget.bio,
        sports: widget.sports,
        tags: widget.tags,
      );
      setState(() {
        _resendMessage = 'OTP resent successfully!';
      });
      _startResendCooldown();
    } catch (e) {
      setState(() {
        _resendMessage = e.toString().replaceFirst('ApiException: ', '');
      });
    } finally {
      if (mounted) {
        setState(() {
          _isResending = false;
        });
      }
    }
  }

  Future<void> _verifyOtp() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });
    try {
      final response = await ApiService.verifyOtp(
        email: widget.email,
        otp: _otpController.text.trim(),
      );
      // On success, navigate to home or show success
      if (mounted) {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const HomeScreen()),
          (route) => false,
        );
      }
    } catch (e) {
      setState(() {
        _errorMessage = e.toString().replaceFirst('ApiException: ', '');
      });
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
      appBar: AppBar(
        title: const Text('Verify Email'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Enter the OTP sent to',
              style: Theme.of(context).textTheme.bodyLarge,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              widget.email,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            Form(
              key: _formKey,
              child: TextFormField(
                controller: _otpController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'OTP',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the OTP';
                  }
                  if (value.length < 4) {
                    return 'OTP must be at least 4 digits';
                  }
                  return null;
                },
              ),
            ),
            const SizedBox(height: 24),
            if (_errorMessage != null)
              Padding(
                padding: const EdgeInsets.only(bottom: 12.0),
                child: Text(
                  _errorMessage!,
                  style: const TextStyle(color: Colors.red),
                  textAlign: TextAlign.center,
                ),
              ),
            if (_resendMessage != null)
              Padding(
                padding: const EdgeInsets.only(bottom: 12.0),
                child: Text(
                  _resendMessage!,
                  style: TextStyle(color: _resendMessage == 'OTP resent successfully!' ? Colors.green : Colors.red),
                  textAlign: TextAlign.center,
                ),
              ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: (_isResending || _resendCooldown > 0) ? null : _resendOtp,
                  child: _isResending
                      ? const SizedBox(width: 16, height: 16, child: CircularProgressIndicator(strokeWidth: 2))
                      : Text(_resendCooldown > 0 ? 'Resend OTP ($_resendCooldown)' : 'Resend OTP'),
                ),
              ],
            ),
            SizedBox(
              height: 48,
              child: ElevatedButton(
                onPressed: _isLoading ? null : _verifyOtp,
                child: _isLoading
                    ? const CircularProgressIndicator(strokeWidth: 2)
                    : const Text('Verify'),
              ),
            ),
          ],
        ),
      ),
    );
  }
} 