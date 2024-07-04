import 'package:flutter/material.dart';
import 'package:coffee_shop/src/classes/product.dart';
import 'package:coffee_shop/src/widgets/menu_category.dart';


class MenuScreen extends StatefulWidget {
  @override
  _MenuScreenState createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  final ScrollController _scrollController = ScrollController();
  final ScrollController _categoryScrollController = ScrollController();
  final List<String> categories = ['Черный кофе', 'Кофе с молоком', 'Чай', 'Авторские напитки'];
  int _activeCategoryIndex = 0;
  bool _isProgrammaticScroll = false;

  final List<GlobalKey> _categoryKeys = List.generate(4, (_) => GlobalKey());

  final Map<String, List<Product>> products = {
    'Черный кофе': List.generate(4, (_) => Product(imageUrl: 'assets/images/coffee.png', name: 'Олеато', price: 139)),
    'Кофе с молоком': List.generate(4, (_) => Product(imageUrl: 'assets/images/coffee.png', name: 'Олеато', price: 139)),
    'Чай': List.generate(4, (_) => Product(imageUrl: 'assets/images/coffee.png', name: 'Олеато', price: 139)),
    'Авторские напитки': List.generate(4, (_) => Product(imageUrl: 'assets/images/coffee.png', name: 'Олеато', price: 139)),
  };

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (_isProgrammaticScroll) return;

    for (int i = 0; i < _categoryKeys.length; i++) {
      final context = _categoryKeys[i].currentContext;
      if (context != null) {
        final box = context.findRenderObject() as RenderBox?;
        if (box != null && _isBoxVisible(box)) {
          setState(() {
            _activeCategoryIndex = i;
          });
          _scrollCategoryListToActive();
          break;
        }
      }
    }
  }

  bool _isBoxVisible(RenderBox box) {
    final boxOffset = box.localToGlobal(Offset.zero);
    return boxOffset.dy >= 0 && boxOffset.dy <= MediaQuery.of(context).size.height;
  }

  void _scrollToCategory(int index) async {
    final context = _categoryKeys[index].currentContext;
    if (context != null) {
      setState(() => _isProgrammaticScroll = true);

      await Scrollable.ensureVisible(context, duration: Duration(milliseconds: 300), alignment: 0.1);

      setState(() {
        _isProgrammaticScroll = false;
        _activeCategoryIndex = index;
      });
      _scrollCategoryListToActive();
    }
  }

  void _scrollCategoryListToActive() {
    final categoryWidth = 100.0;
    final offset = _activeCategoryIndex * categoryWidth;

    _categoryScrollController.animateTo(
      offset.clamp(_categoryScrollController.position.minScrollExtent, _categoryScrollController.position.maxScrollExtent),
      duration: Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('CoffeeShop')),
      body: Column(
        children: [
          Container(
            height: 50,
            child: ListView.builder(
              controller: _categoryScrollController,
              scrollDirection: Axis.horizontal,
              itemCount: categories.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () => _scrollToCategory(index),
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    margin: EdgeInsets.symmetric(horizontal: 8),
                    decoration: BoxDecoration(
                      color: _activeCategoryIndex == index ? Colors.blue : Colors.grey[200],
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: Center(
                      child: Text(
                        categories[index],
                        style: TextStyle(color: _activeCategoryIndex == index ? Colors.white : Colors.black),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Expanded(
            child: NotificationListener<ScrollNotification>(
              onNotification: (scrollNotification) {
                _onScroll();
                return true;
              },
              child: SingleChildScrollView(
                controller: _scrollController,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: List.generate(categories.length, (index) {
                      return MenuCategory(
                        title: categories[index],
                        key: _categoryKeys[index],
                        activeCategoryColor: Colors.blue,
                        items: products[categories[index]]!,
                      );
                    }),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
