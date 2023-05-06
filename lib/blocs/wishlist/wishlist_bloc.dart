import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../models/models.dart';

part 'wishlist_event.dart';
part 'wishlist_state.dart';

class WishlistBloc extends Bloc<WishlistEvent, WishlistState> {
  WishlistBloc() : super(WishlistLoading()) {
    on<StartWishlist>(_onStart);
    on<AddToWishlistEvent>(_onAdd);
    on<RemoveFromWishlistEvent>(_onRemove);
  }

  void _onStart(StartWishlist event, Emitter<WishlistState> emit) async {
    log('state: $state');
    emit(WishlistLoading());
    await Future<void>.delayed(const Duration(seconds: 1));
    emit(
      const WishlistLoaded(),
    );
  }

// handle event add
  void _onAdd(AddToWishlistEvent event, Emitter<WishlistState> emit) async {
    final state = this.state;
    if (state is WishlistLoaded) {
      log('state: $state');
      emit(
        WishlistLoaded(
          wishlist: Wishlist(
            products: List.from(state.wishlist.products)..add(event.product),
          ),
        ),
      );
    }
  } // handle event remove

  void _onRemove(
      RemoveFromWishlistEvent event, Emitter<WishlistState> emit) async {
    final state = this.state;
    if (state is WishlistLoaded) {
      emit(
        WishlistLoaded(
          wishlist: Wishlist(
            products: List.from(state.wishlist.products)..remove(event.product),
          ),
        ),
      );
    }
  }
}
