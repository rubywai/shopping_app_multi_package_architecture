import 'package:common/common.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../providers/product_detail_notifier.dart';
import '../../providers/product_detail_state_model.dart';
import '../widgets/product_detail_content.dart';

class ProductDetailPage extends ConsumerWidget {
  final int productId;

  const ProductDetailPage({
    super.key,
    required this.productId,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final productDetailState = ref.watch(productDetailProvider(productId));

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
              ref.invalidate(productDetailProvider(productId));
            },
          ),
        ProductDetailSuccess(:final product) => ProductDetailContent(
            product: product,
          ),
      },
    );
  }
}
