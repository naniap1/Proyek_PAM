import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pam_application/views/users/izin.dart';
import 'package:pam_application/views/users/kaos.dart';
import 'package:pam_application/views/users/ruangan.dart';
import 'package:pam_application/views/users/surat.dart';
import 'package:pam_application/views/loginpage.dart'; // Import the login page

void main() {
  runApp(MaterialApp(
    home: UserPage(),
  ));
}

class UserPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.logout), // Add logout icon
            onPressed: () {
              // Navigate to login page
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => LoginPage(),
                ),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // First Row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: CombinedIzinCard(
                    icon1: FontAwesomeIcons.userClock,
                    title1: 'Izin',
                    icon2: FontAwesomeIcons.userClock,
                    title2: 'Izin Bermalam',
                    backgroundColor: Colors.blue.shade100,
                    onTap: () {
                      // Handle combined Izin tap
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PermissionPage(),
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: MenuCard(
                    icon: FontAwesomeIcons.envelope,
                    title: 'Surat',
                    backgroundColor: Colors.blue.shade100,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SuratPage(),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            // Second Row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: MenuCard(
                    icon: FontAwesomeIcons.building,
                    title: 'Ruangan',
                    backgroundColor: Colors.blue.shade100,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => RuanganPage(),
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: MenuCard(
                    icon: FontAwesomeIcons.tshirt,
                    title: 'Kaos',
                    backgroundColor: Colors.blue.shade100,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => kaospage(),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class CombinedIzinCard extends StatelessWidget {
  final IconData icon1;
  final String title1;
  final IconData icon2;
  final String title2;
  final Color backgroundColor;
  final VoidCallback? onTap;

  CombinedIzinCard({
    required this.icon1,
    required this.title1,
    required this.icon2,
    required this.title2,
    required this.backgroundColor,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      elevation: 3,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20.0),
        child: Container(
          height: 150,
          width: 150, // Fixed height and width for each box
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FaIcon(icon1, size: 40),
              SizedBox(height: 8),
              Text(
                'Izin', // Change here to display only "Izin"
                style: TextStyle(fontSize: 14),
              ),
            ],
          ),
        ),
      ),
      color: backgroundColor,
    );
  }
}

class MenuCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final Color backgroundColor;
  final VoidCallback? onTap;

  MenuCard({
    required this.icon,
    required this.title,
    required this.backgroundColor,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      elevation: 3,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20.0),
        child: Container(
          height: 150,
          width: 150, // Fixed height and width for each box
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FaIcon(icon, size: 40),
              SizedBox(height: 16),
              Text(
                title,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14),
              ),
            ],
          ),
        ),
      ),
      color: backgroundColor,
    );
  }
}
