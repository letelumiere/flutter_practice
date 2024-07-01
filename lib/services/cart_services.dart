
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/product.dart';

class CartService{
  final FirebaseFirestore database = FirebaseFirestore.instance;
  final SharedPreferences sharedPreferences;

  CartService({required this.sharedPreferences});

  Map<String, dynamic> getCartMap(){
    try{
      return json.decode(sharedPreferences.getString("cartMap") ?? "{}") ?? {};
    }catch(e){
      debugPrint(e.toString());
      return {};
    }
  }

  List<int> getKeyList(Map<String, dynamic> cartMap){
    return cartMap.keys.map((key) => int.parse(key)).toList();
  }

  Query<Product>? getProductListRef(List<int> keyList){
    if(keyList.isNotEmpty){
      return database.collection("products").withConverter(
        fromFirestore: (snapshot, _) => Product.fromJson(snapshot.data()!), 
        toFirestore: (product, _) => product.toJson(),
      ).where("productNo", whereIn: keyList);
    }
    return null;
  }

  Stream<QuerySnapshot<Product>>? getProductListStream(Query<Product>? productListRef){
    return productListRef?.orderBy("productNo").snapshots();
  }

  void updateCartMap(String productNo, int quantity){
    final cartMap = getCartMap();
    cartMap[productNo] = quantity;
    sharedPreferences.setString("cartMap", json.encode(cartMap)); 
  }

  void removeFromCart(String productNo){
    final cartMap = getCartMap();
    cartMap.remove(productNo);
    sharedPreferences.setString("cartMap", json.encode(cartMap));
  }
}

