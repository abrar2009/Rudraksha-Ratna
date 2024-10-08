import 'package:flutter/material.dart';
import 'flutter_flow/flutter_flow_util.dart';

abstract class FFAppConstants {
  static const String sanityurl = 'https://sanity-admin.rudraksha-ratna.com/api';
  static const String hosturl = 'https://sanity-admin.rudraksha-ratna.com/api';
  static const String RudrakshaMasterProductDetailsApi = 'rudrakshamaster/ssr-web-rudraksha-product-detail?rudrakshproduct';
  //static const String OtherMasterProductDetailsApi = 'otherproductmaster/web-other-product-detail?otherproduct';
  static const String OtherMasterProductDetailsApi = 'mobileapp/other-product-detail?slug_value';
  static const String GemstoneMasterProductDetailsApi = 'gemstonemaster/ssr-web-gemstone-product-detail?gemstoneproduct';
  static const String YantraMasterProductDetailsApi = 'yantras/ssr-web-yantraproduct-detail?yantraproduct';
  static const String PujaMasterProductDetailsApi = 'mobileapp/puja-product-detail?slug_value';
  static const String currencyApi = '${sanityurl}/pujaenergization/product-hierarchy';

  //network images url constants from live website of Rudraksha-Ratna
  static const String commonImageUrl = 'https://www.rudraksha-ratna.com/assets/shared';
  static const String consultationWithSakhashreereeImageUrl = 'https://www.rudraksha-ratna.com/assets/Consultation/consult-with-sakhashree';
  static const String pujaServicesRecommendationImafeUrl = 'https://www.rudraksha-ratna.com/assets/Consultation/puja-services-recommendation';
  static const String chakraCleansingMeditationWithSakhashree = 'https://www.rudraksha-ratna.com/assets/Consultation/chakra-cleansing-meditation-with-sakhashree';
  static const String consultation = 'https://www.rudraksha-ratna.com/assets/shared/Consultations';
  static const String chakraVastuConsultation = 'https://www.rudraksha-ratna.com/assets/Consultation/chakra-vastu-consultation';
  static const String astrologyConsultation = 'https://www.rudraksha-ratna.com/assets/Consultation/astrology-consultation';
  static const String ourTeam = 'https://www.rudraksha-ratna.com/assets/our-team';
  static const String aboutUs = 'https://www.rudraksha-ratna.com/assets/about-us';
}
