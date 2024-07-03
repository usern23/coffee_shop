import 'package:flutter/material.dart';
import 'package:coffee_shop/src/classes/product.dart';
import 'package:coffee_shop/src/widgets/menu_product.dart';

class MenuCategory extends StatelessWidget {
  final String title;
  final List<Product> items;
  final Color activeCategoryColor;

  MenuCategory({
    required this.title,
    required this.items,
    required Key key,
    required this.activeCategoryColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 8,
              mainAxisSpacing: 16,
              childAspectRatio: 0.75,
            ),
            itemCount: items.length, 
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return MenuItem(
                activeCategoryColor: activeCategoryColor,
                product: items[index], 
              );
            },
          ),
        ],
      ),
    );
  }
}
