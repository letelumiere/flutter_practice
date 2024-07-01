import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_practice/constants.dart';
import 'package:flutter_practice/models/product.dart';
import 'package:flutter_practice/services/cart_services.dart';

class BasketList extends StatelessWidget {
  final Map<String, dynamic> cartMap;
  final Stream<QuerySnapshot<Product>>? productList;
  final CartService cartService;

  const BasketList({
    Key? key,
    required this.cartMap,
    required this.productList,
    required this.cartService,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: productList,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return ListView(
            children: snapshot.data!.docs.map((document) {
              if (cartMap[document.data().productNo.toString()] != null) {
                return BasketItem(
                  productNo: document.data().productNo ?? 0,
                  productName: document.data().productName ?? "",
                  productImageUrl: document.data().productImageUrl ?? "",
                  price: document.data().price ?? 0,
                  quantity: cartMap[document.data().productNo.toString()],
                  cartService: cartService,
                );
              }
              return Container();
            }).toList(),
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

class BasketItem extends StatelessWidget {
  final int productNo;
  final String productName;
  final String productImageUrl;
  final double price;
  final int quantity;
  final CartService cartService;

  const BasketItem({
    Key? key,
    required this.productNo,
    required this.productName,
    required this.productImageUrl,
    required this.price,
    required this.quantity,
    required this.cartService,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CachedNetworkImage(
            width: MediaQuery.of(context).size.width * 0.3,
            height: 130,
            fit: BoxFit.cover,
            imageUrl: productImageUrl,
            placeholder: (context, url) {
              return const Center(
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                ),
              );
            },
            errorWidget: (context, url, error) {
              return const Center(
                child: Text("오류 발생"),
              );
            },
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  productName,
                  textScaleFactor: 1.2,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text("${numberFormat.format(price)}원"),
                Row(
                  children: [
                    const Text("수량:"),
                    IconButton(
                      onPressed: () {
                        //! 수량 줄이기 (1 초과시에만 감소시킬 수 있음)
                        if (quantity > 1) {
                          cartService.updateCartMap(productNo.toString(), quantity - 1);
                        }
                      },
                      icon: const Icon(
                        Icons.remove,
                      ),
                    ),
                    Text("$quantity"),
                    IconButton(
                      onPressed: () {
                        cartService.updateCartMap(productNo.toString(), quantity + 1);
                      },
                      icon: const Icon(
                        Icons.add,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        cartService.removeFromCart(productNo.toString());
                      },
                      icon: const Icon(
                        Icons.delete,
                      ),
                    ),
                  ],
                ),
                Text("합계: ${numberFormat.format(price * quantity)}원"),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
