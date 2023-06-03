// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:rounded_loading_button/rounded_loading_button.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:socialsignup/login.dart';
// //import 'package:connectivity_plus/connectivity_plus.dart';

// import '../provider/internet_provider.dart';
// import '../provider/sign_in_provider.dart';
// import '../signup.dart';
// import '../utils/next_screen.dart';
// import '../utils/snack_bar.dart';
// import 'home_screen.dart';

// class LoginScreen extends StatefulWidget {
//   const LoginScreen({super.key});

//   @override
//   State<LoginScreen> createState() => _LoginScreenState();
// }

// class _LoginScreenState extends State<LoginScreen> {
//   final GlobalKey _scaffoldKey = GlobalKey<ScaffoldState>();

//   final RoundedLoadingButtonController googleController =
//       RoundedLoadingButtonController();
//   final RoundedLoadingButtonController facebookController =
//       RoundedLoadingButtonController();
//   final RoundedLoadingButtonController twitterController =
//       RoundedLoadingButtonController();
//   final RoundedLoadingButtonController AuthController =
//       RoundedLoadingButtonController();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         key: _scaffoldKey,
//         body: SafeArea(
//             child: Padding(
//           padding:
//               const EdgeInsets.only(left: 40, right: 40, top: 90, bottom: 30),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Flexible(
//                   flex: 2,
//                   child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         const Image(
//                           image: NetworkImage(
//                               "https://raw.githubusercontent.com/backslashflutter/socialauth_flutter_firebase/main/assets/logo.png"),
//                           height: 80,
//                           width: 80,
//                           fit: BoxFit.cover,
//                         ),
//                         const SizedBox(
//                           height: 20,
//                         ),
//                         const Text("Welcome to FlutterFirebase",
//                             style: TextStyle(
//                                 fontSize: 25, fontWeight: FontWeight.w500)),
//                         const SizedBox(
//                           height: 10,
//                         ),
//                         Text(
//                           "Learn Authentication with Provider",
//                           style:
//                               TextStyle(fontSize: 15, color: Colors.grey[600]),
//                         )
//                       ])),
//               //rounded loading button
//               Column(
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     RoundedLoadingButton(
//                       onPressed: () {
//                         Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                                 builder: (context) => LoginPage()));
//                         AuthController.reset();
//                       },
//                       controller: AuthController,
//                       successColor: Colors.black,
//                       width: MediaQuery.of(context).size.width * 0.80,
//                       elevation: 0,
//                       borderRadius: 25,
//                       color: Colors.black,
//                       child: Wrap(
//                         children: const [
//                           Icon(
//                             FontAwesomeIcons.signIn,
//                             size: 20,
//                             color: Colors.white,
//                           ),
//                           SizedBox(
//                             width: 15,
//                           ),
//                           Text("Sign in with Email",
//                               style: TextStyle(
//                                   color: Colors.white,
//                                   fontSize: 15,
//                                   fontWeight: FontWeight.w500)),
//                         ],
//                       ),
//                     ),
//                     const SizedBox(
//                       height: 10,
//                     ),
//                     RoundedLoadingButton(
//                       onPressed: () {
//                         handleGoogleSignIn();
//                         // Navigator.pushReplacement(
//                         //     context,
//                         //     MaterialPageRoute(
//                         //         builder: (context) => const HomeScreen()));
//                       },
//                       controller: googleController,
//                       successColor: Colors.red,
//                       width: MediaQuery.of(context).size.width * 0.80,
//                       elevation: 0,
//                       borderRadius: 25,
//                       color: Colors.red,
//                       child: Wrap(
//                         children: const [
//                           Icon(
//                             FontAwesomeIcons.google,
//                             size: 20,
//                             color: Colors.white,
//                           ),
//                           SizedBox(
//                             width: 15,
//                           ),
//                           Text("Sign in with Google",
//                               style: TextStyle(
//                                   color: Colors.white,
//                                   fontSize: 15,
//                                   fontWeight: FontWeight.w500)),
//                         ],
//                       ),
//                     ),
//                     const SizedBox(
//                       height: 10,
//                     ),
//                     RoundedLoadingButton(
//                       onPressed: () {
//                         handleFacebookAuth();
//                       },
//                       controller: facebookController,
//                       successColor: Colors.blue,
//                       width: MediaQuery.of(context).size.width * 0.80,
//                       elevation: 0,
//                       borderRadius: 25,
//                       color: Colors.blue,
//                       child: Wrap(
//                         children: const [
//                           Icon(
//                             FontAwesomeIcons.facebook,
//                             size: 20,
//                             color: Colors.white,
//                           ),
//                           SizedBox(
//                             width: 15,
//                           ),
//                           Text("Sign in with facebook",
//                               style: TextStyle(
//                                   color: Colors.white,
//                                   fontSize: 15,
//                                   fontWeight: FontWeight.w500)),
//                         ],
//                       ),
//                     ),
//                     const SizedBox(
//                       height: 30,
//                     ),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         const Text("Not a member?"),
//                         SizedBox(width: 8),
//                         InkWell(
//                             onTap: () {
//                               Navigator.pushReplacement(
//                                   context,
//                                   MaterialPageRoute(
//                                       builder: (context) => const Signup()));
//                             },
//                             child: Text(
//                               "Register Now",
//                               style: TextStyle(color: Colors.blue),
//                             ))
//                       ],
//                     )
//                   ])
//             ],
//           ),
//         )));
//   }

//   // handling google sigin in
//   Future handleGoogleSignIn() async {
//     final sp = context.read<SignInProvider>();
//     final ip = context.read<InternetProvider>();
//     await ip.checkInternetConnection();

//     if (ip.hasInternet == false) {
//       // ignore: use_build_context_synchronously
//       openSnackbar(context, "Check your Internet connection", Colors.red);
//       googleController.reset();
//     } else {
//       await sp.signInWithGoogle().then((value) {
//         if (sp.hasError == true) {
//           openSnackbar(context, sp.errorCode.toString(), Colors.red);
//           googleController.reset();
//         } else {
//           // checking whether user exists or not
//           sp.checkUserExists().then((value) async {
//             if (value == true) {
//               // user exists
//               await sp.getUserDataFromFirestore(sp.uid).then((value) => sp
//                   .saveDataToSharedPreferences()
//                   .then((value) => sp.setSignIn().then((value) {
//                         googleController.success();
//                         handleAfterSignIn();
//                       })));
//             } else {
//               // user does not exist
//               sp.saveDataToFirestore().then((value) => sp
//                   .saveDataToSharedPreferences()
//                   .then((value) => sp.setSignIn().then((value) {
//                         googleController.success();
//                         handleAfterSignIn();
//                       })));
//               //print(sp);
//             }
//           });
//         }
//       });
//     }
//   }

//   // handling facebook sigin in

//   Future handleFacebookAuth() async {
//     final sp = context.read<SignInProvider>();
//     final ip = context.read<InternetProvider>();
//     await ip.checkInternetConnection();

//     if (ip.hasInternet == false) {
//       openSnackbar(context, "Check your Internet connection", Colors.red);
//       facebookController.reset();
//     } else {
//       await sp.signInWithFacebook().then((value) {
//         if (sp.hasError == true) {
//           openSnackbar(context, sp.errorCode.toString(), Colors.red);
//           facebookController.reset();
//         } else {
//           // checking whether user exists or not
//           sp.checkUserExists().then((value) async {
//             if (value == true) {
//               // user exists
//               await sp.getUserDataFromFirestore(sp.uid).then((value) => sp
//                   .saveDataToSharedPreferences()
//                   .then((value) => sp.setSignIn().then((value) {
//                         facebookController.success();
//                         handleAfterSignIn();
//                       })));
//             } else {
//               // user does not exist
//               sp.saveDataToFirestore().then((value) => sp
//                   .saveDataToSharedPreferences()
//                   .then((value) => sp.setSignIn().then((value) {
//                         facebookController.success();
//                         handleAfterSignIn();
//                       })));
//             }
//           });
//         }
//       });
//     }
//   }

//   // handle after signin
//   handleAfterSignIn() {
//     Future.delayed(const Duration(milliseconds: 100)).then((value) {
//       // nextScreenReplace(context, const HomeScreen());
//       Navigator.pushReplacement(
//           context, MaterialPageRoute(builder: (context) => const HomeScreen()));
//     });
//     // Navigator.pushReplacement(
//     //     context, MaterialPageRoute(builder: (context) => const HomeScreen()));

//     // Navigator.push(
//     //   context,
//     //   MaterialPageRoute(
//     //     builder: (context) => const HomeScreen(),
//     // ),
//     // );
//   }
// }
