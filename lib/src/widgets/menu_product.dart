import 'package:flutter/material.dart';
import 'package:coffee_shop/src/classes/product.dart';

class MenuItem extends StatefulWidget {
  final Color activeCategoryColor;
  final Product product;

  MenuItem({required this.activeCategoryColor, required this.product});

  @override
  _MenuItemState createState() => _MenuItemState();
}

class _MenuItemState extends State<MenuItem> {
  int quantity = 0;

  void addToCart() {
    setState(() {
      if (quantity < 10) quantity++;
    });
  }

  void removeFromCart() {
    setState(() {
      if (quantity > 0) quantity--;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      margin: EdgeInsets.symmetric(horizontal: 8),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.network(
              widget.product.imageUrl,
              height: 100,
              fit: BoxFit.cover,
            ),
            SizedBox(height: 16),
            Text(
              widget.product.name,
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 8),
            Container(
              height: 50, 
              child: AnimatedSwitcher(
                duration: Duration(milliseconds: 300),
                child: quantity == 0
                    ? ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: widget.activeCategoryColor,
                          minimumSize: Size(double.infinity, 40), 
                        ),
                        onPressed: addToCart,
                        child: Text('${widget.product.price} руб'),
                      )
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Flexible(
                            child: Container(
                              width: 40,
                              height: 40, 
                              decoration: BoxDecoration(
                                color: Colors.blue,
                                shape: BoxShape.circle,
                              ),
                              child: IconButton(
                                onPressed: removeFromCart,
                                icon: Icon(Icons.remove),
                                color: Colors.white,
                              ),
                            ),
                          ),
                          SizedBox(width: 10), 
                          Flexible(
                            child: Container(
                              padding: EdgeInsets.symmetric(vertical: 8),
                              decoration: BoxDecoration(
                                color: widget.activeCategoryColor,
                                borderRadius: BorderRadius.circular(25),
                              ),
                              child: Center(
                                child: Text(
                                  quantity.toString(),
                                  style: TextStyle(color: Colors.white, fontSize: 16),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 10), 
                          Flexible(
                            child: Container(
                              width: 40, 
                              height: 40, 
                              decoration: BoxDecoration(
                                color: Colors.blue,
                                shape: BoxShape.circle,
                              ),
                              child: IconButton(
                                onPressed: addToCart,
                                icon: Icon(Icons.add),
                                color: Colors.white,
                              ),
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
