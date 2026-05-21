import 'package:flutter/material.dart';
import 'package:instagram_app/providers/user_provider.dart';
import 'package:instagram_app/screens/dashboard.dart';
import 'package:instagram_app/screens/login_screen.dart';
import 'package:provider/provider.dart';

class SingupScreen extends StatefulWidget {
  const SingupScreen({super.key});

  @override
  State<SingupScreen> createState() => _SingupScreenState();
}

class _SingupScreenState extends State<SingupScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final nameController = TextEditingController();
  final dobController = TextEditingController();
  final mobileController = TextEditingController();
  final genderController = TextEditingController();
  final cityController = TextEditingController();
  final profileImageUrlController = TextEditingController();

  Widget buildTextFormField(TextEditingController controller, String name) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        label: Text(name),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(20.0)),
          borderSide: BorderSide(color: Colors.brown),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(20.0)),
          borderSide: BorderSide(color: Colors.green),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(20.0)),
          borderSide: BorderSide(color: Colors.red),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // email, password, name, dob, mobile, gender, city,profileImageUrl, id
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "SignUp Screen",
            style: TextStyle(
              fontSize: 30,
              color: Colors.brown,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 40),
          buildTextFormField(nameController, "Name"),
          SizedBox(height: 20),
          buildTextFormField(emailController, "Email"),
          SizedBox(height: 20),
          buildTextFormField(passwordController, "Password"),
          SizedBox(height: 20),
          buildTextFormField(dobController, "Date of Birth"),
          SizedBox(height: 20),
          buildTextFormField(mobileController, "Mobile"),
          SizedBox(height: 20),
          buildTextFormField(cityController, "City"),
          SizedBox(height: 20),
          buildTextFormField(genderController, "Gender"),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () async {
              var uid = await Provider.of<UserProvider>(context, listen: false)
                  .createUserInBackend(
                    nameController.text,
                    emailController.text,
                    passwordController.text,
                    dobController.text,
                    mobileController.text,
                    cityController.text,
                    genderController.text,
                    "",
                  );
              if (uid.isNotEmpty) {
                nameController.clear();
                emailController.clear();
                passwordController.clear();
                dobController.clear();
                mobileController.clear();
                cityController.clear();
                genderController.clear();
                profileImageUrlController.clear();
                Navigator.of(
                  context,
                ).push(MaterialPageRoute(builder: (context) => Dashboard()));
              }
            },
            child: Text("SignUp"),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(
                context,
              ).push(MaterialPageRoute(builder: (context) => LoginScreen()));
            },
            child: Text("Already have an account? Login"),
          ),
        ],
      ),
    );
  }
}
