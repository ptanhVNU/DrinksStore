import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class Product extends Equatable {
  final String name;
  final String category;
  final String imageUrl;
  final double price;
  final bool isRecommended;
  final bool isPopular;

  const Product({
    required this.name,
    required this.category,
    required this.imageUrl,
    required this.price,
    required this.isRecommended,
    required this.isPopular,
  });

  @override
  List<Object?> get props => [
        name,
        category,
        imageUrl,
        price,
        isRecommended,
        isPopular,
      ];

  static Product fromSnapshot(DocumentSnapshot snapshot) {
    return Product(
      name: snapshot.data().toString().contains('name')
          ? snapshot.get('name')
          : '',
      category: snapshot.data().toString().contains('category')
          ? snapshot.get('category')
          : '',
      imageUrl: snapshot.data().toString().contains('imageUrl')
          ? snapshot.get('imageUrl')
          : '',
      price: snapshot.data().toString().contains('price')
          ? snapshot.get('price')
          : 0,
      isRecommended: snapshot.data().toString().contains('isRecommended')
          ? snapshot.get('isRecommended')
          : false,
      isPopular: snapshot.data().toString().contains('isPopular')
          ? snapshot.get('isPopular')
          : false,
    );
  }

  static List<Product> products = const [
    Product(
      name: 'Soft Drink #1',
      category: 'Soft Drinks',
      imageUrl:
          'https://images.unsplash.com/photo-1543253687-c931c8e01820?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=765&q=80',
      price: 3.00,
      isRecommended: true,
      isPopular: true,
    ),
    Product(
      name: 'Soft Drink #2',
      category: 'Soft Drinks',
      imageUrl:
          'https://images.unsplash.com/photo-1581006852262-e4307cf6283a?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=687&q=80',
      price: 3.00,
      isRecommended: true,
      isPopular: true,
    ),
    Product(
      name: 'Soft Drink #3',
      category: 'Soft Drinks',
      imageUrl:
          'https://images.unsplash.com/photo-1603394630850-69b3ca8121ca?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=687&q=80',
      price: 3.00,
      isRecommended: true,
      isPopular: true,
    ),
    Product(
      name: 'Smoothies #1',
      category: 'Smoothies',
      imageUrl:
          'https://images.unsplash.com/photo-1638176067000-924231101b88?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=880&q=80',
      price: 3.00,
      isRecommended: true,
      isPopular: true,
    ),
    Product(
      name: 'Smoothies #2',
      category: 'Smoothies',
      imageUrl:
          'https://images.unsplash.com/photo-1671660470078-12bdb5e479a6?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=634&q=80',
      price: 3.00,
      isRecommended: true,
      isPopular: true,
    ),
  ];
}
