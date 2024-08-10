import 'package:flutter/material.dart';

class CartItem {
  final String name;
  final int price;
  final String image;
  int quantity;
  bool isVeg ;

  CartItem({
    required this.name,
    required this.price,
    required this.image,
    this.quantity = 1,
    required this.isVeg
  });

  int get subtotal => price * quantity;
}

class CartProvider with ChangeNotifier {
  List<CartItem> _items = [];

  List<CartItem> get items => _items;

  int get totalItems =>
      _items.fold(0, (total, current) => total + current.quantity);

  int get totalPrice =>
      _items.fold(0, (total, current) => total + current.subtotal);

  void addItem(CartItem item) {
    var existingItem = _items.firstWhere((i) => i.name == item.name,
        orElse: () => CartItem(name: '', price: 0, image: '',isVeg: true));
    if (existingItem.name == '') {
      _items.add(item);
    } else {
      existingItem.quantity++;
    }
    notifyListeners();
  }

  void decrementQuantity(CartItem item) {
  if (item.quantity > 1) {
  item.quantity--;
  }
  notifyListeners();
  }
  void incrementQuantity(CartItem item) {
  item.quantity++;
  notifyListeners();
  }

  void removeItem(CartItem item) {
  _items.remove(item);
  notifyListeners();
  }
}
