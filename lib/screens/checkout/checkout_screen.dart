import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/blocs.dart';
import '../../widgets/widgets.dart';

class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({super.key});

  static const routeName = '/checkout-screen';

  static Route route() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (context) => const CheckoutScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Checkout'),
      bottomNavigationBar: const CustomNavBar(screen: routeName),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: BlocBuilder<CheckoutBloc, CheckoutState>(
          builder: (context, state) {
            if (state is CheckoutLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is CheckoutLoaded) {
              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.15,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'CUSTOMER INFORMATION',
                            style: Theme.of(context).textTheme.headlineMedium,
                          ),
                          _buildTextFormField((value) {
                            context.read<CheckoutBloc>().add(
                                  UpdateCheckout(email: value),
                                );
                          }, context, 'Email'),
                          _buildTextFormField((value) {
                            context.read<CheckoutBloc>().add(
                                  UpdateCheckout(fullName: value),
                                );
                          }, context, 'Full Name'),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.3,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'DELIVERY INFORMATION',
                            style: Theme.of(context).textTheme.headlineMedium,
                          ),
                          _buildTextFormField((value) {
                            context.read<CheckoutBloc>().add(
                                  UpdateCheckout(address: value),
                                );
                          }, context, 'Address'),
                          _buildTextFormField((value) {
                            context.read<CheckoutBloc>().add(
                                  UpdateCheckout(city: value),
                                );
                          }, context, 'City'),
                          _buildTextFormField((value) {
                            context.read<CheckoutBloc>().add(
                                  UpdateCheckout(country: value),
                                );
                          }, context, 'Country'),
                          _buildTextFormField((value) {
                            context.read<CheckoutBloc>().add(
                                  UpdateCheckout(zipCode: value),
                                );
                          }, context, 'Zip Code'),
                        ],
                      ),
                    ),
                    const SizedBox(height: 70),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.3,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'ORDER SUMMARY',
                            style: Theme.of(context).textTheme.headlineMedium,
                          ),
                          const OrderSummary(),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            } else {
              return const Text('Something went wrong');
            }
          },
        ),
      ),
    );
  }

  Padding _buildTextFormField(
    Function(String)? onChanged,
    BuildContext context,
    String labelText,
  ) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(children: [
        SizedBox(
          width: 75,
          child: Text(
            labelText,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ),
        Expanded(
          child: TextFormField(
            onChanged: onChanged,
            decoration: const InputDecoration(
              isDense: true,
              contentPadding: EdgeInsets.only(
                left: 10,
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.black),
              ),
            ),
          ),
        ),
      ]),
    );
  }
}
