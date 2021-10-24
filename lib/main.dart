import 'package:book_shelf/constants/colors.dart';
import 'package:book_shelf/providers/booksProvider.dart';
import 'package:book_shelf/providers/loginProvider.dart';
import 'package:book_shelf/providers/membersProvider.dart';
import 'package:book_shelf/services/authentication_service.dart';
import 'package:book_shelf/ui/screens/home/homePage.dart';
import 'package:book_shelf/ui/screens/login/loginPage.dart';
import 'package:book_shelf/ui/screens/navigation/navigation.dart';
import 'package:book_shelf/ui/screens/onboarding/onBoardingMain.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SystemChrome.setEnabledSystemUIOverlays([]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<AuthenticationService>(
            create: (_) => AuthenticationService(FirebaseAuth.instance)),
        StreamProvider(
            create: (context) =>
                context.read<AuthenticationService>().authStateChanges),
        ChangeNotifierProvider(create: (_) => LoginProvider()),
        ChangeNotifierProvider(create: (_) => BooksProvider()),
        ChangeNotifierProvider(create: (_) => MembersProvider()),
      ],
      child: MaterialApp(
        theme: ThemeData(
          bottomSheetTheme: BottomSheetThemeData(backgroundColor: Colors.transparent),
          accentColor: AppColors.primaryDark,
          inputDecorationTheme: InputDecorationTheme(
            focusColor: AppColors.primaryDark,
          ),
          colorScheme: ThemeData().colorScheme.copyWith(
                primary: AppColors.primaryDark,
                primaryVariant: AppColors.primary,
                secondary: AppColors.secondary,
                secondaryVariant: AppColors.secondaryDark,
                onPrimary: AppColors.primaryDark,
              ),
        ),
        debugShowCheckedModeBanner: false,
        title: 'Book Shelf',
        home: _getLandingPage(),
      ),
    );
  }

  Widget _getLandingPage() {
    return StreamBuilder<User>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (BuildContext context, snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data.providerData.length == 1) {
            // logged in
            return Navigation();
          } else {
            // logged in
            return Navigation();
          }
        } else {
          return OnboardingMain();
        }
      },
    );
  }
}
