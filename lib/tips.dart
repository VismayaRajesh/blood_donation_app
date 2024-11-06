import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Tips extends StatefulWidget {
  const Tips({super.key});

  @override
  State<Tips> createState() => _TipsState();
}

class _TipsState extends State<Tips> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.white
        ),
        title: Text('Blood Donation Guidelines', style: TextStyle(color: Colors.white, fontSize: 19, fontWeight: FontWeight.w600),),
        backgroundColor: Color(0xFFBB2727),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12.0),
            child: Icon(Icons.help_outline_sharp, size: 24,),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 12.0, right: 12.0, bottom: 10),
        child: ListView(
          children: [
            SectionTitle('Pre-Donation Tips'),
            TipItem('Hydrate Well', 'Drink plenty of water or juice before donating. Avoid caffeinated drinks as they can dehydrate you.'),
            TipItem('Eat Iron-Rich Foods', 'A few days before donating, consume foods rich in iron, such as spinach, beans, and red meat, to maintain your iron levels.'),
            TipItem('Sleep Well', 'Aim for a full night’s rest (7-8 hours) before donating blood to ensure you feel refreshed and ready.'),
            TipItem('Avoid Alcohol', 'Refrain from drinking alcohol for at least 24 hours before your donation, as it can dehydrate you.'),
            TipItem('Wear Comfortable Clothing', 'Wear clothes with sleeves that can be easily rolled up above the elbow for easier access.'),

            SectionTitle('Blood Type Matching'),
            BloodTypeTable(),
            SizedBox(height: 15),

            SectionTitle('Eligibility Requirements'),
            TipItem('Age and Weight', 'Generally, donors should be between 18-65 years old and weigh at least 50 kg (110 lbs).'),
            TipItem('Health Condition', 'Donors should be in good health, free from infections or fevers.'),
            TipItem('Donation Frequency', 'Wait at least 8 weeks between whole blood donations. For platelet or plasma donations, check the specific waiting periods.'),
            TipItem('Travel and Medical History', 'If you have recently traveled to certain areas or have specific medical conditions, you may need to wait before donating.'),
            TipItem('Medications', 'Some medications might make you temporarily ineligible. Consult with the blood donation center if you’re unsure.'),

            SectionTitle('During Donation Tips'),
            TipItem('Relax and Breathe', 'Stay calm, and take deep breaths. Focusing on your breathing can help reduce any anxiety.'),
            TipItem('Follow Instructions', 'Listen carefully to the instructions given by the medical staff. Let them know if you feel uncomfortable at any point.'),
            TipItem('Squeeze the Stress Ball', 'Most centers provide a stress ball to help blood flow. Squeezing it periodically helps the donation process.'),

            SectionTitle('Post-Donation Tips'),
            TipItem('Rest', 'Sit and relax for at least 10-15 minutes after donating.'),
            TipItem('Hydrate and Eat', 'Drink a lot of fluids and have a small snack provided by the center to replenish your energy.'),
            TipItem('Avoid Heavy Lifting and Activities', 'For the next 24 hours, avoid heavy physical exertion to give your body time to recover.'),
            TipItem('Stay in Contact with the Center', 'If you feel unwell after leaving, contact the donation center or your healthcare provider.'),
            TipItem('Monitor the Needle Site', 'Keep an eye on the needle site. If you notice any unusual swelling, redness, or discomfort, inform your healthcare provider.'),
          ],
        ),
      ),
    );
  }

  Widget SectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0, bottom: 5.0),
      child: Column(
        children: [
          Text(
            title,
            style: TextStyle(
              color: Colors.red,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          Divider()
        ],
      ),
    );
  }

  Widget TipItem(String title, String description) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 6),
            child: Text(
              title,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
          ),
          SizedBox(height: 4),
          Padding(
            padding: const EdgeInsets.only(left: 13, right: 13),
            child: Text(
              description,
              style: TextStyle(
                fontSize: 16,
                color: Colors.black54,
              ),
            ),
          ),
        ],
      ),
    );
  }
  Widget BloodTypeTable() {
    return SingleChildScrollView(
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black),
          borderRadius: BorderRadius.circular(5),
        ),
        child: DataTable(
          border: TableBorder(horizontalInside: BorderSide(
            color: Colors.black,
            width: 1.0,
            style: BorderStyle.solid,
          ),),
          columnSpacing: 2.0,
          headingRowColor: WidgetStateProperty.all(Color(0xFFBB2727)),
          dataRowMaxHeight: 55,
          headingTextStyle: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 15,
            color: Colors.white,
          ),
          dataTextStyle: TextStyle(
            fontSize: 15,
            color: Colors.black,
          ),
          columns: [
            DataColumn(
              label: Container(
                width: 110, // Set a fixed width for the header
                child: Text('Blood Type'),
              ),
            ),
            DataColumn(
              label: Container(
                width: 103, // Set a fixed width for the header
                child: Text('Donor'),
              ),
            ),
            DataColumn(
              label: Container(
                width: 120, // Set a fixed width for the header
                child: Text('Recipient'),
              ),
            ),
          ],
          rows: [
            DataRow(cells: [
              DataCell(Text('O-')),
              DataCell(Text('All Types')),
              DataCell(Text('O-')),
            ]),
            DataRow(cells: [
              DataCell(Text('O+')),
              DataCell(Column(
                children: [
                  SizedBox(height: 5),
                  Text('A+, B+, AB+,'),
                  Text('O+')
                ],
              )),
              DataCell(Text('O+, O-')),
            ]),
            DataRow(cells: [
              DataCell(Text('A-')),
              DataCell(Column(
                children: [
                  SizedBox(height: 5),
                  Text('A-, A+, AB-,'),
                  Text('AB+'),
                ],
              )),
              DataCell(Text('A-, O-')),
            ]),
            DataRow(cells: [
              DataCell(Text('A+')),
              DataCell(Text('A+, AB+')),
              DataCell(Column(
                children: [
                  SizedBox(height: 5),
                  Text('A+, A-, O+,'),
                  Text('O-'),
                ],
              )),
            ]),
            DataRow(cells: [
              DataCell(Text('B-')),
              DataCell(Column(
                children: [
                  SizedBox(height: 5),
                  Text('B-, B+, AB-,'),
                  Text('AB+'),
                ],
              )),
              DataCell(Text('B-, O-')),
            ]),
            DataRow(cells: [
              DataCell(Text('B+')),
              DataCell(Text('B+, AB+')),
              DataCell(Column(
                children: [
                  SizedBox(height: 5),
                  Text('B+, B-, O+,'),
                  Text('O-')
                ],
              )),
            ]),
            DataRow(cells: [
              DataCell(Text('AB-')),
              DataCell(Text('AB-, AB+')),
              DataCell(Column(
                children: [
                  SizedBox(height: 5),
                  Text('AB-, A-, B-,'),
                  Text('O-')
                ],
              )),
            ]),
            DataRow(cells: [
              DataCell(Text('AB+')),
              DataCell(Text('AB+')),
              DataCell(Text('All Types')),
            ]),
          ],
        ),
      ),
    );
  }
}
