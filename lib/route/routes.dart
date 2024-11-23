import 'package:bloodbank/about.dart';
import 'package:bloodbank/feedback.dart';
import 'package:bloodbank/user_status.dart';
import 'package:bloodbank/forgot_password.dart';
import 'package:bloodbank/home.dart';
import 'package:bloodbank/information.dart';
import 'package:bloodbank/login.dart';
import 'package:bloodbank/profile.dart';
import 'package:bloodbank/search_donor.dart';
import 'package:bloodbank/signup.dart';
import 'package:bloodbank/splash.dart';
import 'package:bloodbank/terms.dart';
import 'package:get/get_navigation/get_navigation.dart';

const String home = "/home";
const String splash = "/splash";
const String registration = "/registration";
const String search = "/search";
const String about = "/about";
const String terms = "/terms";
const String login = "/login";
const String signup = "/signup";
const String profile = "/profile";
const String information = "/information";
const String forgotpassword = "/forgotpassword";
const String feedback = "/feedback";

List<GetPage> getpages = [
  GetPage(name: home, page: () => const Home()),
  GetPage(name: splash, page: () => const Splash()),
  GetPage(name: registration, page: () => const Registration()),
  GetPage(name: search, page: () => const SearchDonor()),
  GetPage(name: about, page: () => const About()),
  GetPage(name: terms, page: () => const Terms()),
  GetPage(name: login, page: () => const Login()),
  GetPage(name: signup, page: () => const Signup()),
  GetPage(name: profile, page: () => const Profile()),
  GetPage(name: information, page: () => const Information()),
  GetPage(name: forgotpassword, page: () => const ForgotPassword()),
  GetPage(name: feedback, page: () => const Feedback()),
];
