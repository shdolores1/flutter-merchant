import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_merchant/locators/service_locator.dart';
import 'package:flutter_merchant/models/view_models/product_view_model.dart';
import 'package:flutter_merchant/repositories/product_repository.dart';

// States
abstract class ProductsSectionState extends Equatable {
  const ProductsSectionState();

  @override
  List<Object?> get props => [];
}

class ProductsSectionInitial extends ProductsSectionState {
  const ProductsSectionInitial();
}

class ProductsSectionLoading extends ProductsSectionState {
  const ProductsSectionLoading();
}

class ProductsSectionLoaded extends ProductsSectionState {
  final List<ProductViewModel> products;

  const ProductsSectionLoaded({required this.products});
}

class ProductsSectionFailure extends ProductsSectionState {
  final String message;

  const ProductsSectionFailure({required this.message});

  @override
  List<Object?> get props => [message];
}

// Events
class ProductsSectionEvent extends Equatable {
  const ProductsSectionEvent();

  @override
  List<Object?> get props => [];
}

class ProductsSectionLoadStarted extends ProductsSectionEvent {
  const ProductsSectionLoadStarted();

  @override
  List<Object?> get props => [];
}

// Bloc
class ProductsSectionBloc
    extends Bloc<ProductsSectionEvent, ProductsSectionState> {
  final ProductRepository _productRepository =
      ServiceLocator.get<ProductRepository>();
  ProductsSectionBloc() : super(const ProductsSectionInitial()) {
    on<ProductsSectionLoadStarted>((event, emit) async {
      try {
        emit(const ProductsSectionLoading());

        final List<ProductViewModel> products =
            await _productRepository.loadProducts();

        emit(ProductsSectionLoaded(products: products));
      } catch (error) {
        emit(ProductsSectionFailure(message: error.toString()));
      }
    });
  }
}
