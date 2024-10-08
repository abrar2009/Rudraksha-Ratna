import 'dart:convert';
import 'dart:math' as math;
import 'package:encrypt/encrypt.dart';
import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'flutter_flow_util.dart';
import 'package:encrypt/encrypt.dart' as encrypt;

String? chipsId(
  String category,
  List<dynamic> categoryData,
) {
  for (var item in categoryData) {
    if (item['category'] == category) {
      return item['id'].toString();
    }
  }
  return null;
}

String? operatorRemover(String? countryCode) {
  if (countryCode == null) {
    return null;
  }
  return countryCode.replaceAll('+', '');
}

List<String>? countryCodes() {
  /// MODIFY CODE ONLY BELOW THIS LINE
  List<String> _countryCodes = [
    '+91', '+355', '+213', '+1-684', '+376', '+244', '+1-264', '+672', '+1-268', '+54', '+374', '+297', '+61',
    '+43', '+994', '+1-242', '+973', '+880', '+1-246', '+375', '+32', '+501', '+229', '+1-441', '+975', '+591',
    '+387', '+267', '+55', '+246', '+1-284', '+673', '+359', '+226', '+257', '+855', '+237', '+1', '+238',
    '+1-345', '+236', '+235', '+56', '+86', '+61', '+61', '+57', '+269', '+682', '+506', '+385', '+53', '+599',
    '+357', '+420', '+243', '+45', '+253', '+1-767', '+1-809', '+1-829', '+1-849', '+670', '+593', '+20', '+503',
    '+240', '+291', '+372', '+251', '+500', '+298', '+679', '+358', '+33', '+689', '+241', '+220', '+995', '+49',
    '+233', '+350', '+30', '+299', '+1-473', '+1-671', '+502', '+44-1481', '+224', '+245', '+592', '+509', '+504',
    '+852', '+36', '+354', '+93', '+62', '+98', '+964', '+353', '+44-1624', '+972', '+39', '+225', '+1-876', '+81',
    '+44-1534', '+962', '+7', '+254', '+686', '+383', '+965', '+996', '+856', '+371', '+961', '+266', '+231', '+218',
    '+423', '+370', '+352', '+853', '+389', '+261', '+265', '+60', '+960', '+223', '+356', '+692', '+222', '+230',
    '+262', '+52', '+691', '+373', '+377', '+976', '+382', '+1-664', '+212', '+258', '+95', '+264', '+674', '+977',
    '+31', '+599', '+687', '+64', '+505', '+227', '+234', '+683', '+850', '+1-670', '+47', '+968', '+92', '+680',
    '+970', '+507', '+675', '+595', '+51', '+63', '+64', '+48', '+351', '+1-787', '+1-939', '+974', '+242', '+262',
    '+40', '+7', '+250', '+590', '+290', '+1-869', '+1-758', '+590', '+508', '+1-784', '+685', '+378', '+239', '+966',
    '+221', '+381', '+248', '+232', '+65', '+1-721', '+421', '+386', '+677', '+252', '+27', '+82', '+211', '+34', '+94',
    '+249', '+597', '+47', '+268', '+46', '+41', '+963', '+886', '+992', '+255', '+66', '+228', '+690', '+676', '+1-868',
    '+216', '+90', '+993', '+1-649', '+688', '+1-340', '+256', '+380', '+971', '+44', '+1', '+598'
  ];

  return _countryCodes;
  /// MODIFY CODE ONLY ABOVE THIS LINE
}

