import 'package:e_commerce_app/blocs/category/category_bloc.dart';
import 'package:e_commerce_app/blocs/checkout/checkout_bloc.dart';
import 'package:e_commerce_app/blocs/product/product_bloc.dart';
import 'package:e_commerce_app/config/routes.dart';
import 'package:e_commerce_app/config/theme.dart';
import 'package:e_commerce_app/repos/category/category_repos.dart';
import 'package:e_commerce_app/repos/checkout/checkout_repos.dart';
import 'package:e_commerce_app/repos/product/product_repos.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'blocs/blocs.dart';
import 'screens/screens.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => CartBloc()..add(CartStarted())),
        BlocProvider(
            create: (context) => CheckoutBloc(
                  cartBloc: context.read<CartBloc>(),
                  checkoutRepository: CheckoutRepository(),
                )),
        BlocProvider(
          create: (_) => WishlistBloc()..add(const StartWishlist()),
        ),
        BlocProvider(
            create: (_) =>
                CategoryBloc(categoryRepository: CategoryRepository())
                  ..add(
                    LoadCategories(),
                  )),
        BlocProvider(
            create: (_) => ProductBloc(productRepository: ProductRepository())
              ..add(LoadProducts())),
      ],
      child: MaterialApp(
        title: 'Zero to Unicorn',
        theme: theme(),
        onGenerateRoute: AppRouter.onGenerateRoute,
        initialRoute: SplashScreen.routeName,
        home: const HomeScreen(),
      ),
    );
  }
}
