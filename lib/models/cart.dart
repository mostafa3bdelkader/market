import 'package:flutter/foundation.dart';

class CartItem {
  final String title;
  final String id;
  final double price;
  final int quantity;
  CartItem(
      {@required this.title,
      @required this.id,
      @required this.price,
      @required this.quantity});
}

class Cart with ChangeNotifier {
  Map<String, CartItem> _cartItems = {};

  Map<String, CartItem> get cartItems {
    return {..._cartItems};
  }

  void addItem(String productId, double price, String title) {
    if (_cartItems.containsKey(productId)) {
      _cartItems.update(
          productId,
          (existingItem) => CartItem(
              title: existingItem.title,
              id: existingItem.id,
              price: existingItem.price,
              quantity: 1));
    } else {
      _cartItems.putIfAbsent(
          productId,
          () => CartItem(
              title: title,
              price: price,
              quantity: 1,
              id: DateTime.now().toString()));
    }
    notifyListeners();
  }

  void removeSingleItem(String productId) {
    if (!_cartItems.containsKey(productId)) {
      return;
    }
    if (_cartItems[productId].quantity > 1) {
      _cartItems.update(
          productId,
          (existingCartItem) => CartItem(
              title: existingCartItem.title,
              id: existingCartItem.id,
              price: existingCartItem.price,
              quantity: existingCartItem.quantity - 1));
    } else {
      _cartItems.remove(productId);
    }
  }

  int get itemsCount {
    return _cartItems.length;
  }

  double get totalAmount {
    var total = 0.0;
    _cartItems.forEach((key, cartItem) {
      total += cartItem.price * cartItem.quantity;
    });
    return total;
  }

  void deleteItem(String productId) {
    _cartItems.remove(productId);
    notifyListeners();
  }

  void clear() {
    _cartItems = {};
    notifyListeners();
  }
}
