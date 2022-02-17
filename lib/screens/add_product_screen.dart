import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_merchant/constants/merchant_theme.dart';
import 'package:flutter_merchant/models/product.dart';
import 'package:flutter_merchant/providers/product_provider.dart';
import 'package:flutter_merchant/widgets/common_dialog.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class AddProductScreen extends StatefulWidget {
  static const routeName = '/add-product-screen';
  @override
  _AddProductScreenState createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _priceController = TextEditingController();
  final _quantityController = TextEditingController();
  final _productDetailsController = TextEditingController();
  var productProvider;
  var uuid = Uuid();

  Future _addProduct() async {
    try {
      Product newProduct = Product(
        productID: uuid.v4(),
        name: _nameController.text,
        price: double.parse(_priceController.text),
        quantity: num.parse(_quantityController.text),
        productDetails: _productDetailsController.text,
      );

      productProvider.addProduct(newProduct);
      Navigator.of(context).pop();

      showDialog(
        context: context,
        builder: (BuildContext context) =>
            CommonDialog("Success!", "You have added ${_nameController.text}."),
      );
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

  @override
  void initState() {
    super.initState();
    productProvider = Provider.of<ProductProvider>(context, listen: false);
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
      body: SingleChildScrollView(
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
                  'Add new product',
                  style: MerchantTextStyle.greetingsText,
                ),
                Text(
                  "Fill in the necessary details",
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
                    FilteringTextInputFormatter.allow(RegExp(r'(^\d*\.?\d*)'))
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
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    final form = _formKey.currentState;
                    if (form!.validate()) {
                      form.save();
                      _addProduct();
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    primary: MerchantColors.blue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100.0),
                    ),
                    minimumSize: Size.fromHeight(50),
                  ),
                  child: Text(
                    "Add Product",
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
