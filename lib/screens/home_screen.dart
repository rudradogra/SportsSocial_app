import 'package:flutter/material.dart';
import '../constants/app_constants.dart';
import 'login_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundPrimary,
      appBar: AppBar(
        backgroundColor: AppColors.backgroundSecondary,
        elevation: 0,
        title: ShaderMask(
          shaderCallback: (bounds) =>
              AppColors.primaryGradient.createShader(bounds),
          child: const Text(
            'Sports Social',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(
              Icons.notifications_outlined,
              color: AppColors.textSecondary,
            ),
            onPressed: () {
              // TODO: Navigate to notifications
            },
          ),
          IconButton(
            icon: const Icon(Icons.logout, color: AppColors.textSecondary),
            onPressed: () {
              // Navigate back to login
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const LoginScreen()),
              );
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppDimensions.spacingM),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Welcome Section
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(AppDimensions.spacingL),
                decoration: BoxDecoration(
                  color: AppColors.backgroundSecondary,
                  borderRadius: BorderRadius.circular(
                    AppDimensions.borderRadiusM,
                  ),
                  border: Border.all(color: AppColors.borderPrimary, width: 1),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            color: AppColors.borderPrimary,
                            borderRadius: BorderRadius.circular(25),
                          ),
                          child: ClipOval(
                            child: Image.asset(
                              'assets/images/newlogo.png',
                              width: 40,
                              height: 40,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return const Icon(
                                  Icons.person,
                                  color: AppColors.textSecondary,
                                  size: 30,
                                );
                              },
                            ),
                          ),
                        ),
                        const SizedBox(width: AppDimensions.spacingM),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Welcome Back!',
                                style: AppTextStyles.heading1,
                              ),
                              const SizedBox(height: 4),
                              Text(
                                'Ready to connect with your sports community?',
                                style: AppTextStyles.bodyMedium.copyWith(
                                  color: AppColors.textSecondary,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: AppDimensions.spacingL),

              // Quick Actions
              const Text('Quick Actions', style: AppTextStyles.heading1),
              const SizedBox(height: AppDimensions.spacingM),

              Row(
                children: [
                  Expanded(
                    child: _buildQuickActionCard(
                      icon: Icons.event_available,
                      title: 'Find Events',
                      subtitle: 'Discover local sports events',
                      onTap: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Events feature coming soon!'),
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(width: AppDimensions.spacingM),
                  Expanded(
                    child: _buildQuickActionCard(
                      icon: Icons.message,
                      title: 'Messages',
                      subtitle: 'Chat with athletes',
                      onTap: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Messages feature coming soon!'),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppDimensions.spacingM),

              Row(
                children: [
                  Expanded(
                    child: _buildQuickActionCard(
                      icon: Icons.group_add,
                      title: 'Find People',
                      subtitle: 'Connect with athletes',
                      onTap: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Search feature coming soon!'),
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(width: AppDimensions.spacingM),
                  Expanded(
                    child: _buildQuickActionCard(
                      icon: Icons.star_rate,
                      title: 'Reviews',
                      subtitle: 'Rate your experiences',
                      onTap: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Reviews feature coming soon!'),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppDimensions.spacingL),

              // Recent Activity Section
              const Text('Recent Activity', style: AppTextStyles.heading1),
              const SizedBox(height: AppDimensions.spacingM),

              Expanded(
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(AppDimensions.spacingL),
                  decoration: BoxDecoration(
                    color: AppColors.backgroundSecondary,
                    borderRadius: BorderRadius.circular(
                      AppDimensions.borderRadiusM,
                    ),
                    border: Border.all(
                      color: AppColors.borderPrimary,
                      width: 1,
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.sports_soccer,
                        color: AppColors.textTertiary,
                        size: 48,
                      ),
                      const SizedBox(height: AppDimensions.spacingM),
                      Text(
                        'No recent activity',
                        style: AppTextStyles.bodyLarge.copyWith(
                          color: AppColors.textSecondary,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Start connecting with your sports community to see activity here!',
                        textAlign: TextAlign.center,
                        style: AppTextStyles.bodyMedium.copyWith(
                          color: AppColors.textTertiary,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: AppColors.backgroundSecondary,
          border: Border(
            top: BorderSide(color: AppColors.borderPrimary, width: 1),
          ),
        ),
        child: BottomNavigationBar(
          backgroundColor: Colors.transparent,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: AppColors.primaryOrange,
          unselectedItemColor: AppColors.textTertiary,
          currentIndex: 0,
          elevation: 0,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(icon: Icon(Icons.event), label: 'Events'),
            BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
            BottomNavigationBarItem(
              icon: Icon(Icons.message),
              label: 'Messages',
            ),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
          ],
          onTap: (index) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Tab ${index + 1} coming soon!')),
            );
          },
        ),
      ),
    );
  }

  Widget _buildQuickActionCard({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(AppDimensions.spacingM),
        decoration: BoxDecoration(
          color: AppColors.backgroundSecondary,
          borderRadius: BorderRadius.circular(AppDimensions.borderRadiusM),
          border: Border.all(color: AppColors.borderPrimary, width: 1),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                gradient: AppColors.primaryGradient,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(icon, color: Colors.white, size: 20),
            ),
            const SizedBox(height: AppDimensions.spacingS),
            Text(
              title,
              style: AppTextStyles.bodyLarge.copyWith(
                fontWeight: AppTextStyles.fontWeightSemiBold,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              subtitle,
              style: AppTextStyles.bodySmall.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
