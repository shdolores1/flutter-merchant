import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_merchant/locators/service_locator.dart';
import 'package:flutter_merchant/models/view_models/product_view_model.dart';
import 'package:flutter_merchant/repositories/product_repository.dart';

// States
abstract class DeleteProductState extends Equatable {
  const DeleteProductState();

  @override
  List<Object?> get props => [];
}

class DeleteProductInitial extends DeleteProductState {
  const DeleteProductInitial();
}

class DeleteProductInProgress extends DeleteProductState {
  const DeleteProductInProgress();
}

class DeleteProductSuccess extends DeleteProductState {
  final ProductViewModel product;

  const DeleteProductSuccess({required this.product});
}

class DeleteProductFailure extends DeleteProductState {
  final String message;

  const DeleteProductFailure({required this.message});

  @override
  List<Object?> get props => [message];
}

// Events
class DeleteProductEvent extends Equatable {
  const DeleteProductEvent();

  @override
  List<Object?> get props => [];
}

class DeleteProductStarted extends DeleteProductEvent {
  final String productID;

  const DeleteProductStarted({required this.productID});

  @override
  List<Object?> get props => [productID];
}

// Bloc
class DeleteProductBloc extends Bloc<DeleteProductEvent, DeleteProductState> {
  final ProductRepository _productRepository =
      ServiceLocator.get<ProductRepository>();
  DeleteProductBloc() : super(const DeleteProductInitial()) {
    on<DeleteProductStarted>((event, emit) async {
      try {
        emit(const DeleteProductInProgress());

        final ProductViewModel product =
            await _productRepository.deleteProduct(event.productID);

        emit(DeleteProductSuccess(product: product));
      } catch (error) {
        emit(DeleteProductFailure(message: error.toString()));
      }
    });
  }
}
