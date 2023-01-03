import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

final nameController = TextEditingController();
final emailController = TextEditingController();
final phoneController = TextEditingController();
final dateinput = TextEditingController();
final dateController = TextEditingController();

class Conrats extends StatefulWidget {
  const Conrats({Key? key}) : super(key: key);

  @override
  State<Conrats> createState() => _ConratsState();
}

class _ConratsState extends State<Conrats> {
  void initState() {
    print("init calling");
    super.initState();
    splashScreenDelay();
  }

  splashScreenDelay() async {
    ///
    /// splash screen delay
    ///
    await Future.delayed(Duration(seconds: 8));
    SystemNavigator. pop();
    // Navigator.push(context, MaterialPageRoute(builder: (context)=>AuthScreen()));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text("Conratulation"),
      ),
      body: Center(child: Container(
        decoration: BoxDecoration(
          color: Colors.orangeAccent,
          borderRadius: BorderRadius.circular(10),
        ),

        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Congratulation",
              style: TextStyle(
                fontSize: 30,
              ),),
            Text("You will recive your payment in 12 hours.",
            style: TextStyle(
                fontSize: 30,
            ),
            textAlign: TextAlign.center,
            ),
          ],
        ),
      ),

      ),
    );
  }
}

Widget bookingDetail(String heading, String value) {
  return Column(
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(heading),
          Text(
            value,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
      SizedBox(
        height: 20,
      ),
    ],
  );
}
