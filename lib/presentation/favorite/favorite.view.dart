import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:store/presentation/errors/error.view.dart';
import 'package:store/presentation/favorite/favorite.state.dart';

import '../../binds/dependency.injector .dart';
import '../../widgets/card.product.dart';
import 'favorite.controller.dart';

class FavoriteView extends StatelessWidget {
  //ROUTER
  static const String routeName = '/Favorite';
  const FavoriteView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = DependencyInjector.get<FavoriteController>();
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Favorites',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
      ),
      body: ValueListenableBuilder<FavoriteState>(
        valueListenable: controller,
        builder: (context, state, child) {
          if (state is FavoriteStateLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is FavoriteStateError) {
            SchedulerBinding.instance.addPostFrameCallback((_) {
              Navigator.pushNamed(context, ErrorView.routeName);
            });
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is FavoriteStateSuccess) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(19.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: state.products.length,
                        itemBuilder: (context, index) {
                          final product = state.products[index];
                          return CardProduct(product: product);
                        },
                      ),
                    )
                  ],
                ),
              ),
            );
          } else {
            SchedulerBinding.instance.addPostFrameCallback((_) {
              Navigator.pushNamed(context, ErrorView.routeName);
            });
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
