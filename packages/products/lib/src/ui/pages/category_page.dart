import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:common/common.dart';

import '../../providers/category/category_state_model.dart';
import '../../providers/category/category_state_notifier.dart';
import '../../data/models/category_model.dart';

class CategoryPage extends ConsumerStatefulWidget {
  const CategoryPage({super.key});

  @override
  ConsumerState createState() => _CategoryPageState();
}

class _CategoryPageState extends ConsumerState<CategoryPage> {
  final CategoryStateProvider _categoryStateProvider =
      CategoryStateProvider(() {
    return CategoryStateNotifier();
  });

  @override
  void initState() {
    super.initState();
    _loadCategories();
  }

  void _loadCategories() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(_categoryStateProvider.notifier).fetchCategories();
    });
  }

  @override
  Widget build(BuildContext context) {
    final categoryState = ref.watch(_categoryStateProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Categories"),
      ),
      body: switch (categoryState) {
        CategoryStateLoading() => const Center(
            child: CircularProgressIndicator(),
          ),
        CategoryStateFailed(:final message) => ErrorRetryWidget(
            message: message,
            onRetry: _loadCategories,
          ),
        CategoryStateSuccess(:final categories) => categories.isEmpty
            ? const Center(
                child: Text("No categories found"),
              )
            : ListView.builder(
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  return _buildCategoryItem(categories[index]);
                },
              ),
      },
    );
  }

  Widget _buildCategoryItem(CategoryModel category) {
    return Card(
      child: ListTile(
        leading: const Icon(Icons.category),
        title: Text(category.name ?? 'No Name'),
        trailing: Text(
          '${category.count ?? 0} products',
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey[600],
          ),
        ),
        onTap: () {
          if (category.id != null) {
            context.go(
                '/category/${category.id}?name=${Uri.encodeComponent(category.name ?? 'Category')}');
          }
        },
      ),
    );
  }
}
