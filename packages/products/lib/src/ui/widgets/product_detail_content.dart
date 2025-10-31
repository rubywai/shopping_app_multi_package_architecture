import 'package:flutter/material.dart';
import 'package:cart/cart.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/models/product_detail_model.dart';

class ProductDetailContent extends ConsumerStatefulWidget {
  final ProductDetailModel product;

  const ProductDetailContent({
    super.key,
    required this.product,
  });

  @override
  ConsumerState<ProductDetailContent> createState() =>
      _ProductDetailContentState();
}

class _ProductDetailContentState extends ConsumerState<ProductDetailContent> {
  String? selectedSize;
  int _currentImageIndex = 0;
  final PageController _pageController = PageController();
  final TextEditingController _quantityController =
      TextEditingController(text: '1');
  int _quantity = 1;

  @override
  void dispose() {
    _pageController.dispose();
    _quantityController.dispose();
    super.dispose();
  }

  void _incrementQuantity() {
    setState(() {
      _quantity++;
      _quantityController.text = _quantity.toString();
    });
  }

  void _decrementQuantity() {
    if (_quantity > 1) {
      setState(() {
        _quantity--;
        _quantityController.text = _quantity.toString();
      });
    }
  }

  void _onQuantityChanged(String value) {
    final newQuantity = int.tryParse(value);
    if (newQuantity != null && newQuantity > 0) {
      setState(() {
        _quantity = newQuantity;
      });
    } else {
      // Reset to previous value if invalid
      _quantityController.text = _quantity.toString();
    }
  }

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
          // Product Images Carousel
          if (widget.product.images?.isNotEmpty == true)
            Stack(
              children: [
                SizedBox(
                  height: 400,
                  child: PageView.builder(
                    controller: _pageController,
                    itemCount: widget.product.images!.length,
                    onPageChanged: (index) {
                      setState(() {
                        _currentImageIndex = index;
                      });
                    },
                    itemBuilder: (context, index) {
                      final image = widget.product.images![index];
                      return Image.network(
                        image.src ?? '',
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) =>
                            const Center(
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
                // Image Counter
                if (widget.product.images!.length > 1)
                  Positioned(
                    top: 16,
                    right: 16,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.black54,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        '${_currentImageIndex + 1}/${widget.product.images!.length}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                // Page Indicators (Dots)
                if (widget.product.images!.length > 1)
                  Positioned(
                    bottom: 16,
                    left: 0,
                    right: 0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        widget.product.images!.length,
                        (index) => Container(
                          margin: const EdgeInsets.symmetric(horizontal: 4),
                          width: _currentImageIndex == index ? 24 : 8,
                          height: 8,
                          decoration: BoxDecoration(
                            color: _currentImageIndex == index
                                ? Colors.white
                                : Colors.white54,
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                      ),
                    ),
                  ),
              ],
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

                // Quantity Selector
                Row(
                  children: [
                    const Text(
                      'Quantity:',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(width: 16),
                    // Decrement Button
                    IconButton(
                      onPressed: _decrementQuantity,
                      icon: const Icon(Icons.remove_circle_outline),
                      iconSize: 32,
                      color: Theme.of(context).primaryColor,
                    ),
                    // Quantity Text Field
                    SizedBox(
                      width: 60,
                      child: TextField(
                        controller: _quantityController,
                        keyboardType: TextInputType.number,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 8,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        onChanged: _onQuantityChanged,
                      ),
                    ),
                    // Increment Button
                    IconButton(
                      onPressed: _incrementQuantity,
                      icon: const Icon(Icons.add_circle_outline),
                      iconSize: 32,
                      color: Theme.of(context).primaryColor,
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                // Add to Cart Button with Cart Package Integration
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton.icon(
                    onPressed: () async {
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

                      // Capture ScaffoldMessenger before async gap
                      final messenger = ScaffoldMessenger.of(context);

                      // Get the appropriate variation ID if size is selected
                      // Get the appropriate variation ID if size is selected
                      int? variationId;
                      if (selectedSize != null &&
                          widget.product.variations != null) {
                        // Get the first variation that matches the selected size
                        // In a real app, you'd fetch variation details from the API
                        variationId = widget.product.variations!.isNotEmpty
                            ? widget.product.variations!.first.toInt()
                            : null;
                      }

                      // Create cart item
                      final cartItem = CartItemModel(
                        productId: widget.product.id ?? 0,
                        productName: widget.product.name ?? 'Unknown Product',
                        productImage: widget.product.images?.isNotEmpty == true
                            ? widget.product.images!.first.src ?? ''
                            : '',
                        price:
                            double.tryParse(widget.product.price ?? '0') ?? 0.0,
                        quantity: _quantity,
                        size: selectedSize,
                        variationId: variationId,
                      );

                      try {
                        // Add to cart using the notifier so cart state updates

                        await ref
                            .read(cartStateNotifierProvider.notifier)
                            .addToCart(cartItem);

                        if (!mounted) return;

                        messenger.showSnackBar(
                          SnackBar(
                            content: Text(
                              selectedSize != null
                                  ? 'Added $_quantity x ${widget.product.name} (Size: $selectedSize) to cart'
                                  : 'Added $_quantity x ${widget.product.name} to cart',
                            ),
                            backgroundColor: Colors.green,
                            action: SnackBarAction(
                              label: 'VIEW CART',
                              textColor: Colors.white,
                              onPressed: () {
                                context.go('/cart');
                              },
                            ),
                          ),
                        );

                        // Reset quantity after adding to cart
                        setState(() {
                          _quantity = 1;
                          _quantityController.text = '1';
                        });
                      } catch (e) {
                        if (!mounted) return;

                        messenger.showSnackBar(
                          SnackBar(
                            content: Text('Failed to add to cart: $e'),
                            backgroundColor: Colors.red,
                          ),
                        );
                      }
                    },
                    icon: const Icon(Icons.shopping_cart),
                    label: const Text(
                      'Add to Cart',
                      style: TextStyle(fontSize: 18),
                    ),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 12),
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
