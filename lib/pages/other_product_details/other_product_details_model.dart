import '../../components/custom_nav_bar_model.dart';
import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_count_controller.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/pages/my_cart/my_cart_widget.dart';
import 'other_product_details_widget.dart' show OtherProductDetailsWidget;
import 'package:auto_size_text/auto_size_text.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class OtherProductDetailsModel
    extends FlutterFlowModel<OtherProductDetailsWidget> {
  ///  Local state fields for this page.
  late double otherSinglePrice;

  bool selecteddesign = true;

  bool wishlistlikedislike = true;
  int? productid;

  int? productmaintypee;

  bool productvarient = true;

  int? productvarientid;

  List<int> selectedDesing = [0];
  void addToSelectedDesing(int item) => selectedDesing.add(item);
  void removeFromSelectedDesing(int item) => selectedDesing.remove(item);
  void removeAtIndexFromSelectedDesing(int index) =>
      selectedDesing.removeAt(index);
  void insertAtIndexInSelectedDesing(int index, int item) =>
      selectedDesing.insert(index, item);
  void updateSelectedDesingAtIndex(int index, Function(int) updateFn) =>
      selectedDesing[index] = updateFn(selectedDesing[index]);

  String? selectedvariation;

  int? selectedVariatoinindex = 0;

  int? otherproductid;

  ApiCallResponse? addtoWishlist;
  ApiCallResponse? apiResult5ep;
  bool? otherproductvarientstattus;

  int? otherproductmaintype;
  ///  State fields for stateful widgets in this page.
  ApiCallResponse? singlepriceproduct;
  final unfocusNode = FocusNode();
  // State field(s) for CountController widget.
  int? countControllerValue;
  ApiCallResponse? apiResultj7i;
  // State field(s) for Expandable widget.
  late ExpandableController expandableExpandableController1;

  // State field(s) for Expandable widget.
  late ExpandableController expandableExpandableController2;

  // Stores action output result for [Backend Call - API (Add To Cart)] action in Button widget.
  ApiCallResponse? addproductforvarients;
  // Stores action output result for [Backend Call - API (Add To Cart)] action in Button widget.
  ApiCallResponse? addproductforsingleprice;
  // Model for CustomNavBar component.
  late CustomNavBarModel customNavBarModel;

  @override
  void initState(BuildContext context) {
    customNavBarModel = createModel(context, () => CustomNavBarModel());
  }

  @override
  void dispose() {
    unfocusNode.dispose();
    expandableExpandableController1.dispose();
    expandableExpandableController2.dispose();
  }
}
