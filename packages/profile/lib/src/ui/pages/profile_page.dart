import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:auth/auth.dart';
import 'package:profile/profile.dart';

class ProfilePage extends ConsumerStatefulWidget {
  const ProfilePage({super.key});

  @override
  ConsumerState<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends ConsumerState<ProfilePage> {
  bool _profileLoadAttempted = false;

  @override
  void initState() {
    super.initState();
    // Don't load immediately - wait for auth state to be ready
    // The build method will trigger load when auth state is available
  }

  Future<void> _loadProfile() async {
    final authState = ref.read(authStateNotifierProvider);

    if (authState.isAuthenticated && authState.userData != null) {
      final userId = authState.userData!.id;

      if (userId != null && userId.isNotEmpty) {
        await ref
            .read(profileStateNotifierProvider.notifier)
            .loadProfile(userId);
      }
    }
  }

  void _checkAndLoadProfile(AuthState authState) {
    // Only attempt to load once when authenticated
    if (authState.isAuthenticated &&
        authState.userData != null &&
        !_profileLoadAttempted) {
      _profileLoadAttempted = true;
      Future.microtask(() => _loadProfile());
    }
  }

  Future<void> _logout() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Logout'),
        content: const Text('Are you sure you want to logout?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Logout'),
          ),
        ],
      ),
    );

    if (confirmed == true && mounted) {
      await ref.read(authStateNotifierProvider.notifier).logout();
      ref.read(profileStateNotifierProvider.notifier).clearProfile();
      if (mounted) {
        context.go('/login');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authStateNotifierProvider);
    final profileState = ref.watch(profileStateNotifierProvider);

    // Check and load profile when auth state is ready
    _checkAndLoadProfile(authState);

    if (!authState.isAuthenticated) {
      return Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.person_outline,
                size: 100,
                color: Colors.grey,
              ),
              const SizedBox(height: 24),
              const Text(
                'Please login to view your profile',
                style: TextStyle(fontSize: 18, color: Colors.grey),
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () {
                  context.go('/login');
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 48,
                    vertical: 16,
                  ),
                ),
                child: const Text('Login'),
              ),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: _logout,
            tooltip: 'Logout',
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: _loadProfile,
        child: profileState.isLoading && profileState.customer == null
            ? const Center(child: CircularProgressIndicator())
            : profileState.error != null && profileState.customer == null
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.error_outline,
                          size: 64,
                          color: Colors.red,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'Error loading profile',
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          profileState.error!,
                          style: const TextStyle(color: Colors.grey),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 16),
                        ElevatedButton(
                          onPressed: _loadProfile,
                          child: const Text('Retry'),
                        ),
                      ],
                    ),
                  )
                : profileState.customer != null
                    ? SingleChildScrollView(
                        physics: const AlwaysScrollableScrollPhysics(),
                        child: Column(
                          children: [
                            _buildProfileHeader(profileState.customer!),
                            const Divider(height: 1),
                            _buildProfileDetails(profileState.customer!),
                          ],
                        ),
                      )
                    : const Center(child: Text('No profile data')),
      ),
    );
  }

  Widget _buildProfileHeader(customer) {
    return Container(
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          CircleAvatar(
            radius: 50,
            backgroundImage: NetworkImage(customer.avatarUrl),
            backgroundColor: Colors.grey[300],
          ),
          const SizedBox(height: 16),
          Text(
            customer.fullName,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            '@${customer.username}',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 8),
          Chip(
            label: Text(customer.role.toUpperCase()),
            backgroundColor: Colors.blue[100],
          ),
          const SizedBox(height: 16),
          OutlinedButton.icon(
            onPressed: () {
              context.push('/profile/edit-info', extra: customer);
            },
            icon: const Icon(Icons.edit, size: 18),
            label: const Text('Edit Profile'),
            style: OutlinedButton.styleFrom(
              padding: const EdgeInsets.symmetric(
                horizontal: 24,
                vertical: 12,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileDetails(customer) {
    return Column(
      children: [
        _buildInfoTile(
          Icons.email_outlined,
          'Email',
          customer.email,
        ),
        _buildInfoTile(
          Icons.calendar_today_outlined,
          'Member Since',
          _formatDate(customer.dateCreated),
        ),
        _buildInfoTile(
          Icons.shopping_bag_outlined,
          'Paying Customer',
          customer.isPayingCustomer ? 'Yes' : 'No',
        ),
        if (customer.billing.hasAddress) ...[
          const Divider(height: 32),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Billing Address',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                TextButton.icon(
                  onPressed: () {
                    context.push('/profile/edit-billing', extra: customer);
                  },
                  icon: const Icon(Icons.edit, size: 18),
                  label: const Text('Edit'),
                ),
              ],
            ),
          ),
          _buildAddressTile(customer.billing),
        ],
        if (customer.shipping.hasAddress) ...[
          const Divider(height: 32),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Shipping Address',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ),
          ),
          _buildAddressTile(customer.shipping),
        ],
        const SizedBox(height: 24),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: SizedBox(
            width: double.infinity,
            child: OutlinedButton.icon(
              onPressed: _logout,
              icon: const Icon(Icons.logout),
              label: const Text('Logout'),
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
            ),
          ),
        ),
        const SizedBox(height: 24),
      ],
    );
  }

  Widget _buildInfoTile(IconData icon, String title, String value) {
    return ListTile(
      leading: Icon(icon, color: Colors.blue),
      title: Text(title),
      subtitle: Text(
        value,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: Colors.black87,
        ),
      ),
    );
  }

  Widget _buildAddressTile(dynamic address) {
    return ListTile(
      leading: const Icon(Icons.location_on_outlined, color: Colors.blue),
      title: Text(address.fullAddress.isNotEmpty
          ? address.fullAddress
          : 'No address provided'),
      subtitle: address is BillingAddress && address.phone.isNotEmpty
          ? Text('Phone: ${address.phone}')
          : address.phone.isNotEmpty
              ? Text('Phone: ${address.phone}')
              : null,
    );
  }

  String _formatDate(String dateString) {
    try {
      final date = DateTime.parse(dateString);
      final months = [
        'Jan',
        'Feb',
        'Mar',
        'Apr',
        'May',
        'Jun',
        'Jul',
        'Aug',
        'Sep',
        'Oct',
        'Nov',
        'Dec'
      ];
      return '${months[date.month - 1]} ${date.day}, ${date.year}';
    } catch (e) {
      return dateString;
    }
  }
}