List<String>? countryNameSelector() {
  /// MODIFY CODE ONLY BELOW THIS LINE
  List<String> countryNames = [
    'Afghanistan', 'Albania', 'Algeria', 'Andorra', 'Angola', 'Antigua and Barbuda', 'Argentina', 'Armenia',
    'Australia', 'Austria', 'Austrian Empire*', 'Azerbaijan', 'Baden*', 'Bahamas, The', 'Bahrain', 'Bangladesh',
    'Barbados', 'Bavaria*', 'Belarus', 'Belgium', 'Belize', 'Benin (Dahomey)', 'Bolivia', 'Bosnia and Herzegovina',
    'Botswana', 'Brazil', 'Brunei', 'Brunswick and Lüneburg*', 'Bulgaria', 'Burkina Faso (Upper Volta)', 'Burma',
    'Burundi', 'Cabo Verde', 'Cambodia', 'Cameroon', 'Canada', 'Cayman Islands, The', 'Central African Republic',
    'Central American Federation*', 'Chad', 'Chile', 'China', 'Colombia', 'Comoros', 'Congo Free State, The*',
    'Costa Rica', 'Cote d’Ivoire (Ivory Coast)', 'Croatia', 'Cuba', 'Cyprus', 'Czechia', 'Czechoslovakia*',
    'Democratic Republic of the Congo', 'Denmark', 'Djibouti', 'Dominica', 'Dominican Republic', 'Duchy of Parma, The*',
    'East Germany (German Democratic Republic)*', 'Ecuador', 'Egypt', 'El Salvador', 'Equatorial Guinea', 'Eritrea',
    'Estonia', 'Eswatini', 'Ethiopia', 'Federal Government of Germany (1848-49)*', 'Fiji', 'Finland', 'France',
    'Gabon', 'Gambia, The', 'Georgia', 'Germany', 'Ghana', 'Grand Duchy of Tuscany, The*', 'Greece', 'Grenada',
    'Guatemala', 'Guinea', 'Guinea-Bissau', 'Guyana', 'Haiti', 'Hanover*', 'Hanseatic Republics*', 'Hawaii*', 'Hesse*',
    'Holy See', 'Honduras', 'Hungary', 'Iceland', 'India', 'Indonesia', 'Iran', 'Iraq', 'Ireland', 'Israel', 'Italy',
    'Jamaica', 'Japan', 'Jordan', 'Kazakhstan', 'Kenya', 'Kingdom of Serbia/Yugoslavia*', 'Kiribati', 'Korea',
    'Kosovo', 'Kuwait', 'Kyrgyzstan', 'Laos', 'Latvia', 'Lebanon', 'Lesotho', 'Lew Chew (Loochoo)*', 'Liberia', 'Libya',
    'Liechtenstein', 'Lithuania', 'Luxembourg', 'Madagascar', 'Malawi', 'Malaysia', 'Maldives', 'Mali', 'Malta',
    'Marshall Islands', 'Mauritania', 'Mauritius', 'Mecklenburg-Schwerin*', 'Mecklenburg-Strelitz*', 'Mexico',
    'Micronesia', 'Moldova', 'Monaco', 'Mongolia', 'Montenegro', 'Morocco', 'Mozambique', 'Namibia', 'Nassau*', 'Nauru',
    'Nepal', 'Netherlands, The', 'New Zealand', 'Nicaragua', 'Niger', 'Nigeria', 'North German Confederation*',
    'North German Union*', 'North Macedonia', 'Norway', 'Oldenburg*', 'Oman', 'Orange Free State*', 'Pakistan', 'Palau',
    'Panama', 'Papal States*', 'Papua New Guinea', 'Paraguay', 'Peru', 'Philippines', 'Piedmont-Sardinia*', 'Poland',
    'Portugal', 'Qatar', 'Republic of Genoa*', 'Republic of Korea (South Korea)', 'Republic of the Congo', 'Romania',
    'Russia', 'Rwanda', 'Saint Kitts and Nevis', 'Saint Lucia', 'Saint Vincent and the Grenadines', 'Samoa', 'San Marino',
    'Sao Tome and Principe', 'Saudi Arabia', 'Schaumburg-Lippe*', 'Senegal', 'Serbia', 'Seychelles', 'Sierra Leone',
    'Singapore', 'Slovakia', 'Slovenia', 'Solomon Islands, The', 'Somalia', 'South Africa', 'South Sudan', 'Spain',
    'Sri Lanka', 'Sudan', 'Suriname', 'Sweden', 'Switzerland', 'Syria', 'Tajikistan', 'Tanzania', 'Texas*', 'Thailand',
    'Timor-Leste', 'Togo', 'Tonga', 'Trinidad and Tobago', 'Tunisia', 'Turkey', 'Turkmenistan', 'Tuvalu', 'Two Sicilies*',
    'Uganda', 'Ukraine', 'Union of Soviet Socialist Republics*', 'United Arab Emirates, The', 'United Kingdom, The',
    'Uruguay', 'Uzbekistan', 'Vanuatu', 'Venezuela', 'Vietnam', 'Württemberg*', 'Yemen', 'Zambia', 'Zimbabwe'
  ];

  return countryNames;
  /// MODIFY CODE ONLY ABOVE THIS LINE
}


double parsePriceRange(String? priceRange) {
  if (priceRange == null || priceRange.isEmpty) {
    return 0.0;
  }
  try {
    return double.parse(priceRange);
  } catch (e) {
    // Handle any parsing errors here
    print("Error parsing priceRange: $e");
    return 0.0;
  }
}
String? joinName(
    String firstName,
    String lastName,
    ) {
  if (firstName.isEmpty || lastName.isEmpty) {
    return null;
  }
  return '$firstName $lastName';
}

int? countryIdByName(
    List<dynamic>? countries,
    String? countryName,
    ) {
  for (var country in countries!) {
    if (country['name'] == countryName) {
      return country['id'];
    }
  }
  return null;
}

int? stateIdByName(
    List<dynamic>? states,
    String? stateNames,
    ) {
  for (var country in states!) {
    if (country['name'] == stateNames) {
      return country['id'];
    }
  }
  return null;
}

