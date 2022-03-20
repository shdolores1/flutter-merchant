import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_merchant/locators/service_locator.dart';
import 'package:flutter_merchant/repositories/product_repository.dart';

// States
abstract class UpdateProductState extends Equatable {
  const UpdateProductState();

  @override
  List<Object?> get props => [];
}

class UpdateProductInitial extends UpdateProductState {
  const UpdateProductInitial();
}

class UpdateProductInProgress extends UpdateProductState {
  const UpdateProductInProgress();
}

class UpdateProductSuccess extends UpdateProductState {
  const UpdateProductSuccess();
}

class UpdateProductFailure extends UpdateProductState {
  final String message;

  const UpdateProductFailure({required this.message});

  @override
  List<Object?> get props => [message];
}

// Events
class UpdateProductEvent extends Equatable {
  const UpdateProductEvent();

  @override
  List<Object?> get props => [];
}

class UpdateProductStarted extends UpdateProductEvent {
  final String productID;
  final String name;
  final double price;
  final num quantity;
  final String productDetails;

  const UpdateProductStarted({
    required this.productID,
    required this.name,
    required this.price,
    required this.quantity,
    required this.productDetails,
  });

  @override
  List<Object?> get props => [
        productID,
        name,
        price,
        quantity,
        productDetails,
      ];
}

// Bloc
class UpdateProductBloc extends Bloc<UpdateProductEvent, UpdateProductState> {
  final ProductRepository _productRepository =
      ServiceLocator.get<ProductRepository>();
  UpdateProductBloc() : super(const UpdateProductInitial()) {
    on<UpdateProductStarted>((event, emit) async {
      try {
        emit(const UpdateProductInProgress());

        await _productRepository.updateProduct(event.productID, event.name,
            event.price, event.quantity, event.productDetails);

        emit(UpdateProductSuccess());
      } catch (error) {
        emit(UpdateProductFailure(message: error.toString()));
      }
    });
  }
}
