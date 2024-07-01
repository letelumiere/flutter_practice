
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_practice/models/product.dart';
import 'package:flutter_practice/services/cart_services.dart';

class CartViewModel extends ChangeNotifier{
  final CartService cartService;

  Map<String, dynamic> _cartMap = {};
  Map<String, dynamic> get cartMap => _cartMap;

  List<int> _keyList = [];
  List<int> get keyList => _keyList;

  Stream<QuerySnapshot<Product>>? _productList;
  Stream<QuerySnapshot<Product>>? get productList => _productList;

  CartViewModel({required this.cartService}){
    _initializeCart();
  }

  void _initializeCart(){
    _cartMap = cartService.getCartMap();
    _keyList = cartService.getKeyList(_cartMap);
    final productListRef = cartService.getProductListRef(_keyList);
    _productList = cartService.getProductListStream(productListRef);
    notifyListeners();
  }

  void updateQuantity(String productNo, int quantity){
    cartService.updateCartMap(productNo, quantity);
    _initializeCart();
  }

  void removeFromCart(String productNo){
    cartService.removeFromCart(productNo);
    _initializeCart();
  }
}