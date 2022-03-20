import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_merchant/locators/service_locator.dart';
import 'package:flutter_merchant/models/view_models/product_view_model.dart';
import 'package:flutter_merchant/repositories/product_repository.dart';

// States
abstract class ViewProductState extends Equatable {
  const ViewProductState();

  @override
  List<Object?> get props => [];
}

class ViewProductInitial extends ViewProductState {
  const ViewProductInitial();
}

class ViewProductInProgress extends ViewProductState {
  const ViewProductInProgress();
}

class ViewProductSuccess extends ViewProductState {
  final ProductViewModel product;

  const ViewProductSuccess({required this.product});
}

class ViewProductFailure extends ViewProductState {
  final String message;

  const ViewProductFailure({required this.message});

  @override
  List<Object?> get props => [message];
}

// Events
class ViewProductEvent extends Equatable {
  const ViewProductEvent();

  @override
  List<Object?> get props => [];
}

class ViewProductStarted extends ViewProductEvent {
  final String productID;

  const ViewProductStarted({required this.productID});

  @override
  List<Object?> get props => [productID];
}

// Bloc
class ViewProductBloc extends Bloc<ViewProductEvent, ViewProductState> {
  final ProductRepository _productRepository =
      ServiceLocator.get<ProductRepository>();
  ViewProductBloc() : super(const ViewProductInitial()) {
    on<ViewProductStarted>((event, emit) async {
      try {
        emit(const ViewProductInProgress());

        final ProductViewModel product =
            await _productRepository.loadProduct(event.productID);

        emit(ViewProductSuccess(product: product));
      } catch (error) {
        emit(ViewProductFailure(message: error.toString()));
      }
    });
  }
}
