import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_practice/constants.dart';
import 'package:flutter_practice/models/product.dart';
import 'package:flutter_practice/views/item_list_page.dart';

class CheckoutButton extends StatelessWidget {
  final Map<String, dynamic> cartMap;
  final Stream<QuerySnapshot<Product>>? productList;

  const CheckoutButton({
    Key? key,
    required this.cartMap,
    required this.productList,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double totalPrice = 0;

    return StreamBuilder(
      stream: productList,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          snapshot.data?.docs.forEach((document) {
            final product = document.data();
            if (cartMap[product.productNo.toString()] != null) {
              totalPrice +=
                  cartMap[product.productNo.toString()] * product.price;
            }
          });

          return Padding(
            padding: const EdgeInsets.all(20),
            child: FilledButton(
              onPressed: () {
                //! 결제 시작 페이지로 이동
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) {
                    return const ItemListPage();
                  },
                ));
              },
              child: Text("총 ${numberFormat.format(totalPrice)}원 결제하기"),
            ),
          );
        } else if (snapshot.hasError) {
          return const Center(
            child: Text("오류가 발생 했습니다."),
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(
              strokeWidth: 2,
            ),
          );
        }
      },
    );
  }
}
