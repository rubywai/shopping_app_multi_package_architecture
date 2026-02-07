import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:products/src/data/model/product_list_model.dart';
import 'package:products/src/provider/products/product_list_notifier.dart';
import 'package:products/src/provider/products/product_list_state_model.dart';

import '../widgets/product_grid_view.dart';
import 'package:go_router/go_router.dart';

class ProductPage extends ConsumerStatefulWidget {
  const ProductPage({super.key});

  @override
  ConsumerState createState() => _ProductPageState();
}

class _ProductPageState extends ConsumerState<ProductPage> {
  final ProductListProvider _listProvider = ProductListProvider(() {
    return ProductListNotifier();
  });
  final ScrollController _scrollController = ScrollController();
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(_listProvider.notifier).loadProduct();
    });
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent - 200) {
        ref.read(_listProvider.notifier).loadMore();
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ProductListSateModel sateModel = ref.watch(_listProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Ruby Learner Shopping"),
        actions: [
          IconButton(onPressed: (){
            context.push("/search");
          }, icon: const Icon(Icons.search),)
        ],
      ),
      body: switch (sateModel) {
        ProductListLoadingState() => const Center(child: CircularProgressIndicator()),
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
      },
    );
  }
}
