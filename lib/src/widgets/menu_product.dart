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
            Text(widget.product.name, style: TextStyle(fontSize: 18)),
            SizedBox(height: 8),
            if (quantity == 0)
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: widget.activeCategoryColor,
                ),
                onPressed: addToCart,
                child: Text('${widget.product.price} руб'),
              )
            else
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: removeFromCart,
                    icon: Icon(Icons.remove),
                    color: widget.activeCategoryColor,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                    decoration: BoxDecoration(
                      color: widget.activeCategoryColor,
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: Text(
                      quantity.toString(),
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                  IconButton(
                    onPressed: addToCart,
                    icon: Icon(Icons.add),
                    color: widget.activeCategoryColor,
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
