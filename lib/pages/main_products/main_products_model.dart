import '../../components/custom_nav_bar_model.dart';
import '/backend/api_requests/api_calls.dart';
import '/components/error404_screen_widget.dart';
import '/components/filter_component_widget.dart';
import '/components/shimmer_widget.dart';
import '/components/sort_by_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'main_products_widget.dart' show MainProductsWidget;
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class MainProductsModel extends FlutterFlowModel<MainProductsWidget> {
  ///  Local state fields for this page.

  List<String> productid = [];
  void addToProductid(String item) => productid.add(item);
  void removeFromProductid(String item) => productid.remove(item);
  void removeAtIndexFromProductid(int index) => productid.removeAt(index);
  void insertAtIndexInProductid(int index, String item) =>
      productid.insert(index, item);
  void updateProductidAtIndex(int index, Function(String) updateFn) =>
      productid[index] = updateFn(productid[index]);
  int? mainprodtype;

  int? level;

  bool productlist = true;
  bool wishlistproducts = true;

  int? statuscode;

  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();
  // Stores action output result for [Backend Call - API (RudrakshaProduct)] action in MainProducts widget.
  ApiCallResponse? apiResultd4z;
  ApiCallResponse? apiResult5ep;
  // Stores action output result for [Backend Call - API (YantraProduct)] action in MainProducts widget.
  ApiCallResponse? apiResultk1p;
  ApiCallResponse? addtoWishlist;
  ApiCallResponse? pujaActionResult;
  ApiCallResponse? pujaMainActionResult;
  // Stores action output result for [Backend Call - API (PujaProduct)] action in MainProducts widget.
  ApiCallResponse? pujaSubActionResult;
  // Stores action output result for [Backend Call - API (OtherProductMainCategory)] action in MainProducts widget.
  ApiCallResponse? otherSubProductResult;
  // Stores action output result for [Backend Call - API (OtherProductMainCategory)] action in MainProducts widget.
  ApiCallResponse? otherMainProductResult;
  // Model for Error404Screen component.
  // Model for Error404Screen component.
  late Error404ScreenModel error404ScreenModel;
  // Model for CustomNavBar component.
  late CustomNavBarModel customNavBarModel;

  @override
  void initState(BuildContext context) {
    error404ScreenModel = createModel(context, () => Error404ScreenModel());
    customNavBarModel = createModel(context, () => CustomNavBarModel());
  }

  @override
  void dispose() {
    unfocusNode.dispose();
    error404ScreenModel.dispose();
  }
}
