import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class CartItem {
  final productId;
  final String name;
  final itemId;
  final int price;
  final category;
  final seller;
  final description;
  final String image;
  int quantity;
  final available;
  final createdAt;
  final updatedAt;
  final version;
  bool isVeg;
  final data;

  CartItem({
    required this.productId,
    required this.name,
    required this.itemId,
    required this.price,
    required this.category,
    required this.seller,
    required this.description,
    required this.image,
    required this.available,
    required this.updatedAt,
    required this.createdAt,
    required this. version,
    this.quantity = 1,
    required this.isVeg,
    required this.data,
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
        orElse: () => CartItem(
            name: '',
            price: 0,
            image: '',
            isVeg: true,
            data: {},
            seller: '',
            productId: '', itemId: '', category: '', description: '', available: true, updatedAt: '',createdAt: '', version: 0));
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
