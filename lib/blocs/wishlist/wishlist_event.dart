part of 'wishlist_bloc.dart';

abstract class WishlistEvent extends Equatable {
  const WishlistEvent();

  @override
  List<Object> get props => [];
}

@immutable
class StartWishlist extends WishlistEvent {
  const StartWishlist();
}

class RemoveFromWishlistEvent extends WishlistEvent {
  final Product product;

  const RemoveFromWishlistEvent(this.product);

  @override
  List<Object> get props => [product];
}

class AddToWishlistEvent extends WishlistEvent {
  final Product product;

  const AddToWishlistEvent(this.product);

  @override
  List<Object> get props => [product];
}
