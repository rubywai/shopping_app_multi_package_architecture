import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/model/product_list_model.dart';
import '../../provider/products/product_list_notifier.dart';
import '../../provider/products/product_list_state_model.dart';
import '../widgets/product_grid_view.dart';

class ProductSearchPage extends ConsumerStatefulWidget {
  const ProductSearchPage({super.key});

  @override
  ConsumerState<ProductSearchPage> createState() => _ProductSearchPageState();
}

class _ProductSearchPageState extends ConsumerState<ProductSearchPage> {
  final ProductListProvider _listProvider = ProductListProvider(() {
    return ProductListNotifier();
  });
  final ScrollController _scrollController = ScrollController();
  String? _keyword;
  Timer? _debouncer;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent - 200) {
        if (_keyword != null && _keyword!.trim().isNotEmpty) {
          ref.read(_listProvider.notifier).loadMore(search: _keyword);
        }
      }
    });
    _searchController.addListener(() {
      _searchProduct(_searchController.text);
    });
  }

  @override
  Widget build(BuildContext context) {
    ProductListSateModel sateModel = ref.watch(_listProvider);
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: _searchController,
          decoration: InputDecoration(
            labelText: "Search product",
            isDense: true,
            border: const OutlineInputBorder(),
            suffixIcon: IconButton(
              onPressed: _searchController.text.isNotEmpty
                  ? () {
                      _searchController.clear();
                    }
                  : null,
              icon: _searchController.text.isEmpty
                  ? const Icon(Icons.search)
                  : const Icon(Icons.clear),
            ),
          ),
        ),
        centerTitle: true,
      ),
      body: _keyword?.isNotEmpty == true
          ? switch (sateModel) {
            ProductListLoadingState() => const Center(
              child: CircularProgressIndicator(),
            ),
            ProductListSuccessState(
              products: List<ProductListModel> products,
              isLoadingMore: bool isLoadingMore,
              hasMore: bool hasMore,
            ) =>
              ProductGridView(
                products: products,
                controller: _scrollController,
                hasMore: hasMore,
                isLoadingMore: isLoadingMore,
              ),
            ProductListFailState() => const Center(child: Text("Failed")),
          }
          : const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.search, size: 32),
                  SizedBox(height: 8.0),
                  Text("Search product"),
                ],
              ),
            ),
    );
  }

  void _searchProduct(String? keyword) {
    if (_keyword?.isNotEmpty == true && keyword?.isEmpty == true) {
      setState(() {
        _keyword = keyword;
      });
    } else {
      _keyword = keyword;
    }
    if (keyword != null && keyword.trim().isNotEmpty) {
      if (_debouncer?.isActive == true) {
        _debouncer?.cancel();
      }
      _debouncer = Timer(const Duration(milliseconds: 500), () {
        ref.read(_listProvider.notifier).loadProduct(search: keyword);
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
    _searchController.dispose();
    if (_debouncer != null) {
      _debouncer?.cancel();
    }
  }
}
