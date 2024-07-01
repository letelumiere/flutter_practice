import 'package:flutter/material.dart';
import 'package:flutter_practice/viewModels/cartViewModel.dart';
import 'package:flutter_practice/widgets/basketItem.dart';
import 'package:flutter_practice/widgets/basketList.dart';
import 'package:flutter_practice/services/cart_services.dart';
import 'package:flutter_practice/widgets/checkoutButton.dart';
import 'package:provider/provider.dart';

class ItemBasketPage extends StatelessWidget {
  const ItemBasketPage({super.key});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("장바구니"),
        centerTitle: true,
      ),
      body: Consumer<CartViewModel>(
        builder: (context, viewModel, child) {
          return viewModel.cartMap.isEmpty
              ? const Center(
                  child: Text("장바구니에 담긴 제품이 없습니다."),
                )
              : BasketList(
                  cartMap: viewModel.cartMap,
                  productList: viewModel.productList,
                  cartService: viewModel.cartService,
                );
        },
      ),
      bottomNavigationBar: Consumer<CartViewModel>(
        builder: (context, viewModel, child) {
          return viewModel.cartMap.isEmpty
              ? const SizedBox.shrink()
              : CheckoutButton(
                  cartMap: viewModel.cartMap,
                  productList: viewModel.productList,
                );
        },
      ),
    );
  }
}
