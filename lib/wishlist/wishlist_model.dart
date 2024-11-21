import '/backend/api_requests/api_calls.dart';
import '/components/custom_nav_bar_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'wishlist_widget.dart' show WishlistWidget;
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class WishlistModel extends FlutterFlowModel<WishlistWidget> {
  ///  Local state fields for this page.

  List<int> wishlist = [];
  void addToWishlist(int item) => wishlist.add(item);
  void removeFromWishlist(int item) => wishlist.remove(item);
  void removeAtIndexFromWishlist(int index) => wishlist.removeAt(index);
  void insertAtIndexInWishlist(int index, int item) =>
      wishlist.insert(index, item);
  void updateWishlistAtIndex(int index, Function(int) updateFn) =>
      wishlist[index] = updateFn(wishlist[index]);
  String? producttype;
  int? level;
  bool productlist = true;
  int? mainprodtype;
  ApiCallResponse? apiResulth6o;
  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();
  // Stores action output result for [Backend Call - API (RemovefromWishlist)] action in IconButton widget.
  ApiCallResponse? apiResult5ep;
  // Model for CustomNavBar component.
  late CustomNavBarModel customNavBarModel;

  @override
  void initState(BuildContext context) {
    customNavBarModel = createModel(context, () => CustomNavBarModel());
  }

  @override
  void dispose() {
    unfocusNode.dispose();
    customNavBarModel.dispose();
  }
}
