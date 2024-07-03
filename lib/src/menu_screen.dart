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

  final List<GlobalKey> _categoryKeys = [
    GlobalKey(),
    GlobalKey(),
    GlobalKey(),
    GlobalKey(),
  ];

  final Map<String, List<Product>> products = {
  'Черный кофе': [
    Product(
        imageUrl: 'assets/images/coffee.png',
        name: 'Олеато',
        price: 139),
    Product(
        imageUrl: 'assets/images/coffee.png',
        name: 'Олеато',
        price: 139),
    Product(
        imageUrl: 'assets/images/coffee.png',
        name: 'Олеато',
        price: 139),
    Product(
        imageUrl: 'assets/images/coffee.png',
        name: 'Олеато',
        price: 139),
  ],
  'Кофе с молоком': [
    Product(
        imageUrl: 'assets/images/coffee.png',
        name: 'Олеато',
        price: 139),
    Product(
        imageUrl: 'assets/images/coffee.png',
        name: 'Олеато',
        price: 139),
    Product(
        imageUrl: 'assets/images/coffee.png',
        name: 'Олеато',
        price: 139),
    Product(
        imageUrl: 'assets/images/coffee.png',
        name: 'Олеато',
        price: 139),
  ],
  'Чай': [
    Product(
        imageUrl: 'assets/images/coffee.png',
        name: 'Олеато',
        price: 139),
    Product(
        imageUrl: 'assets/images/coffee.png',
        name: 'Олеато',
        price: 139),
    Product(
        imageUrl: 'assets/images/coffee.png',
        name: 'Олеато',
        price: 139),
    Product(
        imageUrl: 'assets/images/coffee.png',
        name: 'Олеато',
        price: 139),
  ],
  'Авторские напитки': [
    Product(
        imageUrl: 'assets/images/coffee.png',
        name: 'Олеато',
        price: 139),
    Product(
        imageUrl: 'assets/images/coffee.png',
        name: 'Олеато',
        price: 139),
    Product(
        imageUrl: 'assets/images/coffee.png',
        name: 'Олеато',
        price: 139),
    Product(
        imageUrl: 'assets/images/coffee.png',
        name: 'Олеато',
        price: 139),
  ],
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
    final screenHeight = MediaQuery.of(context).size.height;
    return boxOffset.dy >= 0 && boxOffset.dy <= screenHeight;
  }

  void _scrollToCategory(int index) async {
    final context = _categoryKeys[index].currentContext;
    if (context != null) {
      setState(() {
        _isProgrammaticScroll = true;
      });

      await Scrollable.ensureVisible(
        context,
        duration: Duration(milliseconds: 300),
        alignment: 0.1,
      );

      setState(() {
        _isProgrammaticScroll = false;
        _activeCategoryIndex = index;
      });
      _scrollCategoryListToActive();
    }
  }

  void _scrollCategoryListToActive() {
    final categoryWidth = 100.0;
    final screenWidth = MediaQuery.of(context).size.width;
    final offset = (_activeCategoryIndex * categoryWidth) - (screenWidth / 2) + (categoryWidth / 2);

    final maxScrollExtent = _categoryScrollController.position.maxScrollExtent;
    final minScrollExtent = _categoryScrollController.position.minScrollExtent;
    final newOffset = offset.clamp(minScrollExtent, maxScrollExtent);

    _categoryScrollController.animateTo(
      newOffset,
      duration: Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('CoffeeShop'),
      ),
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
                  onTap: () {
                    _scrollToCategory(index);
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Chip(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                      label: Text(
                        categories[index],
                        style: TextStyle(
                          color: _activeCategoryIndex == index
                              ? Colors.white
                              : Colors.black,
                        ),
                      ),
                      backgroundColor: _activeCategoryIndex == index
                          ? Colors.blue
                          : Colors.white,
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
                    children: [
                      MenuCategory(
                        title: 'Черный кофе', 
                        key: _categoryKeys[0], 
                        activeCategoryColor: Colors.blue,
                        items: products['Черный кофе']!, 
                      ),
                      MenuCategory(
                        title: 'Кофе с молоком', 
                        key: _categoryKeys[1], 
                        activeCategoryColor: Colors.blue,
                        items: products['Кофе с молоком']!, 
                      ),
                      MenuCategory(
                        title: 'Чай', 
                        key: _categoryKeys[2], 
                        activeCategoryColor: Colors.blue,
                        items: products['Чай']!, 
                      ),
                      MenuCategory(
                        title: 'Авторские напитки', 
                        key: _categoryKeys[3], 
                        activeCategoryColor: Colors.blue,
                        items: products['Авторские напитки']!, 
                      ),
                    ],
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
