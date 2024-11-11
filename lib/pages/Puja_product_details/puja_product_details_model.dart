import '../../components/custom_nav_bar_model.dart';
import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';

import '/pages/my_cart/my_cart_widget.dart';
import 'puja_product_details_widget.dart' show PujaProductDetailsWidget;
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

//import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:octo_image/octo_image.dart';
import 'package:provider/provider.dart';

class PujaProductDetailsModel
    extends FlutterFlowModel<PujaProductDetailsWidget> {
  ///  Local state fields for this page.

  bool selecteddesign = true;

  bool wishlistlikedislike = true;
  ApiCallResponse? addtoWishlist;
  ApiCallResponse? removefromwishlist;
  ApiCallResponse? apiResult5ep;
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
  String? selectedFileName;
  String? selectedFileBase64;
  int? selectedEnergizationIndex;

  int? selectedEnergizationlist;

  String? selectedCertification;

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

  int? selectedyantratdesign;

  int? selectedbraceletdesign;

  int? selectedringdesign;

  int? energizationprice = 0;

  int? designprice = 0;

  int? selectedvariationprice = 0;

  int? productid;

  int? productmaintypee;

  bool productvarient = true;

  int? productvarientid;

  int? selecteddesignid;

  int? selectvariationindex;

  int? selectedproductprice;

  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();
  final formKey3 = GlobalKey<FormState>();
  final formKey4 = GlobalKey<FormState>();
  final formKey5 = GlobalKey<FormState>();
  final formKey6 = GlobalKey<FormState>();
  final formKey2 = GlobalKey<FormState>();

  // State field(s) for Expandable widget.
  late ExpandableController expandableExpandableController1;

  // State field(s) for EnterName widget.
  FocusNode? enterNameFocusNode;
  TextEditingController? enterNameTextController;

  // State field(s) for EnterSankalpWish widget.

  String? enterNameTextControllerValidator(BuildContext context, String? val) {
    if (val!.isEmpty) {
      return null;
    }

    if (!RegExp('^[A-Za-z ]{1,50}\$').hasMatch(val!)) {
      return 'Should contain only characters';
    }
    return null;
  }

  String? enterSankalpWishTextControllerValidator(
      BuildContext context, String? val) {
    if (val!.isEmpty) {
      return null;
    }

    if (!RegExp('^[A-Za-z ]{1,50}\$').hasMatch(val!)) {
      return 'Should contain only characters';
    }
    return null;
  }

  String? enterMothersNameTextControllerValidator(
      BuildContext context, String? val) {
    if (val!.isEmpty) {
      return null;
    }

    if (!RegExp('^[A-Za-z ]{1,50}\$').hasMatch(val!)) {
      return 'Should contain only characters';
    }
    return null;
  }

  String? enterFathersNameTextControllerValidator(
      BuildContext context, String? val) {
    if (val!.isEmpty) {
      return null;
    }

    if (!RegExp('^[A-Za-z ]{1,50}\$').hasMatch(val!)) {
      return 'Should contain only characters';
    }
    return null;
  }

  FocusNode? enterSankalpWishFocusNode;
  TextEditingController? enterSankalpWishTextController;

  // State field(s) for EnterDateofBirth widget.
  FocusNode? enterDateofBirthFocusNode;
  TextEditingController? enterDateofBirthTextController;
  String? Function(BuildContext, String?)?
      enterDateofBirthTextControllerValidator;
  // State field(s) for EnterMothersName widget.
  FocusNode? enterMothersNameFocusNode;
  TextEditingController? enterMothersNameTextController;

  // State field(s) for EnterFathersName widget.
  FocusNode? enterFathersNameFocusNode;
  TextEditingController? enterFathersNameTextController;

  DateTime? datePicked1;
  // State field(s) for TimeofBirth widget.
  FocusNode? timeofBirthFocusNode;
  TextEditingController? timeofBirthTextController;
  String? Function(BuildContext, String?)? timeofBirthTextControllerValidator;
  DateTime? datePicked2;
  // State field(s) for EnterPlaceofBirth widget.
  FocusNode? enterPlaceofBirthFocusNode;
  TextEditingController? enterPlaceofBirthTextController;
  String? Function(BuildContext, String?)?
      enterPlaceofBirthTextControllerValidator;
  // State field(s) for EnterGotraClanName widget.
  FocusNode? enterGotraClanNameFocusNode;
  TextEditingController? enterGotraClanNameTextController;
  String? Function(BuildContext, String?)?
      enterGotraClanNameTextControllerValidator;
  bool isDataUploading = false;
  FFUploadedFile uploadedLocalFile =
      FFUploadedFile(bytes: Uint8List.fromList([]));

  // State field(s) for EnterSpecialInstructions widget.
  FocusNode? enterSpecialInstructionsFocusNode;
  TextEditingController? enterSpecialInstructionsTextController;
  String? Function(BuildContext, String?)?
      enterSpecialInstructionsTextControllerValidator;
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
    enterNameFocusNode?.dispose();
    enterNameTextController?.dispose();

    enterSankalpWishFocusNode?.dispose();
    enterSankalpWishTextController?.dispose();

    enterDateofBirthFocusNode?.dispose();
    enterDateofBirthTextController?.dispose();

    enterMothersNameFocusNode?.dispose();
    enterMothersNameTextController?.dispose();

    enterFathersNameFocusNode?.dispose();
    enterFathersNameTextController?.dispose();

    timeofBirthFocusNode?.dispose();
    timeofBirthTextController?.dispose();

    enterPlaceofBirthFocusNode?.dispose();
    enterPlaceofBirthTextController?.dispose();

    enterGotraClanNameFocusNode?.dispose();
    enterGotraClanNameTextController?.dispose();

    enterSpecialInstructionsFocusNode?.dispose();
    enterSpecialInstructionsTextController?.dispose();

    expandableExpandableController2.dispose();
    expandableExpandableController3.dispose();
  }
}
