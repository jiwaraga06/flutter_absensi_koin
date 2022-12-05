import 'package:flutter/material.dart';
import 'package:flutter_absen_koin/source/data/cubit/change_pass_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChangePasswordOutlet extends StatefulWidget {
  const ChangePasswordOutlet({super.key});

  @override
  State<ChangePasswordOutlet> createState() => _ChangePasswordOutletState();
}

class _ChangePasswordOutletState extends State<ChangePasswordOutlet> {
  TextEditingController controllerOldPass = TextEditingController();
  TextEditingController controllerNewPass = TextEditingController();

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
      BlocProvider.of<ChangePassCubit>(context).changePasOutlet(context, controllerOldPass.text, controllerNewPass.text);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0XFFFF884B),
        title: Text("Ganti Password"),
      ),
      body: BlocListener<ChangePassCubit, ChangePassState>(
        listener: (context, state) {
          if (state is ChangePassLoaded) {
            if (state.result[0] == 1) {
              var snackdemo = SnackBar(
                content: Text("${state.result[0]['Keterangan']}, Silahkan Login Kembali"),
                backgroundColor: Color(0XFFFF884B),
                elevation: 10,
                behavior: SnackBarBehavior.floating,
                margin: EdgeInsets.all(5),
              );
              ScaffoldMessenger.of(context).showSnackBar(snackdemo);
            } else {
              var snackdemo = SnackBar(
                content: Text(state.result[0]['Keterangan']),
                backgroundColor: Color(0XFFFF884B),
                elevation: 10,
                behavior: SnackBarBehavior.floating,
                margin: EdgeInsets.all(5),
              );
              ScaffoldMessenger.of(context).showSnackBar(snackdemo);
            }
          }
        },
        child: Center(
          child: ListView(
            shrinkWrap: true,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Form(
                    key: _formKey,
                    child: SizedBox(
                      width: 300,
                      child: Column(
                        children: [
                          TextFormField(
                            controller: controllerOldPass,
                            cursorColor: Color(0XFFFF884B),
                            decoration: InputDecoration(
                              hintText: "Masukan Password Lama",
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
                          const SizedBox(height: 10),
                          TextFormField(
                            controller: controllerNewPass,
                            cursorColor: Color(0XFFFF884B),
                            decoration: InputDecoration(
                              hintText: "Masukan Password Baru",
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
                  const SizedBox(height: 8),
                  SizedBox(
                    width: 300,
                    height: 45,
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
                      child: const Text("Simpan", style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w500)),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
