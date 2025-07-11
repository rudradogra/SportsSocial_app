class ApiConfig {
  // Replace with your actual server URL
  static const String baseUrl = 'http://localhost:8000'; // For development
  // static const String baseUrl = 'https://your-production-url.com'; // For production

  // API Endpoints
  static const String loginEndpoint = '/api/auth/login';
  static const String registerEndpoint = '/api/auth/register';
  static const String sendOtpEndpoint = '/api/auth/send-otp';
  static const String verifyOtpEndpoint = '/api/auth/verify-otp';
  static const String meEndpoint = '/api/auth/me';

  // Request timeout
  static const Duration requestTimeout = Duration(seconds: 30);
}
