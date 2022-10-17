import 'package:flutter/material.dart';
import 'package:flutter_absen_koin/source/data/cubit/login_cubit.dart';
import 'package:flutter_absen_koin/source/router/string.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController controllerUsername = TextEditingController();
  TextEditingController controllerPassword = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String status = "";
  var validator = "";
  void handleStatus(value) {
    setState(() {
      status = value;
    });
    print(status);
  }

  void submit() {
    if (_formKey.currentState!.validate()) {
      BlocProvider.of<LoginCubit>(context).submit(context, controllerUsername.text, controllerPassword.text);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<LoginCubit, LoginState>(
        listener: (context, state) {
          if (state is LoginMessage) {
            var snackdemo = SnackBar(
              content: Text(state.message!),
              backgroundColor: Color(0XFFFF884B),
              elevation: 10,
              behavior: SnackBarBehavior.floating,
              margin: EdgeInsets.all(5),
            );
            ScaffoldMessenger.of(context).showSnackBar(snackdemo);
          }
        },
        child: Center(
          child: ListView(
            shrinkWrap: true,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Icon(FontAwesomeIcons.shop, color: Color(0XFFFF884B), size: 100),
                    const SizedBox(height: 40),
                    Form(
                      key: _formKey,
                      child: SizedBox(
                        width: 300,
                        child: Column(
                          children: [
                            TextFormField(
                              controller: controllerUsername,
                              cursorColor: Color(0XFFFF884B),
                              decoration: InputDecoration(
                                hintText: "Masukan Username",
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(color: Color(0XFFFF884B), width: 2),
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Kolom ini tidak boleh kosong";
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 12),
                            TextFormField(
                              controller: controllerPassword,
                              cursorColor: Color(0XFFFF884B),
                              obscureText: true,
                              decoration: InputDecoration(
                                hintText: "Masukan Password",
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(color: Color(0XFFFF884B), width: 2),
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Kolom ini tidak boleh kosong";
                                }
                                return null;
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: 300,
                      height: 50,
                      child: OutlinedButton(
                        onPressed: () {
                          submit();
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0XFF393E46),
                            elevation: 3.0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            )),
                        child: const Text("Submit", style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w500)),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
