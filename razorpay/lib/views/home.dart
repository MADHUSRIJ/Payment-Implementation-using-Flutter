import 'package:flutter/material.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late Razorpay razorpay;

  TextEditingController _t = new TextEditingController();

  String? s;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    razorpay = new Razorpay();

    razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, handlerPaymentSuccess);
    razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, handlerErrorFailure);
    razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, handlerExternalWallet);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    razorpay.clear();
  }

  void openCheckout() {
    var options = {
      "key": "rzp_test_MmymHvOivWWfRa",
      "amount": s,
      "name": "Razor Pay",
      "description": "Payment implementation",
      "prefill": {
        "contact": "9360224171",
        "email": "srimadhu.j@gmail.com",
      },
      "external": {
        "wallets": ["paytm"]
      },
    };

    try {
      razorpay.open(options);
    } catch (e) {
      print("Errrrrorrrrrrrr" + e.toString());
    }
  }

  void handlerPaymentSuccess() {
    print("Payment Successful");
  }

  void handlerErrorFailure() {
    print("Payment Error");
  }

  void handlerExternalWallet() {
    print("External Wallet");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Razor Pay"),
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(30.0),
              child: TextField(
                controller: _t,
                onChanged: (val) {
                  setState(() {
                    s = val + "00";
                  });
                },
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(width: 1, color: Colors.blue)),
                    hintText: "Enter the amount"),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            RaisedButton(
              onPressed: () {
                openCheckout();
              },
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: Text(
                  "Pay Now",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              ),
              color: Colors.blue,
            )
          ],
        ));
  }
}
