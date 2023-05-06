import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_app/models/checkout_model.dart';
import 'package:e_commerce_app/repos/checkout/base_checkout_repos.dart';

class CheckoutRepository extends BaseCheckoutRepository {
  final FirebaseFirestore _firebaseFirestore;

  CheckoutRepository({FirebaseFirestore? firebaseFirestore})
      : _firebaseFirestore = firebaseFirestore ?? FirebaseFirestore.instance;

  // day du lieu len firebase
  @override
  Future<void> addCheckout(Checkout checkout) {
    return _firebaseFirestore.collection('checkout').add(checkout.toDocument());
  }
}
