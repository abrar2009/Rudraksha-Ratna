/*
// Automatic FlutterFlow imports
import '/backend/schema/structs/index.dart';
import 'package:flutter/material.dart';
// Begin custom widget code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '/backend/api_requests/api_calls.dart';

class QuantityCounterWidget extends StatefulWidget {
  final double width;
  final double height;
  final String hosturl;
  final String? token;
  final String cartId;
  final int initialQuantity;
  final int currentStock;

  const QuantityCounterWidget({
    Key? key,
    required this.width,
    required this.height,
    required this.hosturl,
    this.token,
    required this.cartId,
    required this.initialQuantity,
    required this.currentStock,
  }) : super(key: key);

  @override
  _QuantityCounterWidgetState createState() => _QuantityCounterWidgetState();
}

class _QuantityCounterWidgetState extends State<QuantityCounterWidget> {
  late int _count;

  @override
  void initState() {
    super.initState();
    _count = widget.initialQuantity;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      height: widget.height,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: Color(0xFFE7E7E8),
          width: 1,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: 35,
            height: widget.height,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                bottomLeft: Radius.circular(10),
              ),
              border: Border(
                left: BorderSide(
                  color: Color(0xFFE7E7E8),
                  width: 1,
                ),
                right: BorderSide(
                  color: Color(0xFFE7E7E8),
                  width: 1,
                ),
                top: BorderSide(
                  color: Color(0xFFE7E7E8),
                  width: 1,
                ),
                bottom: BorderSide(
                  color: Color(0xFFE7E7E8),
                  width: 1,
                ),
              ),
            ),
            child: IconButton(
              icon: FaIcon(
                FontAwesomeIcons.minus,
                color: Colors.black,
                size: 15,
              ),
              onPressed: _count > 1 ? () => _updateCount(_count - 1) : null,
            ),
          ),
          Container(
            width: widget.width - 77, // Adjust width based on your preference
            height: widget.height,
            alignment: Alignment.center,
            child: Text(
              _count.toString(),
              style: TextStyle(
                fontFamily: 'Outfit',
                color: Colors.black,
                fontSize: 18,
                letterSpacing: 0,
              ),
            ),
          ),
          Container(
            width: 40,
            height: widget.height,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(10),
                bottomRight: Radius.circular(10),
              ),
              border: Border(
                left: BorderSide(
                  color: Color(0xFFE7E7E8),
                  width: 1,
                ),
                right: BorderSide(
                  color: Color(0xFFE7E7E8),
                  width: 1,
                ),
                top: BorderSide(
                  color: Color(0xFFE7E7E8),
                  width: 1,
                ),
                bottom: BorderSide(
                  color: Color(0xFFE7E7E8),
                  width: 1,
                ),
              ),
            ),
            child: IconButton(
              icon: FaIcon(
                FontAwesomeIcons.plus,
                color: Colors.black,
                size: 15,
              ),
              onPressed: _count < widget.currentStock
                  ? () => _updateCount(_count + 1)
                  : () => _showSnackBar(
                      'Selected quantity is greater than the available stock!'),
            ),
          ),
        ],
      ),
    );
  }

  void _updateCount(int newCount) async {
    setState(() {
      _count = newCount;
    });

    final apiResult = await UpdateCartCall.call(
      hosturl: widget.hosturl,
      token: widget.token,
      cartId: widget.cartId,
      quantity: newCount.toString(),
    );
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Color(0xFFfc100d),
      ),
    );
  }
}
*/


import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../flutter_flow/flutter_flow_util.dart';
import '/backend/api_requests/api_calls.dart';

class QuantityCounterWidget extends StatefulWidget {
  final double width;
  final double height;
  final String hosturl;
  final String? token;
  final String cartId;
  final int initialQuantity;
  final int currentStock;

  const QuantityCounterWidget({
    Key? key,
    required this.width,
    required this.height,
    required this.hosturl,
    this.token,
    required this.cartId,
    required this.initialQuantity,
    required this.currentStock,
  }) : super(key: key);

  @override
  _QuantityCounterWidgetState createState() => _QuantityCounterWidgetState();
}

class _QuantityCounterWidgetState extends State<QuantityCounterWidget> {
  late int _count;

  @override
  void initState() {
    super.initState();
    _count = widget.initialQuantity;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      height: widget.height,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: Color(0xFFE7E7E8),
          width: 1,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: 35,
            height: widget.height,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                bottomLeft: Radius.circular(10),
              ),
              border: Border(
                left: BorderSide(
                  color: Color(0xFFE7E7E8),
                  width: 1,
                ),
                right: BorderSide(
                  color: Color(0xFFE7E7E8),
                  width: 1,
                ),
                top: BorderSide(
                  color: Color(0xFFE7E7E8),
                  width: 1,
                ),
                bottom: BorderSide(
                  color: Color(0xFFE7E7E8),
                  width: 1,
                ),
              ),
            ),
            child: IconButton(
              icon: FaIcon(
                FontAwesomeIcons.minus,
                color: Colors.black,
                size: 15,
              ),
              onPressed: _count > 1 ? () => _updateCount(_count - 1) : null,
            ),
          ),
          Container(
            width: widget.width - 77, // Adjust width based on your preference
            height: widget.height,
            alignment: Alignment.center,
            child: Text(
              _count.toString(),
              style: TextStyle(
                fontFamily: 'Outfit',
                color: Colors.black,
                fontSize: 18,
                letterSpacing: 0,
              ),
            ),
          ),
          Container(
            width: 40,
            height: widget.height,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(10),
                bottomRight: Radius.circular(10),
              ),
              border: Border(
                left: BorderSide(
                  color: Color(0xFFE7E7E8),
                  width: 1,
                ),
                right: BorderSide(
                  color: Color(0xFFE7E7E8),
                  width: 1,
                ),
                top: BorderSide(
                  color: Color(0xFFE7E7E8),
                  width: 1,
                ),
                bottom: BorderSide(
                  color: Color(0xFFE7E7E8),
                  width: 1,
                ),
              ),
            ),
            child: IconButton(
              icon: FaIcon(
                FontAwesomeIcons.plus,
                color: Colors.black,
                size: 15,
              ),
              onPressed: _count < widget.currentStock
                  ? () => _updateCount(_count + 1)
                  : () => _showSnackBar('Selected quantity is greater than the available stock!'),
            ),
          ),
        ],
      ),
    );
  }

  void _updateCount(int newCount) async {
    setState(() {
      _count = newCount;
    });

    // Update cart API call
    await UpdateCartCall.call(
      hosturl: widget.hosturl,
      token: widget.token,
      cartId: widget.cartId,
      quantity: newCount,
    );

    // Refresh cart list API call
    /*await CartCall.call(
      hosturl: widget.hosturl,
      token: widget.token,
    );*/
    final cartResponse = await CartCall.call(
      hosturl: widget.hosturl,
      token: widget.token,
    );

    if (cartResponse != null && cartResponse.succeeded) {
      final cartTotal = getJsonField(cartResponse.jsonBody, r'''$.cart_total''');
      if (cartTotal != null) {
        FFAppState().updatedCartTotal = cartTotal;
      }
    } else {
      // Handle the error case here if necessary
      FFAppState().updatedCartTotal = getJsonField(cartResponse.jsonBody, r'''$.cart_total''');
      print('Error');
    }
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Color(0xFFfc100d),
      ),
    );
  }
}
