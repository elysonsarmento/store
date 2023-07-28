import 'package:flutter/material.dart';
import 'package:store/presentation/errors/error.view.dart';
import 'package:store/presentation/favorite/favorite.state.dart';
import 'package:store/presentation/favorite/favorite.view.dart';
import 'package:store/presentation/home/home.controller.dart';
import 'package:store/presentation/home/home.state.dart';
import 'package:store/provider/http.dart';

import 'binds/dependency.injector .dart';
import 'data/data_sourcer/local/product.local.dart';
import 'data/data_sourcer/remote/product.remote.dart';
import 'data/repository/product.repository.dart';
import 'domain/repository/product.repository.dart';
import 'domain/usecase/product.usecase.dart';
import 'presentation/favorite/favorite.controller.dart';
import 'presentation/home/home.view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Story',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: HomeView.routeName,
      onGenerateRoute: (settings) {
        // Injeção de Dependências
        // Aqui são registradas as dependências que serão utilizadas ao longo da aplicação.
        // É uma prática de injeção de dependências para facilitar a manutenção e teste.
        // As dependências são registradas no DependencyInjector, que é uma classe responsável
        // por gerenciar as dependências e suas instâncias.

        // Registrar o Requester - ApiService
        DependencyInjector.register<ApiService>(ApiService());

        // Registrar o Data Source
        DependencyInjector.register<ProductRemote>(
            ProductRemote(DependencyInjector.get<ApiService>()));

        DependencyInjector.register<ProductLocal>(ProductLocal());

        // Registrar o Repository - ProductRepository
        DependencyInjector.register<IProductRepository>(ProductRepository(
            DependencyInjector.get<ProductRemote>(),
            DependencyInjector.get<ProductLocal>()));

        // Registrar o UseCase - ProductUseCase
        DependencyInjector.register<ProductUseCase>(
            ProductUseCase(DependencyInjector.get<IProductRepository>()));

        // Registrar o HomeController, que utilizará o UseCase
        DependencyInjector.register<HomeController>(HomeController(
            HomeStateInitial(), DependencyInjector.get<ProductUseCase>()));

        DependencyInjector.register<FavoriteController>(FavoriteController(
            FavoriteStateLoading(), DependencyInjector.get<ProductUseCase>()));

        // Configuração das rotas
        switch (settings.name) {
          case HomeView.routeName:
            // Rota para a HomeView
            return MaterialPageRoute(
              builder: (context) => const HomeView(),
              settings: settings,
            );
          case FavoriteView.routeName:
            // Rota para a FavoriteView
            return MaterialPageRoute(
              builder: (context) => const FavoriteView(),
              settings: settings,
            );
          case ErrorView.routeName:
            // Rota para a ErrorView
            return MaterialPageRoute(
              builder: (context) => const ErrorView(),
              settings: settings,
            );
          default:
            // Rota padrão para ErrorView em caso de rota não encontrada
            return MaterialPageRoute(
              builder: (context) => const ErrorView(),
              settings: settings,
            );
        }
      },
      home: const ErrorView(), // Página inicial padrão é a ErrorView
    );
  }
}