String? editAddressById(
    int id,
    List<dynamic> data,
    String? fieldName,
    ) {
  final address =
  data.firstWhere((element) => element['id'] == id, orElse: () => null);

  if (address == null) {
    return 'Not found';
  }

  // Return the value of the specified field
  return address[fieldName]?.toString();
}

List<String>? splitName(String? name) {
  final nameParts = name!.split(' ');
  final firstName = nameParts.isNotEmpty ? nameParts.first : '';
  final lastName = nameParts.length > 1 ? nameParts.sublist(1).join(' ') : '';
  return [firstName, lastName];
}

String formatPriceWithCommas(double price) {
  final NumberFormat formatter = NumberFormat.decimalPattern('en_IN');
  return formatter.format(price);
}

double? currencyConversion(
    double num1,
    String num2,
    ) {
  try {
    double number2 = double.parse(num2);
    double result = num1 * number2;
    return result;
  } catch (e) {
    return null;
  }
}

double? currencyRateByName(
    List<dynamic> currencies,
    String currencyType,
    ) {
  for (var item in currencies) {
    if (item['currency_type'] == currencyType) {
      return item['conversion_rate'];
    }
  }
  return null;
}

String formatPriceRange(String priceRange, double conversionRate) {
  // Check if the price is a range
  if (priceRange.contains('-')) {
    // Split the range into two parts
    List<String> parts = priceRange.split('-');
    // Parse both parts to double and apply conversion rate
    double startPrice = double.parse(parts[0].trim()) * conversionRate;
    double endPrice = double.parse(parts[1].trim()) * conversionRate;
    // Format the converted prices
    String formattedStartPrice = formatNumber(
      startPrice,
      formatType: FormatType.decimal,
      decimalType: DecimalType.automatic,
    );
    String formattedEndPrice = formatNumber(
      endPrice,
      formatType: FormatType.decimal,
      decimalType: DecimalType.automatic,
    );
    // Return the formatted range
    return '$formattedStartPrice - $formattedEndPrice';
  } else {
    // If it's not a range, simply apply conversion and format the price
    double price = parsePriceRange(priceRange) * conversionRate;
    return formatNumber(
      price,
      formatType: FormatType.decimal,
      decimalType: DecimalType.automatic,
    );
  }
}

String? mobilemenurefername(
    String? productname,
    dynamic jsondata,
    ) {
  // Ensure productname is not null
  if (productname == null || jsondata == null) {
    return null;
  }

  // Access the data list from jsondata
  var dataList = jsondata['data'];

  // Iterate over the data list to find the refer_name
  for (var item in dataList) {
    if (item['name'] == productname) {
      return item['refer_name'];
    }
  }

  return null;
}

int? stringtoIntFunction(String? numberstring) {
  // string to integer converter
  return int.tryParse(numberstring ?? '');
}


String? joinAddress(
    String? address1,
    String? address2,
    String? city,
    String? state,
    String? pinCode,
    String? name,
    String? email,
    String? contact,
    String? country,
    ) {
  /// MODIFY CODE ONLY BELOW THIS LINE

  final components = [
    if (name != null && name.isNotEmpty) 'Name: $name',
    if (email != null && email.isNotEmpty) 'Email: $email',
    if (contact != null && contact.isNotEmpty) 'Contact No.: $contact',
    if (address1 != null && address1.isNotEmpty) 'Address Line 1: $address1',
    if (address2 != null && address2.isNotEmpty) 'Address Line 2: $address2',
    if (country != null && country.isNotEmpty) 'Country: $country',
    if (state != null && state.isNotEmpty) 'State: $state',
    if (city != null && city.isNotEmpty) 'City: $city',
    if (pinCode != null && pinCode.isNotEmpty) 'Pincode: $pinCode',
  ];

  return components.isNotEmpty ? "'${components.join(', ')}'" : null;

  /// MODIFY CODE ONLY ABOVE THIS LINE
}

String? nameSeparator(
    String? fullName,
    String? nameType,
    ) {
  /// MODIFY CODE ONLY BELOW THIS LINE

// Split the full name by spaces
  List<String> nameParts = fullName!.trim().split(' ');

  // Check the nameType and return the appropriate part
  if (nameType == 'first') {
    return nameParts.isNotEmpty ? nameParts.first : null;
  } else if (nameType == 'last') {
    return nameParts.length > 1 ? nameParts.sublist(1).join(' ') : null;
  }

  // If nameType is neither 'first' nor 'last', return null
  return null;

  /// MODIFY CODE ONLY ABOVE THIS LINE
}



int? productIdbyName(
    List<dynamic>? productData,
    String? productName,
    ) {
  /// MODIFY CODE ONLY BELOW THIS LINE

  for (var product in productData!) {
    if (product['productname'] == productName) {
      return product['id']; // Return the product id as a string
    }
  }
  return null;

  /// MODIFY CODE ONLY ABOVE THIS LINE
}


