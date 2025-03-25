import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'back_button.dart';
import 'glassmorphic_textfield.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  Future<void> signUp() async {
    final response = await http.post(
      Uri.parse('https://recipe.incube.id/api/register'), // Ganti dengan URL API yang sesuai
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'name': nameController.text,
        'email': emailController.text,
        'password': passwordController.text,
      }),
    );

    if (response.statusCode == 201) {
      // Parsing response JSON
      final Map<String, dynamic> data = json.decode(response.body);

      // Menampilkan notifikasi berhasil
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Registration successful: ${data['data']['user']['name']}')),
      );

      // Arahkan ke halaman login setelah berhasil
      Navigator.pop(context);
    } else if (response.statusCode == 422) {
      // Parsing error response (validasi gagal)
      final Map<String, dynamic> errorData = json.decode(response.body);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: ${errorData['message']}')),
      );
    } else {
      // Tampilkan pesan error umum
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to register user')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            EnhancedBackButton(
              onPressed: () => Navigator.pop(context),
              backgroundColor: Colors.white,
              iconColor: Color(0xff41C1A6),
            ),
            SizedBox(height: 20,),
            Text(
              "Sign Up",
              style: GoogleFonts.poppins(
                  fontSize: 35, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20,),
            Text("Nama",style: GoogleFonts.poppins(
              fontSize: 16,fontWeight: FontWeight.bold
            ),),
            SizedBox(height: 5,),
            GlassmorphicTextField(
              controller: nameController,
              hintText: 'Masukan Nama',
              inputType: TextInputType.name,
              prefixIcon: Icon(
                Icons.person_outline,
                color: Colors.blue,
              ),
            ),
            SizedBox(height: 10,),
            Text("Email",style: GoogleFonts.poppins(
                fontSize: 16,fontWeight: FontWeight.bold
            ),),
            SizedBox(height: 5,),
            GlassmorphicTextField(
                controller: emailController,
                hintText: 'Masukan Email Anda',
                prefixIcon: Icon(
                  Icons.email_outlined,
                  color: Colors.blue,
                ),
            ),
            SizedBox(height: 10,),
            Text("Password",style: GoogleFonts.poppins(
                fontSize: 16,fontWeight: FontWeight.bold
            ),),
            SizedBox(height: 5,),
            GlassmorphicTextField(
              controller: passwordController,
              hintText: 'Masukan Password Anda',
              obscureText: true,
              prefixIcon: Icon(
                Icons.lock_outline,
                color: Colors.blue,
              ),
            ),
            SizedBox(height: 20,),
            SizedBox(
                height: 55,
                width: double.infinity,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xff41C1A6),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(40),
                        side: BorderSide(color: Colors.black, width: 1),
                      ),
                    ),
                    onPressed: signUp, // Panggil fungsi signUp ketika tombol ditekan
                    child: Text(
                      "Sign Up",
                      style: GoogleFonts.poppins(
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ))),
          ],
        ),
      )),
    );
  }
}
