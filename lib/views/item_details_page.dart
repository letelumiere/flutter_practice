import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_practice/constants.dart';
import 'package:flutter_practice/views/item_basket_page.dart';

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
    return Scaffold(
      appBar: AppBar(title: const Text("제품 상세 페이지"), centerTitle: true),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.all(15),
              child: CachedNetworkImage(
                width: MediaQuery.of(context).size.width*0.8,
                imageUrl: widget.productImageUrl,
                placeholder: (context, url){
                  return const Center(child: CircularProgressIndicator(strokeWidth: 2));
                },
                errorWidget: (context, url, error){
                  return const Center(child: Text("오류 발생"));
                },
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Text("${numberFormat.format(widget.price)}원"),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(20),
        child: FilledButton(
          onPressed: (){
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context){
                return const ItemBasketPage();
              }
            ));
          },
          child: const Text("장바구니 담기"),
        ),
      ),
    );
  }
} 
