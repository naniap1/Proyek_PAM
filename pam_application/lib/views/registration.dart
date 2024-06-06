import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pam_application/Controller/AuthController.dart';
import 'package:pam_application/views/loginpage.dart';
import 'package:google_fonts/google_fonts.dart';

class RegistrationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: 20.0),
              Image.asset(
                'assets/img/del.jpeg',
                height: 80,
                width: 80,
              ),
              SizedBox(height: 10.0),
              Text(
                'Institut Teknologi Del',
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.blue,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 16.0),
              RegistrationForm(),
              SizedBox(height: 16.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton.icon(
                    onPressed: () {
                      // Handle Google registration
                    },
                    icon: Image.asset('assets/img/google.png', height: 24, width: 24),
                    label: Text('Register with Google'),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.white, // Set background color to white
                      onPrimary: Colors.black, // Set text color to black
                    ),
                  ),
                  SizedBox(width: 16),
                  ElevatedButton.icon(
                    onPressed: () {
                      // Handle Facebook registration
                    },
                    icon: Image.asset('assets/img/facebook.png', height: 24, width: 24),
                    label: Text('Register with Facebook'),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.white, // Set background color to white
                      onPrimary: Colors.black, // Set text color to black
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16.0),
              TextButton(
                onPressed: () {
                  Get.to(() => LoginPage());
                },
                child: RichText(
                  text: TextSpan(
                    text: 'Sudah punya akun? ',
                    style: TextStyle(fontSize: 14, color: Colors.grey),
                    children: [
                      TextSpan(
                        text: 'Login',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class RegistrationForm extends StatelessWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nikController = TextEditingController();
  final TextEditingController _nimController = TextEditingController();
  final TextEditingController _namaController = TextEditingController();
  final TextEditingController _noTeleponController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final AuthController _authController = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildTextField('NIK', Icons.person, _nikController),
          SizedBox(height: 10.0),
          _buildTextField('NIM', Icons.school, _nimController),
          SizedBox(height: 10.0),
          _buildTextField('Nama Lengkap', Icons.person, _namaController),
          SizedBox(height: 10.0),
          _buildTextField('Nomor Handphone', Icons.phone, _noTeleponController),
          SizedBox(height: 10.0),
          _buildTextField('Email', Icons.email, _emailController),
          SizedBox(height: 10.0),
          _buildTextField('Password', Icons.lock, _passwordController, isPassword: true),
          SizedBox(height: 16.0),
          ElevatedButton(
            onPressed: () async {
              if (_formKey.currentState!.validate()) {
                await _authController.register(
                  nik: _nikController.text.trim(),
                  nim: _nimController.text.trim(),
                  nama: _namaController.text.trim(),
                  noTelepon: _noTeleponController.text.trim(),
                  email: _emailController.text.trim(),
                  password: _passwordController.text.trim(),
                );

                await Future.delayed(Duration(seconds: 3));

                _authController.isLoading.value = false;

                Get.to(() => LoginPage());
              }
            },
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.symmetric(horizontal: 0, vertical: 10),
              minimumSize: Size(100, 40),
            ),
            child: Obx(() {
              return _authController.isLoading.value
                  ? Center(
                      child: CircularProgressIndicator(
                        color: Colors.white,
                      ),
                    )
                  : Text(
                      'Register',
                      style: GoogleFonts.poppins(fontSize: 14),
                    );
            }),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField(String labelText, IconData iconData, TextEditingController controller, {bool isPassword = false}) {
    return TextFormField(
      decoration: InputDecoration(
        labelText: labelText,
        prefixIcon: Icon(iconData),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6.0),
        ),
      ),
      controller: controller,
      obscureText: isPassword,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return '$labelText is required';
        }
        return null;
      },
    );
  }
}
