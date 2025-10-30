import 'package:flutter/material.dart';

import '../../data/models/product_model.dart';

class ProductDetailContent extends StatefulWidget {
  final ProductModel product;

  const ProductDetailContent({
    super.key,
    required this.product,
  });

  @override
  State<ProductDetailContent> createState() => _ProductDetailContentState();
}

class _ProductDetailContentState extends State<ProductDetailContent> {
  String? selectedSize;

  List<String> _getSizesFromProduct() {
    // Find the Size attribute in the product attributes
    if (widget.product.attributes == null) return [];

    for (var attribute in widget.product.attributes!) {
      if (attribute.name?.toLowerCase() == 'size' &&
          attribute.variation == true) {
        return List<String>.from(attribute.options ?? []);
      }
    }
    return [];
  }

  String _stripHtmlTags(String htmlText) {
    final RegExp exp = RegExp(r'<[^>]*>', multiLine: true, caseSensitive: true);
    return htmlText.replaceAll(exp, '').replaceAll('&nbsp;', ' ').trim();
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              label,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[700],
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Product Images
          if (widget.product.images?.isNotEmpty == true)
            SizedBox(
              height: 400,
              child: PageView.builder(
                itemCount: widget.product.images!.length,
                itemBuilder: (context, index) {
                  final image = widget.product.images![index];
                  return Image.network(
                    image.src ?? '',
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => const Center(
                      child: Icon(
                        Icons.image_not_supported,
                        size: 100,
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
                  );
                },
              ),
            ),

          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Product Name
                Text(
                  widget.product.name ?? 'No Name',
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),

                // Product Price
                Row(
                  children: [
                    if (widget.product.onSale == true &&
                        widget.product.regularPrice != null &&
                        widget.product.regularPrice!.isNotEmpty) ...[
                      Text(
                        '\$${widget.product.regularPrice}',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.grey[600],
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),
                      const SizedBox(width: 8),
                    ],
                    Text(
                      '\$${widget.product.price ?? '0'}',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: widget.product.onSale == true
                            ? Colors.red
                            : Theme.of(context).primaryColor,
                      ),
                    ),
                    if (widget.product.onSale == true) ...[
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: const Text(
                          'SALE',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
                const SizedBox(height: 8),

                // SKU
                if (widget.product.sku != null &&
                    widget.product.sku!.isNotEmpty)
                  Text(
                    'SKU: ${widget.product.sku}',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                    ),
                  ),
                const SizedBox(height: 16),

                // Rating
                if (widget.product.averageRating != null &&
                    widget.product.averageRating != '0.00')
                  Row(
                    children: [
                      Row(
                        children: List.generate(5, (index) {
                          final rating =
                              double.tryParse(widget.product.averageRating!) ??
                                  0.0;
                          return Icon(
                            index < rating.floor()
                                ? Icons.star
                                : (index < rating
                                    ? Icons.star_half
                                    : Icons.star_border),
                            color: Colors.amber,
                            size: 20,
                          );
                        }),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        '${widget.product.averageRating} (${widget.product.ratingCount ?? 0} reviews)',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[700],
                        ),
                      ),
                    ],
                  ),
                const SizedBox(height: 16),

                // Categories
                if (widget.product.categories?.isNotEmpty == true)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Categories',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: widget.product.categories!.map((category) {
                          return Chip(
                            label: Text(
                              category.name ?? '',
                              style: const TextStyle(fontSize: 12),
                            ),
                            backgroundColor: Colors.grey[200],
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                          );
                        }).toList(),
                      ),
                      const SizedBox(height: 16),
                    ],
                  ),

                // Short Description
                if (widget.product.shortDescription != null &&
                    widget.product.shortDescription!.isNotEmpty)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _stripHtmlTags(widget.product.shortDescription!),
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey[700],
                          height: 1.5,
                        ),
                      ),
                      const SizedBox(height: 16),
                    ],
                  ),

                // Product Description
                if (widget.product.description != null &&
                    widget.product.description!.isNotEmpty)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Description',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        _stripHtmlTags(widget.product.description!),
                        style: const TextStyle(
                          fontSize: 16,
                          height: 1.5,
                        ),
                      ),
                    ],
                  ),
                const SizedBox(height: 16),

                // Size Selector (only show if product has size variations)
                if (_getSizesFromProduct().isNotEmpty) ...[
                  const Text(
                    'Select Size',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Wrap(
                    spacing: 12,
                    runSpacing: 12,
                    children: _getSizesFromProduct().map((size) {
                      final isSelected = selectedSize == size;
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedSize = size;
                          });
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 12,
                          ),
                          decoration: BoxDecoration(
                            color: isSelected
                                ? Theme.of(context).primaryColor
                                : Colors.grey[200],
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color: isSelected
                                  ? Theme.of(context).primaryColor
                                  : Colors.grey[400]!,
                              width: 2,
                            ),
                          ),
                          child: Text(
                            size,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: isSelected ? Colors.white : Colors.black87,
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 16),
                ],

                // Product Specifications
                const Divider(height: 32),
                const Text(
                  'Product Specifications',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 12),

                // Weight
                if (widget.product.weight != null &&
                    widget.product.weight!.isNotEmpty)
                  _buildInfoRow('Weight', '${widget.product.weight} kg'),

                // Dimensions
                if (widget.product.dimensions != null)
                  _buildInfoRow(
                    'Dimensions',
                    '${widget.product.dimensions!.length ?? '-'} x ${widget.product.dimensions!.width ?? '-'} x ${widget.product.dimensions!.height ?? '-'} cm',
                  ),

                // Type
                if (widget.product.type != null)
                  _buildInfoRow(
                    'Product Type',
                    widget.product.type!.toUpperCase(),
                  ),

                // Total Sales
                if (widget.product.totalSales != null &&
                    widget.product.totalSales! > 0)
                  _buildInfoRow(
                    'Total Sales',
                    '${widget.product.totalSales} sold',
                  ),

                const SizedBox(height: 16),

                // Tags
                if (widget.product.tags?.isNotEmpty == true)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Tags',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: widget.product.tags!.map((tag) {
                          return Chip(
                            label: Text(
                              tag.name ?? '',
                              style: const TextStyle(fontSize: 12),
                            ),
                            backgroundColor: Colors.blue[50],
                            side: BorderSide(color: Colors.blue[200]!),
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                          );
                        }).toList(),
                      ),
                      const SizedBox(height: 16),
                    ],
                  ),

                const Divider(height: 32),

                // Product Stock Status
                if (widget.product.stockStatus != null)
                  Row(
                    children: [
                      const Text(
                        'Stock Status: ',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        widget.product.stockStatus!,
                        style: TextStyle(
                          fontSize: 16,
                          color: widget.product.stockStatus == 'instock'
                              ? Colors.green
                              : Colors.red,
                        ),
                      ),
                    ],
                  ),

                // Shipping Information
                if (widget.product.shippingRequired == true)
                  Container(
                    margin: const EdgeInsets.only(top: 16),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.blue[50],
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.blue[200]!),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.local_shipping,
                          color: Colors.blue[700],
                          size: 20,
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            widget.product.shippingClass?.isNotEmpty == true
                                ? 'Shipping Class: ${widget.product.shippingClass}'
                                : 'Shipping available',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.blue[900],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                // Reviews Info
                if (widget.product.reviewsAllowed == true)
                  Container(
                    margin: const EdgeInsets.only(top: 12),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.green[50],
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.green[200]!),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.rate_review,
                          color: Colors.green[700],
                          size: 20,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'Customer reviews are enabled',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.green[900],
                          ),
                        ),
                      ],
                    ),
                  ),

                const SizedBox(height: 24),

                // Add to Cart Button
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      final availableSizes = _getSizesFromProduct();

                      // Only validate size if product has size variations
                      if (availableSizes.isNotEmpty && selectedSize == null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Please select a size'),
                            backgroundColor: Colors.orange,
                          ),
                        );
                        return;
                      }

                      // TODO: Add to cart functionality
                      final message = selectedSize != null
                          ? '${widget.product.name} (Size: $selectedSize) added to cart'
                          : '${widget.product.name} added to cart';

                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(message),
                          backgroundColor: Colors.green,
                        ),
                      );
                    },
                    child: const Text(
                      'Add to Cart',
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
