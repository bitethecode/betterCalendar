import 'package:flutter/material.dart';
import 'package:google_cal_analytics/res/custom_colors.dart';
import 'package:google_cal_analytics/utils/auth.dart';
import 'package:google_cal_analytics/widgets/google_sign_in_button.dart';
import 'package:google_sign_in/google_sign_in.dart';
// import 'package:googleapis/calendar/v3.dart' as calendar;
// import 'package:googleapis_auth/auth_io.dart' as auth;
import 'package:http/http.dart' as http;

class WelcomeScreen extends StatelessWidget {
  final GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);

  // Future<void> _handleSignIn() async {
  //   try {
  //     final GoogleSignInAccount? googleSignInAccount =
  //         await _googleSignIn.signIn();
  //     if (googleSignInAccount != null) {
  //       final googleAuth = await googleSignInAccount.authentication;
  //       final refreshToken = googleSignInAccount.serverAuthCode;
  //       final expirationTime = DateTime.now().add(Duration(days: 30));
  //       final credentials = auth.AccessCredentials(
  //         auth.AccessToken('Bearer', googleAuth.accessToken!, expirationTime),
  //         refreshToken,
  //         [calendar.CalendarApi.calendarReadonlyScope],
  //       );
  //       final client = auth.authenticatedClient(
  //         http.Client(),
  //         credentials,
  //       );
  //       final calendarApi = calendar.CalendarApi(client);
  //       final calendarList = await calendarApi.calendarList.list();
  //       for (final calendar in calendarList.items!) {
  //         print(calendar.summary);
  //       }
  //       client.close();
  //     }
  //   } catch (error) {
  //     print('Google Sign-In and Calendar API Error: $error');
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Welcome',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16),
            Text(
              'Be Clear with Your Schedule',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 32),
            Image.asset(
              'assets/images/welcome_image.png',
              width: screenWidth * 0.8,
              height: screenHeight * 0.5,
            ),
            SizedBox(height: 32),
            FutureBuilder(
              future: Authentication.initializeFirebase(context: context),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Text('Error initializing Firebase');
                } else if (snapshot.connectionState == ConnectionState.done) {
                  return GoogleSignInButton();
                }
                return CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(
                    CustomColors.firebaseOrange,
                  ),
                );
              },
            ),
            // Container(
            //     height: 40,
            //     child: ElevatedButton(
            //       onPressed: _handleSignIn,
            //       child: Text('Sign in with Google'),
            //     )),
          ],
        ),
      ),
    );
  }
}
