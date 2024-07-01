import 'package:flutter/material.dart';

class ItemDetailsPage extends StatefulWidget {
  int productNo;
  String productName;
  String productImageUrl;
  double price;
  
  ItemDetailsPage({
    super.key,
    required this.productNo,
    required this.productName,
    required this.productImageUrl,
    required this.price
  });

  @override
  State<ItemDetailsPage> createState() => _ItemDetailsPageState();
}

class _ItemDetailsPageState extends State<ItemDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}