import 'package:flutter/material.dart';

import '../../data/model/product_list_model.dart';

class ProductGridView extends StatelessWidget {
  const ProductGridView({super.key, required this.products});

  final List<ProductListModel> products;

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverPadding(
          padding: EdgeInsets.all(8.0),
          sliver: SliverGrid(
            delegate: SliverChildBuilderDelegate((context, index) {
              ProductListModel product = products[index];
              List<Images> images = product.images ?? [];
              String? imageLink = images.isNotEmpty ? images[0].src : null;
              return Card(
                elevation: 2.0,
                child: Column(
                  children: [
                    Expanded(
                      child: imageLink != null
                          ? Image.network(imageLink)
                          : Icon(Icons.shopping_bag),
                    ),
                    SizedBox(height: 4),
                    Text(
                      product.name ?? "",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 4),
                    Text(
                      product.price ?? "",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              );
            }, childCount: products.length),
            gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 200,
              crossAxisSpacing: 8.0,
              mainAxisSpacing: 8.0,
              childAspectRatio: 0.65,
            ),
          ),
        ),
      ],
    );
  }
}
