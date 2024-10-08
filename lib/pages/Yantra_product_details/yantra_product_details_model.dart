import '../../components/custom_nav_bar_model.dart';
import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_choice_chips.dart';
import '/flutter_flow/flutter_flow_count_controller.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/form_field_controller.dart';
import '/pages/my_cart/my_cart_widget.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import 'yantra_product_details_widget.dart' show YantraProductDetailsWidget;
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:octo_image/octo_image.dart';
import 'package:provider/provider.dart';

class YantraProductDetailsModel
    extends FlutterFlowModel<YantraProductDetailsWidget> {
  ///  Local state fields for this page.

  bool selecteddesign = true;

  bool wishlistlikedislike = true;

  int? selectedVariatoinindex = 0;

  int? otherproductid;

  bool? otherproductvarientstattus;

  int? otherproductmaintype;

  List<int> selectedDesing = [];
  void addToSelectedDesing(int item) => selectedDesing.add(item);
  void removeFromSelectedDesing(int item) => selectedDesing.remove(item);
  void removeAtIndexFromSelectedDesing(int index) =>
      selectedDesing.removeAt(index);
  void insertAtIndexInSelectedDesing(int index, int item) =>
      selectedDesing.insert(index, item);
  void updateSelectedDesingAtIndex(int index, Function(int) updateFn) =>
      selectedDesing[index] = updateFn(selectedDesing[index]);

  String? selectedEnergization;

  int? selectedEnergizationIndex=0;

  int? selectedEnergizationlist=0;

  int? selectvariationindex=0;

  String? selectedCertification;

  String? id;

  int? selectedCertificationindex = 0;

  List<int> selectedCertificationindexlist = [];
  void addToSelectedCertificationindexlist(int item) =>
      selectedCertificationindexlist.add(item);
  void removeFromSelectedCertificationindexlist(int item) =>
      selectedCertificationindexlist.remove(item);
  void removeAtIndexFromSelectedCertificationindexlist(int index) =>
      selectedCertificationindexlist.removeAt(index);
  void insertAtIndexInSelectedCertificationindexlist(int index, int item) =>
      selectedCertificationindexlist.insert(index, item);
  void updateSelectedCertificationindexlistAtIndex(
      int index, Function(int) updateFn) =>
      selectedCertificationindexlist[index] =
          updateFn(selectedCertificationindexlist[index]);

  int? selectedpendentdesign;
  ApiCallResponse? addtoWishlist;
  ApiCallResponse? apiResult5ep;
  int? selectedyantratdesign;
  int? selectedvariationprice = 0;
  int? selectedbraceletdesign;

  int? selectedringdesign;

  int? energizationprice = 0;

  int? designprice = 0;

  int? selectedcertificateprice = 0;

  int? productid;

  int? productmaintypee;

  bool productvarient = true;

  int? productvarientid;

  int? selecteddesignid;

  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();
  // State field(s) for ChoiceChips widget.
  FormFieldController<List<String>>? choiceChipsValueController1;
  String? get choiceChipsValue1 =>
      choiceChipsValueController1?.value?.firstOrNull;
  set choiceChipsValue1(String? val) =>
      choiceChipsValueController1?.value = val != null ? [val] : [];
  // State field(s) for ChoiceChips widget.
  FormFieldController<List<String>>? choiceChipsValueController2;
  String? get choiceChipsValue2 =>
      choiceChipsValueController2?.value?.firstOrNull;
  set choiceChipsValue2(String? val) =>
      choiceChipsValueController2?.value = val != null ? [val] : [];
  // State field(s) for ChoiceChips widget.
  FormFieldController<List<String>>? choiceChipsValueController3;
  String? get choiceChipsValue3 =>
      choiceChipsValueController3?.value?.firstOrNull;
  set choiceChipsValue3(String? val) =>
      choiceChipsValueController3?.value = val != null ? [val] : [];
  // State field(s) for Expandable widget.
  late ExpandableController expandableExpandableController1;

  // State field(s) for CountController widget.
  int? countControllerValue;
  // Stores action output result for [Backend Call - API (Other Single price Add To Cart)] action in Button widget.
  ApiCallResponse? apiResultj7i;
  // Stores action output result for [Backend Call - API (Other Single price Add To Cart)] action in Button widget.
  ApiCallResponse? withoutceertifiaction;
  // State field(s) for Expandable widget.
  late ExpandableController expandableExpandableController2;

  // State field(s) for Expandable widget.
  late ExpandableController expandableExpandableController3;
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
    expandableExpandableController3.dispose();
  }
}
