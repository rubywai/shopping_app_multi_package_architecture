import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../providers/product_list/product_state_model.dart';
import '../../providers/product_list/product_state_notifier.dart';
import '../widgets/product_grid_view.dart';

class ProductSearchPage extends ConsumerStatefulWidget {
  const ProductSearchPage({super.key});

  @override
  ConsumerState<ProductSearchPage> createState() => _ProductSearchPageState();
}

class _ProductSearchPageState extends ConsumerState<ProductSearchPage> {
  final TextEditingController _searchController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final ProductStateProvider _productStateProvider = ProductStateProvider(() {
    return ProductStateNotifier();
  });
  String _currentQuery = '';
  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _debounce?.cancel();
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _onSearchChanged() {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      _performSearch(_searchController.text);
    });
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      if (_currentQuery.isNotEmpty) {
        ref.read(_productStateProvider.notifier).loadMoreSearch(_currentQuery);
      }
    }
  }

  Future<void> _performSearch(String query) async {
    setState(() {
      _currentQuery = query;
    });
    await ref.read(_productStateProvider.notifier).searchProducts(query);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: _searchController,
          autofocus: true,
          decoration: InputDecoration(
            hintText: 'Search products...',
            border: InputBorder.none,
            hintStyle: TextStyle(color: Colors.grey[400]),
          ),
          style: const TextStyle(fontSize: 18),
          onSubmitted: _performSearch,
          textInputAction: TextInputAction.search,
        ),
        actions: [
          if (_searchController.text.isNotEmpty)
            IconButton(
              icon: const Icon(Icons.clear),
              onPressed: () {
                _searchController.clear();
                setState(() {
                  _currentQuery = '';
                });
                ref.read(_productStateProvider.notifier).fetchProducts();
              },
            ),
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () => _performSearch(_searchController.text),
          ),
        ],
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    final productState = ref.watch(_productStateProvider);

    if (_currentQuery.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.search, size: 64, color: Colors.grey[400]),
            const SizedBox(height: 16),
            Text(
              'Search for products',
              style: TextStyle(fontSize: 18, color: Colors.grey[600]),
            ),
          ],
        ),
      );
    }

    return switch (productState) {
      ProductStateLoading() => const Center(
          child: CircularProgressIndicator(),
        ),
      ProductStateFailed(:final message) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.error_outline, size: 64, color: Colors.grey[400]),
              const SizedBox(height: 16),
              Text(
                'Search failed',
                style: TextStyle(fontSize: 18, color: Colors.grey[600]),
              ),
              const SizedBox(height: 8),
              Text(
                message,
                style: const TextStyle(fontSize: 14, color: Colors.grey),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ProductStateSuccess(
        products: final products,
        isLoadingMore: final isLoadingMore,
        hasMore: final hasMore
      ) =>
        products.isEmpty
            ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.search_off, size: 64, color: Colors.grey[400]),
                    const SizedBox(height: 16),
                    Text(
                      'No products found for "$_currentQuery"',
                      style: TextStyle(fontSize: 18, color: Colors.grey[600]),
                    ),
                  ],
                ),
              )
            : ProductGridView(
                products: products,
                scrollController: _scrollController,
                isLoadingMore: isLoadingMore,
                hasMore: hasMore,
              )
    };
  }
}
