import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_practice/models/product.dart';
import 'package:flutter_practice/services/cart_services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../constants.dart';

class ItemBasketPage extends StatefulWidget {
  const ItemBasketPage({super.key});

  @override
  State<ItemBasketPage> createState() => _ItemBasketPageState();
}

class _ItemBasketPageState extends State<ItemBasketPage> {
  late CartService cartService;
  Map<String, dynamic> cartMap = {};
  List<int> keyList = [];
  Stream<QuerySnapshot<Product>>? productList;

  @override
  void initState() {
    super.initState();
    _initializeCartService();
  }

  Future<void> _initializeCartService() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    cartService = CartService(sharedPreferences: sharedPreferences);

    setState(() {
      cartMap = cartService.getCartMap();
      keyList = cartService.getKeyList(cartMap);
      final productListRef = cartService.getProductListRef(keyList);
      productList = cartService.getProductListStream(productListRef);
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("임시 창")),

    );
  }
  }