double? stringtodouble(String? number) {
  if (number == null) {
    print('The input string is null.');
    return null;
  }

  // Try to parse the string to a double
  final parsedNumber = double.tryParse(number);

  if (parsedNumber == null) {
    print('The input string could not be parsed to a double.');
  }

  return parsedNumber;
}

String calculateDateDisplay(String createdAt) {
  DateTime createdAtDate = DateTime.parse(createdAt);
  Duration difference = DateTime.now().difference(createdAtDate);

  if (difference.inDays >= 365) {
    // More than a year
    int years = (difference.inDays / 365).floor();
    return years == 1 ? '1 year ago' : '$years years ago';
  } else if (difference.inDays >= 30) {
    // More than a month
    int months = (difference.inDays / 30).floor();
    return months == 1 ? '1 month ago' : '$months months ago';
  } else if (difference.inDays >= 7) {
    // More than a week
    int weeks = (difference.inDays / 7).floor();
    return weeks == 1 ? '1 week ago' : '$weeks weeks ago';
  } else if (difference.inDays >= 2) {
    // More than two days
    return '${difference.inDays} days ago';
  } else if (difference.inDays >= 1) {
    // Yesterday
    return 'Yesterday';
  } else if (difference.inHours >= 1) {
    // Hours ago
    return '${difference.inHours} hours ago';
  } else {
    // Minutes ago
    return '${difference.inMinutes} minutes ago';
  }
}

/*String calculateDateDisplay(String createdAt) {
  DateTime createdAtDate = DateTime.parse(createdAt);
  Duration difference = DateTime.now().difference(createdAtDate);

  if (difference.inDays >= 2) {
    return '${difference.inDays} days ago';
  } else if (difference.inDays >= 1) {
    return 'Yesterday';
  } else {
    return 'Today';
  }
}*/

String? cartBadgeCount(dynamic jsonResponse) {
  try {
    // Check if jsonResponse is already a Map or String
    Map<String, dynamic> parsed;

    if (jsonResponse is String) {
      // If it's a String, parse it
      parsed = json.decode(jsonResponse) as Map<String, dynamic>;
    } else if (jsonResponse is Map<String, dynamic>) {
      // If it's already a Map, use it directly
      parsed = jsonResponse;
    } else {
      // Handle unexpected types
      print('Unexpected type: ${jsonResponse.runtimeType}');
      return null;
    }

    // Extract the 'data' list
    final data = parsed['data'] as List<dynamic>;

    // Return the number of items in the 'data' list as a string
    return data.length.toString();
  } catch (e) {
    print('Error parsing JSON: $e');
    return null;
  }
}

String formatDate(String dateTimeString) {
  final DateTime dateTime = DateTime.parse(dateTimeString);
  final DateFormat formatter = DateFormat('yyyy-MM-dd');
  return formatter.format(dateTime);
}

List<String> parseImageUrls(dynamic data) {
  if (data is String) {
    return [data]; // Single string as a list with one item
  } else if (data is List) {
    return List<String>.from(data); // List of strings
  }
  return []; // Default to empty list if data is neither a string nor a list
}

int getIndexByName(List<dynamic> selectVariation, String energizationName) {
  for (int i = 0; i < selectVariation.length; i++) {
    if (getJsonField(selectVariation[i], r'''$.name''').toString() == energizationName) {
      return i; // Return the index if a match is found
    }
  }
  return -1; // Return -1 if no match is found
}

String decodeBase64(String encodedText) {
  // Decode the base64 encoded string
  final decodedBytes = base64Decode(encodedText);
  // Convert bytes to string
  return utf8.decode(decodedBytes);
}

String decryptData(String encryptedData) {
  const farnetkey = 'D3KyP1sPstZZa4Yf2u0E0unfXgR9L5s2iIpoU-W5_Yc=';
  final key = encrypt.Key.fromBase64(farnetkey);

  final b64key =
  encrypt.Key.fromBase64(base64Url.encode(key.bytes));

  final fernet = encrypt.Fernet(b64key);

  final encrypter = encrypt.Encrypter(fernet);

  final decrypted= encrypter.decrypt64(encryptedData);

  return decrypted;
}

decryptFernet(plainText){
  final key = Key.fromUtf8('D3KyP1sPstZZa4Yf2u0E0unfXgR9L5s2iIpoU-W5_Yc=');
  final iv = IV.fromLength(16);
  final b64key = Key.fromUtf8(base64Url.encode(key.bytes));
  final fernet = Fernet(b64key);
  final encrypter = Encrypter(fernet);
  //fernetDecrypted = encrypter.decrypt(fernetEncrypted!);
  //print(fernetDecrypted);
}


