import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:store/presentation/errors/error.view.dart';
import 'package:store/presentation/home/product.view.dart';

import '../../binds/dependency.injector .dart';
import '../../widgets/card.product.dart';
import '../../widgets/search.widget.dart';
import '../favorite/favorite.view.dart';
import 'home.controller.dart';
import 'home.state.dart';

class HomeView extends StatelessWidget {
  //ROUTER
  static const String routeName = '/home';
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = DependencyInjector.get<HomeController>();
    return Scaffold(
      appBar: AppBar(
          title: const Text(
            'Product',
            style: TextStyle(fontWeight: FontWeight.w600),
          ),
          //like
          actions: [
            IconButton(
              onPressed: () {
                Navigator.pushNamed(context, FavoriteView.routeName);
              },
              icon: const Icon(Icons.favorite_border),
            ),
          ]),
      body: ValueListenableBuilder<HomeState>(
        valueListenable: controller,
        builder: (context, state, child) {
          if (state is HomeStateLoading || state is HomeStateInitial) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is HomeStateError) {
            SchedulerBinding.instance.addPostFrameCallback((_) {
              Navigator.pushNamed(context, ErrorView.routeName);
            });
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is HomeStateSuccess) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(19.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SearchTextField(),
                    const SizedBox(
                      height: 20,
                    ),
                    Expanded(
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: state.products.length,
                        itemBuilder: (context, index) {
                          final product = state.products[index];
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          ProductView(product: product)));
                            },
                            child: CardProduct(
                                product: product,
                                onLikeTap: () {
                                  controller.likeProduct(product.copyWith(
                                      isFavorite: !product.isFavorite!));
                                }),
                          );
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
