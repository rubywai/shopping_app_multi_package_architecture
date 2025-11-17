import 'package:auth/auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../providers/order_list_state_notifier.dart';
import '../../data/models/order_list_model.dart';

class OrderListPage extends ConsumerStatefulWidget {
  const OrderListPage({super.key});

  @override
  ConsumerState<OrderListPage> createState() => _OrderListPageState();
}

class _OrderListPageState extends ConsumerState<OrderListPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  // WooCommerce order statuses
  final List<Map<String, String>> _tabs = [
    {'label': 'All', 'status': ''},
    {'label': 'Pending', 'status': 'pending'},
    {'label': 'Processing', 'status': 'processing'},
    {'label': 'Completed', 'status': 'completed'},
    {'label': 'Cancelled', 'status': 'cancelled'},
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _tabs.length, vsync: this);
    _tabController.addListener(_handleTabChange);

    // Load initial orders
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadOrders();
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Reload orders when returning to this page
    _loadOrders();
  }

  void _handleTabChange() {
    if (!_tabController.indexIsChanging) {
      _loadOrders();
    }
  }

  void _loadOrders() {
    final authState = ref.read(authStateNotifierProvider);
    final customerId = authState.userData?.id;

    if (customerId != null) {
      final status = _tabs[_tabController.index]['status'];
      ref
          .read(orderListStateNotifierProvider.notifier)
          .loadOrders(
            customerId,
            status: status?.isEmpty == true ? null : status,
          );
    }
  }

  @override
  void dispose() {
    _tabController.removeListener(_handleTabChange);
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authStateNotifierProvider);
    final orderState = ref.watch(orderListStateNotifierProvider);

    // Check if user is authenticated
    if (!authState.isAuthenticated) {
      return Scaffold(
        appBar: AppBar(title: const Text('My Orders')),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.receipt_long_outlined,
                size: 100,
                color: Colors.grey,
              ),
              const SizedBox(height: 24),
              const Text(
                'Please login to view your orders',
                style: TextStyle(fontSize: 18, color: Colors.grey),
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () {
                  context.go('/login');
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 32,
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
        title: const Text('My Orders'),
        bottom: TabBar(
          controller: _tabController,
          isScrollable: true,
          tabs: _tabs.map((tab) => Tab(text: tab['label'])).toList(),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: _tabs.map((tab) {
          return _buildOrderList(orderState);
        }).toList(),
      ),
    );
  }

  Widget _buildOrderList(orderListState) {
    if (orderListState.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (orderListState.error != null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Error: ${orderListState.error}'),
            const SizedBox(height: 16),
            ElevatedButton(onPressed: _loadOrders, child: const Text('Retry')),
          ],
        ),
      );
    }

    if (orderListState.orders.isEmpty) {
      return const Center(child: Text('No orders found'));
    }

    return ListView.builder(
      itemCount: orderListState.orders.length,
      padding: const EdgeInsets.all(16),
      itemBuilder: (context, index) {
        final order = orderListState.orders[index];
        return _buildOrderCard(order);
      },
    );
  }

  Widget _buildOrderCard(OrderListModel order) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Order #${order.id}',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                _buildStatusChip(order.status ?? 'unknown'),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              'Date: ${_formatDate(order.dateCreated)}',
              style: const TextStyle(color: Colors.grey, fontSize: 14),
            ),
            const SizedBox(height: 12),
            const Divider(),
            const SizedBox(height: 8),
            ...order.lineItems.map(
              (item) => Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        '${item.name} x${item.quantity}',
                        style: const TextStyle(fontSize: 14),
                      ),
                    ),
                    Text(
                      '${item.total} Ks',
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const Divider(),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Total',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Text(
                  '${order.total} Ks',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusChip(String status) {
    Color backgroundColor;
    Color textColor = Colors.white;

    switch (status.toLowerCase()) {
      case 'pending':
        backgroundColor = Colors.orange;
        break;
      case 'processing':
        backgroundColor = Colors.blue;
        break;
      case 'completed':
        backgroundColor = Colors.green;
        break;
      case 'cancelled':
        backgroundColor = Colors.red;
        break;
      case 'on-hold':
        backgroundColor = Colors.grey;
        break;
      case 'failed':
        backgroundColor = Colors.red.shade900;
        break;
      case 'refunded':
        backgroundColor = Colors.purple;
        break;
      default:
        backgroundColor = Colors.grey;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        status.toUpperCase(),
        style: TextStyle(
          color: textColor,
          fontSize: 12,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  String _formatDate(String dateString) {
    try {
      final date = DateTime.parse(dateString);
      return '${date.day}/${date.month}/${date.year}';
    } catch (e) {
      return dateString;
    }
  }
}
