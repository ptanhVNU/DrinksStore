import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:e_commerce_app/models/models.dart';
import 'package:equatable/equatable.dart';

import '../../repos/product/product_repos.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ProductRepository _productRepository;
  StreamSubscription? _productSubcription;
  ProductBloc({required ProductRepository productRepository})
      : _productRepository = productRepository,
        super(ProductLoading()) {
    on<LoadProducts>(_onLoad);
    on<UpdateProducts>(_onUpdate);
  }

  void _onLoad(LoadProducts event, Emitter<ProductState> emit) async {
    _productSubcription?.cancel();
    _productSubcription = _productRepository.getAllProducts().listen(
          (products) => add(
            UpdateProducts(products),
          ),
        );
  }

  void _onUpdate(UpdateProducts event, Emitter<ProductState> emit) {
    emit(ProductLoaded(products: event.products));
  }
}
