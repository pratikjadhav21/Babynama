import 'package:babynama/hear_from_parents.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'globals.dart' as globals;
import 'thanku_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent, // transparent status bar
  ));
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Baby Care App',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        scrollbarTheme: ScrollbarThemeData(
          thumbColor: MaterialStateProperty.all<Color>(Colors.deepPurple), // Set the thumb color
          trackColor: MaterialStateProperty.all<Color>(Colors.grey), // Set the track color
        ),

      ),
      home: BabyCareScreen(),
      routes: {
        '/thanku': (context) => ThankYouPage(title: "title"),
    },
    );
  }
}

class BabyCareScreen extends StatefulWidget {
  @override
  _BabyCareScreenState createState() => _BabyCareScreenState();
}

class _BabyCareScreenState extends State<BabyCareScreen> {
  // bool isOneMonthSelected = true;
  List<BabyCarePlan> plans = [
    BabyCarePlan(
      planName: 'Basic Care',
      planDescription: [
        'Pediatric care in 15 minutes',
        'Instant chat with pediatricians on WhatsApp',
        'Free pediatrician consultations (day)',
        'Live Yoga Sessions',
      ],
      oneMonthPrice: 999.00,
      threeMonthsPrice: 2499,
      color: Colors.green,
      colorDescription: Colors.green.shade300,
    ),
    BabyCarePlan(
      planName: 'Prime Care',
      planDescription: [
        'Pediatric care in 15 minutes, lactation, nutrition, monthly milestones, emergency support',
        'Everything in Basic Care',
        '24x7 free pediatrician consultations',
        'Monthly growth and milestones tracking by pediatrician',
        'Lactation and Weaning Support',
      ],
      oneMonthPrice: 1999,
      threeMonthsPrice: 4999,
      color: Colors.orange,
      colorDescription: Colors.orange.shade300,
    ),
    BabyCarePlan(
      planName: 'Holistic Care',
      planDescription: [
        'Dedicated pediatrician for your baby, personal care plan, Best possible baby care',
        'Everything included in the PRIME Plan',
        'Dedicated pediatrician just for your baby',
        'Personalized care plan for your baby and you',
        'All Consultations and workshops free*',
        'We keep adding new services to provide more value to you',
      ],
      oneMonthPrice: 3998,
      threeMonthsPrice: 9999,
      color: Colors.purple,
      colorDescription: Colors.purple.shade300,
    ),
  ];

  void selectPlan(bool isOneMonth) {
    setState(() {
      globals.isOneMonthSelected = isOneMonth;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // title: Text('Baby Care Plans'),
        centerTitle: true,
        title: Image.asset('assets/logo_babynama.webp', fit: BoxFit.cover, height: 32, ),
        elevation: 10,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              globals.isOneMonthSelected ? '1-Month Plans' : '3-Months Plans',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: plans.length,
                itemBuilder: (context, index) {
                  final plan = plans[index];
                  return PlanCard(
                    planName: plan.planName,
                    planDescription: plan.planDescription,
                    price: globals.isOneMonthSelected ? plan.oneMonthPrice : plan.threeMonthsPrice,
                    color: plan.color,
                    colorDescription: plan.colorDescription,
                  );
                },
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  globals.isOneMonthSelected = !globals.isOneMonthSelected;
                });
              },
              child: Text(
                globals.isOneMonthSelected
                    ? 'View 3-Months Plans'
                    : 'View 1-Month Plans',
                style: TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class BabyCarePlan {
  final String planName;
  final List<String> planDescription;
  final double oneMonthPrice;
  final double threeMonthsPrice;
  final Color color;
  final Color colorDescription;

  BabyCarePlan({
    required this.planName,
    required this.planDescription,
    required this.oneMonthPrice,
    required this.threeMonthsPrice,
    required this.color,
    required this.colorDescription,
  });
}

class PlanCard extends StatelessWidget {
  final String planName;
  final List<String> planDescription;
  final double price;
  final Color color;
  final Color colorDescription;

  PlanCard({
    required this.planName,
    required this.planDescription,
    required this.price,
    required this.color,
    required this.colorDescription,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: color,
      elevation: 8.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                planName,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 8),
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Container(
                  // color: colorDescription,
                  height: 120, // Set a fixed height for initial bullet points
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        color,
                        colorDescription,
                      ],
                      stops: [0.0, 0.5],
                    ),
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: planDescription.length,
                          itemBuilder: (context, index) {
                            final bulletPoint = planDescription[index];
                            return ListTile(
                              leading: Icon(Icons.check, color: Colors.green[900]),
                              title: Text(
                                bulletPoint,
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.white,
                                ),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                  // child: Scrollbar(
                  //   thickness: 5,
                  //   thumbVisibility: true,
                  //   child: SingleChildScrollView(
                  //     child: Column(
                  //       children: [
                  //         ListView.builder(
                  //           shrinkWrap: true,
                  //           physics: NeverScrollableScrollPhysics(),
                  //           itemCount: planDescription.length,
                  //           itemBuilder: (context, index) {
                  //             final bulletPoint = planDescription[index];
                  //             return ListTile(
                  //               leading: Icon(Icons.check, color: Colors.green[900]),
                  //               title: Text(
                  //                 bulletPoint,
                  //                 style: TextStyle(
                  //                   fontSize: 16,
                  //                   color: Colors.white,
                  //                 ),
                  //               ),
                  //             );
                  //           },
                  //         ),
                  //       ],
                  //     ),
                  //   ),
                  // ),
                ),
              ),
              SizedBox(height: 8),
              Text(
                'Price: ₹${price.toStringAsFixed(0)} per ' + (globals.isOneMonthSelected ? '1 ' : '3 ') + (globals.isOneMonthSelected ? 'month' : 'months'),
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ThankYouPage(title: "title")),
                    // MaterialPageRoute(builder: (context) => HearFromParentsPage()),
                  );
                },
                child: Text(
                  'Pay Now',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
