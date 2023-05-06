import 'package:e_commerce_app/screens/home/home_screen.dart';
import 'package:e_commerce_app/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/blocs.dart';
import '../models/models.dart';

class CustomNavBar extends StatelessWidget {
  final String screen;
  final Product? product;
  const CustomNavBar({
    super.key,
    required this.screen,
    this.product,
  });

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      color: Colors.black,
      child: SizedBox(
        height: 70,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: _selectNavBar(context, screen)!,
        ),
      ),
    );
  }

  List<Widget>? _selectNavBar(context, screen) {
    switch (screen) {
      case '/':
        return _buildNavBar(context);
      case '/catalog-screen':
        return _buildNavBar(context);
      case '/wishlist-screen':
        return _buildNavBar(context);
      case '/product-screen':
        return _buildAddToCartNavBar(context, product);
      case '/cart-screen':
        return _buildGoToCheckoutNavBar(context);
      case '/checkout-screen':
        return _buildOrderNowNavBar(context);
      default:
        _buildNavBar(context);
    }
    return null;
  }

  List<Widget> _buildNavBar(context) {
    return [
      IconButton(
        onPressed: () {
          Navigator.pushNamedAndRemoveUntil(
              context, HomeScreen.routeName, (route) => false);
        },
        icon: const Icon(
          Icons.home,
          color: Colors.white,
        ),
      ),
      IconButton(
        onPressed: () {
          Navigator.pushNamed(context, CartScreen.routeName);
        },
        icon: const Icon(
          Icons.shopping_cart,
          color: Colors.white,
        ),
      ),
      IconButton(
        onPressed: () {},
        icon: const Icon(
          Icons.person,
          color: Colors.white,
        ),
      ),
    ];
  }

  List<Widget> _buildAddToCartNavBar(context, product) {
    return [
      IconButton(
        onPressed: () {},
        icon: const Icon(
          Icons.share,
          color: Colors.white,
        ),
      ),
      BlocBuilder<WishlistBloc, WishlistState>(
        builder: (context, state) {
          if (state is WishlistLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is WishlistLoaded) {
            return IconButton(
              onPressed: () {
                context.read<WishlistBloc>().add(
                      AddToWishlistEvent(product),
                    );

                const snackBar = SnackBar(
                  content: Text('Added to your Wishlist!'),
                );
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              },
              icon: const Icon(
                Icons.favorite,
                color: Colors.white,
              ),
            );
          }
          return const Text('Some thing went wrong');
        },
      ),
      BlocBuilder<CartBloc, CartState>(
        builder: (context, state) {
          if (state is CartLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is CartLoaded) {
            return ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.white),
              onPressed: () {
                context.read<CartBloc>().add(CartProductAdded(product));
              },
              child: Text(
                'ADD TO CART',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
            );
          }
          return const Text('Something went wrong');
        },
      ),
    ];
  }

  List<Widget> _buildGoToCheckoutNavBar(context) {
    return [
      ElevatedButton(
        onPressed: () {
          Navigator.pushNamed(context, CheckoutScreen.routeName);
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
        ),
        child: Text(
          'GO TO CHECKOUT',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ),
    ];
  }

  List<Widget> _buildOrderNowNavBar(context) {
    return [
      BlocBuilder<CheckoutBloc, CheckoutState>(
        builder: (context, state) {
          if (state is CheckoutLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is CheckoutLoaded) {
            return ElevatedButton(
              onPressed: () {
                context.read<CheckoutBloc>().add(
                      ConfirmCheckout(checkout: state.checkout),
                    );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
              ),
              child: Text(
                'ORDER NOW',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
            );
          } else {
            return const Text('ERROR');
          }
        },
      ),
    ];
  }
}
