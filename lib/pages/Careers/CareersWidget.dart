import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'CareersModel.dart';


class CareersWidget extends StatefulWidget {
  const CareersWidget({super.key});

  @override
  State<CareersWidget> createState() => _CareersWidgetState();
}

class _CareersWidgetState extends State<CareersWidget> {
  late CareersModel _model;

  final CareersWidgetscaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => CareersModel());
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _model.unfocusNode.canRequestFocus
          ? FocusScope.of(context).requestFocus(_model.unfocusNode)
          : FocusScope.of(context).unfocus(),
      child: Scaffold(
        key: CareersWidgetscaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(kToolbarHeight),
          child: Container(
            decoration: BoxDecoration(
              color: FlutterFlowTheme.of(context).secondaryBackground,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.15), // Shadow color with opacity
                  offset: Offset(0, 4), // Move shadow downwards by 4 pixels
                  blurRadius: 6, // Blur radius for a softer shadow
                  spreadRadius: 1, // Spread radius for shadow expansion
                ),
              ],
            ),
            child: AppBar(
              backgroundColor: Colors.white,
              automaticallyImplyLeading: false,
              leading: FlutterFlowIconButton(
                borderColor: Colors.transparent,
                borderRadius: 30,
                borderWidth: 1,
                buttonSize: 60,
                icon: Icon(
                  Icons.arrow_back_rounded,
                  color: Color(0xFF272728),
                  size: 30,
                ),
                onPressed: () async {
                  context.pop();
                },
              ),
              title: Text(
                'Careers',
                style: FlutterFlowTheme.of(context).headlineMedium.override(
                  fontFamily: 'Outfit',
                  color: Color(0xFF272728),
                  fontSize: 16,
                  letterSpacing: 0,
                ),
              ),
              actions: [],
              centerTitle: true,
              elevation: 0,
            ),
          ),
        ),
        body: SafeArea(
          top: true,
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                RichText(
                  textScaler: MediaQuery.of(context).textScaler,
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text:"Rudra Centre is the oldest and the largest spiritual ecommerce store. We deal in products like Rudraksha, Gemstones, Puja Items, Idols, Puja Samagri, Vastu Tools & More & offer services like Chakra Therapy, Astrology, Chakra Vastu & Online Pujas to our global clientele. We are strive towards excellence in Product/Service Development, Customer Service, Supply Chain Management & Customer Satisfaction and are looking for talented individuals who wish to contribute to the same goal and nurture their innate abilities. You shall be working in a liberal atmosphere that expects you to grow your skill set while working for the company, take responsibility for your work, achieve your targets & fulfill your KRAs and most importantly enjoy the work that you do.\n",
                       // 'Rudra Centre is the oldest the largest spiritual ecommerce store. We deal in products like Rudraksha, Cemstones, Puja\nItems, Idols, Puja Samagri, Vastu Tools & More\n& offer services like Chakra Therapy, Astrology,\nChakra Vastu & Online Pujas to our global\nclientele. We are strive towards excellence in\nProduct/Service Development, Customer\nService, Supply Chain Management &\nCustomer Satisfaction and are looking for talented individuals who wish to contribute\nto the same goal and nurture their innate\nabilities. You shall be working in a liberal\natmosphere that expects you to grow your\nskill set while working for the company, take\nresponsibility for your work, achieve your\ntargets & fulfill your KRAs end most\nimportantly enjoy the work that you do. For any career related queries, please email\n ',
                        style: FlutterFlowTheme.of(context)
                            .bodyMedium
                            .override(
                          fontFamily: 'Montserrat',
                          color: Color(0xFF575758),
                          fontSize: 15,
                          letterSpacing: 0,
                          fontWeight: FontWeight.normal,
                          lineHeight: 1.5,
                        ),
                      ),
                      TextSpan(
                        text: 'hr@rudracentre.com',
                        style: TextStyle(
                          color: FlutterFlowTheme.of(context).primary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      TextSpan(
                        text: ' or Call at ',
                        style: TextStyle(),
                      ),
                      TextSpan(
                        text: '+91 9321011323',
                        style: TextStyle(
                          color: FlutterFlowTheme.of(context).primary,
                          fontWeight: FontWeight.w600,
                        ),
                      )
                    ],
                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                      fontFamily: 'Montserrat',
                      letterSpacing: 0,
                      lineHeight: 1.5,
                    ),
                  ),
                    textAlign: TextAlign.justify
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
