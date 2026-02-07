import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:products/src/provider/category/category_state_model.dart';

import '../../data/model/category_model.dart';
import '../../provider/category/category_state_notifier.dart';

class CategoryPage extends ConsumerStatefulWidget {
  const CategoryPage({super.key});

  @override
  ConsumerState<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends ConsumerState<CategoryPage> {
  final CategoryStateProvider _categoryProvider = CategoryStateProvider(() {
    return CategoryStateNotifier();
  });
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(_categoryProvider.notifier).getCategoryList();
    });
  }
  @override
  Widget build(BuildContext context) {
    final CategoryStateModel stateModel = ref.watch(_categoryProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Categories"),
      ),
      body:  switch(stateModel){

        CategoryStateLoading() => const Center(child: CircularProgressIndicator(),),
        CategoryStateSuccess(categories : List<CategoryModel> categories) => _categoryList(categories),
        CategoryStateFail() =>  const Center(child: Text("Failed")),
      },
    );
  }
  Widget _categoryList(List<CategoryModel> categories){
    return ListView.builder(
        itemCount: categories.length,
        itemBuilder: (context,index){
          CategoryModel model = categories[index];
          return Card(
            elevation: 0,
            child: ListTile(
              trailing: Text(model.count?.toString() ?? '0'),
              title: Text(model.name ?? ""),
              leading: const Icon(Icons.category),
              onTap: (){

              },
            ),
          );
        });
  }
}
