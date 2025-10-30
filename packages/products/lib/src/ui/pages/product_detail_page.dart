import 'package:common/common.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../providers/product_detail/product_detail_notifier.dart';
import '../../providers/product_detail/product_detail_state_model.dart';
import '../widgets/product_detail_content.dart';

class ProductDetailPage extends ConsumerStatefulWidget {
  const ProductDetailPage({
    super.key,
    required this.productId,
  });
  final int productId;

  @override
  ConsumerState<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends ConsumerState<ProductDetailPage> {
  final ProductDetailProvider _productDetailProvider =
      ProductDetailProvider(() {
    return ProductDetailNotifier();
  });

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadProductDetail();
    });
  }

  void _loadProductDetail() {
    ref
        .read(_productDetailProvider.notifier)
        .fetchProductDetail(widget.productId);
  }

  @override
  Widget build(BuildContext context) {
    final productDetailState = ref.watch(_productDetailProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Details'),
      ),
      body: switch (productDetailState) {
        ProductDetailLoading() => const Center(
            child: CircularProgressIndicator(),
          ),
        ProductDetailFailed(:final message) => ErrorRetryWidget(
            message: message,
            onRetry: () {
              _loadProductDetail();
            },
          ),
        ProductDetailSuccess(:final product) => ProductDetailContent(
            product: product,
          ),
      },
    );
  }
}
