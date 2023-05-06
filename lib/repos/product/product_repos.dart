import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_app/models/product_model.dart';
import 'package:e_commerce_app/repos/product/base_product_repos.dart';

import '../../models/models.dart';

class ProductRepository extends BaseProductRepository {
  final FirebaseFirestore _firebaseFirestore;

  ProductRepository({FirebaseFirestore? firebaseFirestore})
      : _firebaseFirestore = firebaseFirestore ?? FirebaseFirestore.instance;
  @override
  Stream<List<Product>> getAllProducts() {
    return _firebaseFirestore.collection('products').snapshots().map(
      (snapshot) {
        return snapshot.docs.map((doc) => Product.fromSnapshot(doc)).toList();
      },
    );
  }
}
