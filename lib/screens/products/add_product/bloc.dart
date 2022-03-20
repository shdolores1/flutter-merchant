import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_merchant/locators/service_locator.dart';
import 'package:flutter_merchant/repositories/product_repository.dart';

// States
abstract class AddProductState extends Equatable {
  const AddProductState();

  @override
  List<Object?> get props => [];
}

class AddProductInitial extends AddProductState {
  const AddProductInitial();
}

class AddProductInProgress extends AddProductState {
  const AddProductInProgress();
}

class AddProductSuccess extends AddProductState {
  const AddProductSuccess();
}

class AddProductFailure extends AddProductState {
  final String message;

  const AddProductFailure({required this.message});

  @override
  List<Object?> get props => [message];
}

// Events
class AddProductEvent extends Equatable {
  const AddProductEvent();

  @override
  List<Object?> get props => [];
}

class AddProductStarted extends AddProductEvent {
  final String productID;
  final String name;
  final double price;
  final num quantity;
  final String productDetails;

  const AddProductStarted({
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
class AddProductBloc extends Bloc<AddProductEvent, AddProductState> {
  final ProductRepository _productRepository =
      ServiceLocator.get<ProductRepository>();
  AddProductBloc() : super(const AddProductInitial()) {
    on<AddProductStarted>((event, emit) async {
      try {
        emit(const AddProductInProgress());

        await _productRepository.addProduct(event.productID, event.name,
            event.price, event.quantity, event.productDetails);

        emit(AddProductSuccess());
      } catch (error) {
        emit(AddProductFailure(message: error.toString()));
      }
    });
  }
}
