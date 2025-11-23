import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:products/src/data/model/product_list_model.dart';
import 'package:products/src/provider/product_list_notifier.dart';
import 'package:products/src/provider/product_list_state_model.dart';

import '../widgets/product_grid_view.dart';

class ProductPage extends ConsumerStatefulWidget {
  const ProductPage({super.key});

  @override
  ConsumerState createState() => _ProductPageState();
}

class _ProductPageState extends ConsumerState<ProductPage> {
  final ProductListProvider _listProvider = ProductListProvider(() {
    return ProductListNotifier();
  });
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(_listProvider.notifier).loadProduct();
    });
  }

  @override
  Widget build(BuildContext context) {
    ProductListSateModel sateModel = ref.watch(_listProvider);
    return switch (sateModel) {
      ProductListLoadingState() => Center(child: CircularProgressIndicator()),
      ProductListSuccessState(products: List<ProductListModel> products) =>
        ProductGridView(products: products),
      ProductListFailState() => Center(child: Text("Failed")),
    };
  }
}
