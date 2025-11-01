import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../data/models/product_list_model.dart';

class ProductGridView extends StatelessWidget {
  const ProductGridView({
    super.key,
    required this.products,
    required this.scrollController,
    this.isLoadingMore = false,
    this.hasMore = true,
  });

  final List<ProductListModel> products;
  final ScrollController scrollController;
  final bool isLoadingMore;
  final bool hasMore;

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      controller: scrollController,
      slivers: [
        SliverPadding(
          padding: const EdgeInsets.all(8),
          sliver: SliverGrid(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
              childAspectRatio: 0.65,
            ),
            delegate: SliverChildBuilderDelegate(
              (context, index) => _buildProductCard(context, products[index]),
              childCount: products.length,
            ),
          ),
        ),
        // Loading indicator at bottom
        if (isLoadingMore)
          const SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Center(
                child: CircularProgressIndicator(),
              ),
            ),
          ),
        // No more items indicator
        if (!hasMore && products.isNotEmpty)
          const SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Center(
                child: Text(
                  'No more products',
                  style: TextStyle(color: Colors.grey),
                ),
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildProductCard(BuildContext context, ProductListModel product) {
    final imageUrl =
        product.images?.isNotEmpty == true ? product.images!.first.src : null;

    return Card(
      elevation: 2,
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () {
          // Navigate to product detail page using GoRouter
          if (product.id != null) {
            context.push('/product/${product.id!.toInt()}');
          }
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Product Image - Fixed height
            SizedBox(
              height: 200,
              width: double.infinity,
              child: Container(
                color: Colors.grey[200],
                child: imageUrl != null
                    ? Image.network(
                        imageUrl,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) =>
                            const Center(
                          child: Icon(
                            Icons.image_not_supported,
                            size: 50,
                            color: Colors.grey,
                          ),
                        ),
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) return child;
                          return Center(
                            child: CircularProgressIndicator(
                              value: loadingProgress.expectedTotalBytes != null
                                  ? loadingProgress.cumulativeBytesLoaded /
                                      loadingProgress.expectedTotalBytes!
                                  : null,
                            ),
                          );
                        },
                      )
                    : const Center(
                        child: Icon(
                          Icons.shopping_bag,
                          size: 50,
                          color: Colors.grey,
                        ),
                      ),
              ),
            ),
            // Product Details - Fixed height
            SizedBox(
              height: 80,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Product Name - Fixed 2 lines
                    Text(
                      product.name ?? 'No Name',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        height: 1.2,
                      ),
                    ),
                    // Product Price
                    Text(
                      '${product.price ?? '0'} Ks',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
