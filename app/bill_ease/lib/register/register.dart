import 'package:bill_ease/app/app.dart';
import 'package:bill_ease/login/layout/login_page.dart';
import 'package:bill_ease/register/models/user_type_model.dart';
import 'package:bill_ease/register/service/register_service.dart';
import 'package:bill_ease/utils/kj_theme.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;
  RegisterService service = RegisterService();
  UserType userType = UserType.retailer;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: KJTheme.backGroundColor,
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Already have an Account?",
                style: KJTheme.subtitleText(
                    size: KJTheme.getMobileWidth(context) / 28,
                    weight: FontWeight.w500,
                    color: KJTheme.darkishGrey),
              ),
              const SizedBox(
                width: 5,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (_) {
                    return const LoginPage();
                  }));
                },
                child: Text(
                  "Login",
                  style: KJTheme.subtitleText(
                      size: KJTheme.getMobileWidth(context) / 28,
                      weight: FontWeight.bold,
                      color: KJTheme.nearlyBlue),
                ),
              )
            ],
          ),
        ),
        body: SafeArea(
            child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          physics: const BouncingScrollPhysics(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: KJTheme.getMobileWidth(context) * 0.4,
                width: KJTheme.getMobileWidth(context) * 0.4,
                alignment: Alignment.topLeft,
                child: Image.asset("assets/images/team.png"),
              ),
              Column(
                children: [
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Get On Board!",
                      textDirection: TextDirection.ltr,
                      style: KJTheme.titleText(
                          letterSpacing: -1,
                          size: KJTheme.getMobileWidth(context) / 12.5,
                          weight: FontWeight.bold,
                          color: KJTheme.darkishGrey),
                    ),
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Create your profile to start your Journey.",
                      textDirection: TextDirection.ltr,
                      style: KJTheme.titleText(
                          size: KJTheme.getMobileWidth(context) / 24,
                          weight: FontWeight.w500,
                          color: KJTheme.nearlyGrey),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    SizedBox(
                      width: KJTheme.getMobileWidth(context),
                      child: TextFormField(
                        controller: _nameController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please enter full name";
                          }
                          return null;
                        },
                        cursorColor: KJTheme.nearlyBlue,
                        style: KJTheme.subtitleText(
                            size: KJTheme.getMobileWidth(context) / 24,
                            weight: FontWeight.normal,
                            color: KJTheme.nearlyGrey),
                        decoration: KJTheme.waInputDecoration(
                            hint: "Name",
                            fontSize: KJTheme.getMobileWidth(context) / 24,
                            prefixIcon: Icons.person_4_outlined),
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    SizedBox(
                      width: KJTheme.getMobileWidth(context),
                      child: TextFormField(
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please enter email";
                          } else if (!RegExp(
                                  r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
                              .hasMatch(value.trim())) {
                            return "Email is not valid";
                          }
                          return null;
                        },
                        cursorColor: KJTheme.nearlyBlue,
                        style: KJTheme.subtitleText(
                            size: KJTheme.getMobileWidth(context) / 24,
                            weight: FontWeight.normal,
                            color: KJTheme.nearlyGrey),
                        decoration: KJTheme.waInputDecoration(
                            hint: "Email",
                            fontSize: KJTheme.getMobileWidth(context) / 24,
                            prefixIcon: CupertinoIcons.mail),
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    SizedBox(
                      width: KJTheme.getMobileWidth(context),
                      child: TextFormField(
                        controller: _phoneController,
                        keyboardType: TextInputType.phone,
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please enter phone number";
                          }
                          return null;
                        },
                        cursorColor: KJTheme.nearlyBlue,
                        style: KJTheme.subtitleText(
                            size: KJTheme.getMobileWidth(context) / 24,
                            weight: FontWeight.normal,
                            color: KJTheme.nearlyGrey),
                        decoration: KJTheme.waInputDecoration(
                            hint: "Phone No",
                            fontSize: KJTheme.getMobileWidth(context) / 24,
                            prefixIcon: Icons.phone_outlined),
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    SizedBox(
                      width: KJTheme.getMobileWidth(context),
                      child: TextFormField(
                        controller: _passwordController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please enter password";
                          }
                          return null;
                        },
                        cursorColor: KJTheme.nearlyBlue,
                        style: KJTheme.subtitleText(
                            size: KJTheme.getMobileWidth(context) / 24,
                            weight: FontWeight.normal,
                            color: KJTheme.nearlyGrey),
                        decoration: KJTheme.waInputDecoration(
                            hint: "Password",
                            fontSize: KJTheme.getMobileWidth(context) / 24,
                            prefixIcon: Icons.fingerprint),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("What type of user are you?",
                            style: KJTheme.titleText(
                                size: KJTheme.getMobileWidth(context) / 28,
                                weight: FontWeight.w500,
                                color: KJTheme.nearlyGrey)),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: RadioListTile<UserType>(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  activeColor: KJTheme.nearlyBlue,
                                  controlAffinity:
                                      ListTileControlAffinity.platform,
                                  dense: true,
                                  tileColor:
                                      KJTheme.nearlyBlue.withOpacity(0.1),
                                  title: Text(UserType.customer.name,
                                      style: KJTheme.subtitleText(
                                          size:
                                              KJTheme.getMobileWidth(context) /
                                                  28,
                                          weight: FontWeight.w600,
                                          color: KJTheme.darkishGrey)),
                                  value: UserType.customer,
                                  groupValue: userType,
                                  onChanged: (x) {
                                    setState(() {
                                      userType = x!;
                                    });
                                  }),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: RadioListTile<UserType>(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  activeColor: KJTheme.nearlyBlue,
                                  controlAffinity:
                                      ListTileControlAffinity.platform,
                                  dense: true,
                                  tileColor:
                                      KJTheme.nearlyBlue.withOpacity(0.1),
                                  title: Text(UserType.retailer.name,
                                      style: KJTheme.subtitleText(
                                          size:
                                              KJTheme.getMobileWidth(context) /
                                                  28,
                                          weight: FontWeight.w600,
                                          color: KJTheme.darkishGrey)),
                                  value: UserType.retailer,
                                  groupValue: userType,
                                  onChanged: (x) {
                                    setState(() {
                                      userType = x!;
                                    });
                                  }),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              SizedBox(
                height: KJTheme.getMobileWidth(context) / 7,
                width: KJTheme.getMobileWidth(context),
                child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        setState(() {
                          isLoading = true;
                        });
                        service
                            .createUser(
                                user_type: userType.name.trim(),
                                name: _nameController.text.trim(),
                                phone: _phoneController.text.trim(),
                                email: _emailController.text.trim(),
                                password: _passwordController.text.trim(),
                                context: context)
                            .then((value) {
                          setState(() {
                            isLoading = false;
                          });
                          if (value is UserCredential) {
                            Navigator.pushReplacement(context,
                                MaterialPageRoute(builder: (context) {
                              return const App();
                            }));
                          }
                        });
                      }
                    },
                    style: KJTheme.buttonStyle(backColor: KJTheme.nearlyBlue),
                    child: isLoading
                        ? SizedBox(
                            height: KJTheme.getMobileWidth(context) / 20,
                            width: KJTheme.getMobileWidth(context) / 20,
                            child: const CircularProgressIndicator(
                                strokeWidth: 2, color: KJTheme.backGroundColor),
                          )
                        : Text("SIGNUP",
                            style: KJTheme.subtitleText(
                                color: KJTheme.backGroundColor,
                                size: KJTheme.getMobileWidth(context) / 25,
                                weight: FontWeight.bold))),
              )
            ],
          ),
        )),
      ),
    );
  }
}
