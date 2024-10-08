import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'DisclaimerModel.dart';


class DisclaimerWidget extends StatefulWidget {
  const DisclaimerWidget({super.key});

  @override
  State<DisclaimerWidget> createState() => _DisclaimerWidgetState();
}

class _DisclaimerWidgetState extends State<DisclaimerWidget> {
  late DisclaimerModel _model;

  final DisclaimerWidgetscaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => DisclaimerModel());
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
        key: DisclaimerWidgetscaffoldKey,
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
                'Disclaimer',
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
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RichText(
                    textScaler: MediaQuery.of(context).textScaler,
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text:
                          'The products and services offered on this website, including but not limited to rudraksha, gems, yantra, parad, puja items, and puja services, are provided for spiritual and religious purposes. It is important to note that these products and services are based on faith and spiritual beliefs and are not medically or legally certified. \n\n While these items and services have been revered in traditional practices and scriptures for their perceived spiritual benefits, their efficacy is subjective and may vary from person to person. \n Any claims or guidance concerning health, well-being, or legal ramifications associated with the utilization of our products or services, as articulated by our team members, affiliates, or subsidiaries, are founded upon traditional beliefs and do not derive support from scientific evidence, medical studies, or legal certifications. It is imperative to recognize that such assertions should not be construed as a substitute for professional medical treatment. \n\n Furthermore, the information provided on this website is for educational and informational purposes only and should not be considered as a substitute for professional medical advice, diagnosis, or treatment. We recommend consulting with a qualified healthcare professional before using any of our products, especially if you have any medical conditions or concerns. \n\n Additionally, the use of our products and services does not guarantee any specific results or outcomes. We do not make any warranties or representations regarding the effectiveness, accuracy, or reliability of our products or services for any particular purpose. \n\n By purchasing and using our products or services, you acknowledge and agree that you are doing so at your own risk and discretion. We shall not be liable for any direct, indirect, incidental, consequential, or punitive damages arising from the use or misuse of our products or services. \n\nThank you for your understanding.',
                          style:
                          FlutterFlowTheme.of(context).bodyMedium.override(
                            fontFamily: 'Montserrat',
                            letterSpacing: 0,
                            lineHeight: 1.5,
                          ),
                        )
                      ],
                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                        fontFamily: 'Montserrat',
                        letterSpacing: 0,
                        lineHeight: 1.5,
                      ),
                    ),
                    textAlign: TextAlign.justify,
                  ),
                  Text(
                    'Gold Price Disclaimer:',
                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                      fontFamily: 'Montserrat',
                      fontSize: 18,
                      letterSpacing: 0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    'Please note that the prices of gold displayed on our website are subject to change without prior notice. Gold prices are influenced by various factors including market demand, geopolitical events, currency fluctuations, and economic conditions. As a result, the prices listed on our website may vary from the time of your purchase to the time of processing. \n\n We make every effort to update our prices regularly to reflect the current market rates. However, due to the dynamic nature of the gold market, it is possible that the price of gold may change even after you have made a purchase. Therefore, the final price of your purchase may differ from the price displayed at the time of order placement. \n\n We appreciate your understanding and cooperation regarding this matter. Should you have any questions or concerns regarding pricing, please feel free to contact us. \n\nThank you for choosing Rudra Centre.',
                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                      fontFamily: 'Montserrat',
                      letterSpacing: 0,
                      lineHeight: 1.5,
                    ),
                    textAlign: TextAlign.justify,
                  ),
                ].divide(SizedBox(height: 16)),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
