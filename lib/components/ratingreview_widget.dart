import 'package:rudraksha_cart/components/reviewrating_model.dart';

import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';



class RatingreviewWidget extends StatefulWidget {
  const RatingreviewWidget({
    super.key,
    this.parameter1,
  });

  final dynamic parameter1;

  @override
  State<RatingreviewWidget> createState() => _RatingreviewWidgetState();
}

class _RatingreviewWidgetState extends State<RatingreviewWidget> {
  late RatingreviewModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => RatingreviewModel());
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RatingBar.builder(
      onRatingUpdate: (newValue) =>
          setState(() => _model.ratingBarValue = newValue),
      itemBuilder: (context, index) => Icon(
        Icons.star_rounded,
        color: FlutterFlowTheme.of(context).tertiary,
      ),
      direction: Axis.horizontal,
      initialRating: _model.ratingBarValue ??=
      functions.stringtodouble(widget!.parameter1?.toString())!,
      unratedColor: FlutterFlowTheme.of(context).accent3,
      itemCount: 5,
      itemSize: 18,
      glowColor: FlutterFlowTheme.of(context).tertiary,
    );
  }
}
