import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_merchant/constants/merchant_theme.dart';
import 'package:flutter_merchant/models/product.dart';
import 'package:flutter_merchant/providers/product_provider.dart';
import 'package:flutter_merchant/widgets/common_dialog.dart';
import 'package:flutter_merchant/widgets/option_dialog.dart';
import 'package:provider/provider.dart';

class UpdateProductScreen extends StatefulWidget {
  static const routeName = '/update-product-screen';

  @override
  _UpdateProductScreenState createState() => _UpdateProductScreenState();
}

class _UpdateProductScreenState extends State<UpdateProductScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _priceController = TextEditingController();
  final _quantityController = TextEditingController();
  final _productDetailsController = TextEditingController();
  var productID;
  var productProvider;
  var product;
  bool _isLoading = true;

  Future _updateProduct() async {
    try {
      Product updatedProduct = Product(
        productID: productID,
        name: _nameController.text,
        price: double.parse(_priceController.text),
        quantity: num.parse(_quantityController.text),
        productDetails: _productDetailsController.text,
      );

      productProvider.updateProduct(updatedProduct);
      Navigator.of(context).pop();

      showDialog(
        context: context,
        builder: (BuildContext context) => CommonDialog(
            "Success!", "You have updated ${_nameController.text}."),
      );
    } catch (e) {
      debugPrint(e.toString());
      showDialog(
        context: context,
        builder: (BuildContext context) => CommonDialog("Oops!", e.toString()),
      );
    }
  }

  Future _deleteProduct() async {
    try {
      showDialog(
        context: context,
        builder: (BuildContext context) => OptionDialog(
            "Are you sure?", "This will remove the product from your store."),
      ).then((toDelete) {
        if (toDelete) {
          productProvider.deleteProduct(productID);
          Navigator.of(context).pop();

          showDialog(
            context: context,
            builder: (BuildContext context) => CommonDialog(
                "Success!", "You have deleted ${_nameController.text}."),
          );
        } else {
          print('Cancel Delete');
        }
      });
    } catch (e) {
      debugPrint(e.toString());
      showDialog(
        context: context,
        builder: (BuildContext context) => CommonDialog("Oops!", e.toString()),
      );
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _priceController.dispose();
    _quantityController.dispose();
    _productDetailsController.dispose();
    super.dispose();
  }

  Future<void> _initScreen() async {
    productProvider = Provider.of<ProductProvider>(context, listen: false);
    productID = ModalRoute.of(context)!.settings.arguments as String;

    try {
      Provider.of<ProductProvider>(context, listen: false)
          .getProductByID(productID)
          .then((value) {
        setState(() {
          product = value;
          _nameController.text = product.name.toString();
          _priceController.text = product.price.toString();
          _quantityController.text = product.quantity.toString();
          _productDetailsController.text = product.productDetails.toString();
          _isLoading = false;
        });
      });
    } catch (error) {
      print('Error: ' + error.toString());
      setState(() {
        _isLoading = false;
      });
      showDialog(
        context: context,
        builder: (BuildContext context) => CommonDialog("Oops!",
            "There was an error while loading the product. Please try again."),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((_) => _initScreen());
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        leading: GestureDetector(
          child: Icon(
            Icons.arrow_back_ios,
            color: MerchantColors.black,
          ),
          onTap: () => Navigator.of(context).pop(),
        ),
      ),
      body: (_isLoading)
          ? Center(
              child: CircularProgressIndicator(
                color: MerchantColors.blue,
              ),
            )
          : SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                width: mediaQuery.size.width,
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'Update product',
                        style: MerchantTextStyle.greetingsText,
                      ),
                      Text(
                        "Edit the necessary details",
                        style: MerchantTextStyle.subHeaderText.copyWith(
                          color: MerchantColors.black,
                        ),
                      ),
                      SizedBox(height: 20),
                      TextFormField(
                        keyboardType: TextInputType.text,
                        controller: _nameController,
                        textInputAction: TextInputAction.next,
                        inputFormatters: <TextInputFormatter>[
                          LengthLimitingTextInputFormatter(20)
                        ],
                        decoration: InputDecoration(
                          labelText: "Name",
                          labelStyle: MerchantTextStyle.labelText,
                          border: MerchantDecoration.outlineBorder,
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please input a name.';
                          } else if (value.length > 20) {
                            return 'Please input up to 20 characters only.';
                          } else {
                            return null;
                          }
                        },
                      ),
                      SizedBox(height: 10),
                      TextFormField(
                        keyboardType: TextInputType.number,
                        controller: _priceController,
                        textInputAction: TextInputAction.next,
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.allow(
                              RegExp(r'(^\d*\.?\d*)'))
                        ],
                        decoration: InputDecoration(
                          labelText: "Price (₱)",
                          labelStyle: MerchantTextStyle.labelText,
                          border: MerchantDecoration.outlineBorder,
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please input a price.';
                          } else if (double.parse(value) > 9999) {
                            return 'Input exceeded the maximum amount.';
                          } else {
                            return null;
                          }
                        },
                      ),
                      SizedBox(height: 10),
                      TextFormField(
                        keyboardType: TextInputType.number,
                        controller: _quantityController,
                        textInputAction: TextInputAction.next,
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.digitsOnly,
                          LengthLimitingTextInputFormatter(3)
                        ],
                        decoration: InputDecoration(
                          labelText: "Quantity",
                          labelStyle: MerchantTextStyle.labelText,
                          border: MerchantDecoration.outlineBorder,
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please input a quantity.';
                          } else if (value.length > 3) {
                            return 'Please input up to 3 digits only.';
                          } else {
                            return null;
                          }
                        },
                      ),
                      SizedBox(height: 10),
                      TextFormField(
                        keyboardType: TextInputType.text,
                        controller: _productDetailsController,
                        textInputAction: TextInputAction.next,
                        maxLines: 3,
                        inputFormatters: <TextInputFormatter>[
                          LengthLimitingTextInputFormatter(100)
                        ],
                        decoration: InputDecoration(
                          labelText: "Product Details",
                          labelStyle: MerchantTextStyle.labelText,
                          border: MerchantDecoration.outlineBorder,
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please input product details.';
                          } else if (value.length > 100) {
                            return 'Please input up to 100 characters only.';
                          } else {
                            return null;
                          }
                        },
                      ),
                      SizedBox(height: 10),
                      ElevatedButton.icon(
                        onPressed: () {
                          _deleteProduct();
                        },
                        style: ElevatedButton.styleFrom(
                          primary: MerchantColors.white,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(100.0),
                              side: BorderSide(color: MerchantColors.blue)),
                          minimumSize: Size.fromHeight(50),
                        ),
                        icon: Icon(
                          Icons.delete_forever,
                          color: MerchantColors.blue,
                        ),
                        label: Text(
                          "Delete Product",
                          textAlign: TextAlign.center,
                          style: MerchantTextStyle.buttonText.copyWith(
                            color: MerchantColors.blue,
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      ElevatedButton.icon(
                        onPressed: () {
                          final form = _formKey.currentState;
                          if (form!.validate()) {
                            form.save();
                            _updateProduct();
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          primary: MerchantColors.blue,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(100.0),
                          ),
                          minimumSize: Size.fromHeight(50),
                        ),
                        icon: Icon(
                          Icons.edit,
                          color: MerchantColors.white,
                        ),
                        label: Text(
                          "Update Product",
                          textAlign: TextAlign.center,
                          style: MerchantTextStyle.buttonText,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
