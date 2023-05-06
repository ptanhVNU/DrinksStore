import 'package:equatable/equatable.dart';
import 'package:flutter/rendering.dart';

import 'models.dart';

class Checkout extends Equatable {
  final String? fullName;
  final String? email;
  final String? address;
  final String? city;
  final String? country;
  final String? zipCode;
  final List<Product>? products;
  final String? subTotal;
  final String? deliveryFee;
  final String? total;

  const Checkout({
    required this.fullName,
    required this.email,
    required this.address,
    required this.country,
    required this.city,
    required this.zipCode,
    required this.products,
    required this.subTotal,
    required this.deliveryFee,
    required this.total,
  });
  @override
  List<Object?> get props => [
        fullName,
        email,
        address,
        city,
        country,
        zipCode,
        products,
        subTotal,
        deliveryFee,
        total,
      ];

  Map<String, Object> toDocument() {
    Map customerAddress = {};
    customerAddress['address'] = address;
    customerAddress['city'] = city;
    customerAddress['country'] = country;
    customerAddress['zipCode'] = zipCode;

    return {
      'customerAddress': customerAddress,
      'customerName': fullName!,
      'customerEmail': email!,
      'products': products!.map((e) => e.name).toList(),
      'subTotal': subTotal!,
      'deliveryFee': deliveryFee!,
      'total': total!,
    };
  }
}
