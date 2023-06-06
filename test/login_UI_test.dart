import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pointr/screens/NewLogin.dart';
// import 'package:pointr/screens/login.dart';

void main() {
  Widget buildTestableWidget(Widget widget) {
    return MaterialApp(
      home: widget,
    );
  }

  testWidgets('Login screen - UI elements', (WidgetTester tester) async {
    // Build the Login screen
    await tester.pumpWidget(buildTestableWidget(const Login()));

    await tester.pumpAndSettle();
    // Verify the presence of UI elements
    expect(find.text('Login'), findsWidgets);
    expect(find.text('Email address'), findsOneWidget);
    expect(find.text('Password'), findsOneWidget);
    expect(find.text('Your Bus Stop Solution!'), findsOneWidget);
    // expect(find.text('New user?'), findsOneWidget);
    //expect(find.text('Create a new account'), findsOneWidget);
    expect(find.byType(ElevatedButton), findsOneWidget);

    // Verify the presence of 'New user?' and 'Create a new account' text
    final richTextFinder = find.byType(RichText);
    expect(richTextFinder, findsNWidgets(9));
    for (int i = 0; i < 9; i++) {
      final richTextWidget = tester.widget<RichText>(richTextFinder.at(i));
      final textSpan = richTextWidget.text;

      if (textSpan.toPlainText().contains('New user?')) {
        expect(textSpan.toPlainText(), contains('Create a new account'));
      }
      // Add more conditions for other RichText widgets as needed
    }
  });

  testWidgets('Email and password validation test',
      (WidgetTester tester) async {
    await tester.pumpWidget(buildTestableWidget(const Login()));

    await tester.pumpAndSettle();

    // Empty email and password
    await tester.tap(find.byType(ElevatedButton));
    await tester.pumpAndSettle();
    expect(find.text('Incorrect email address'), findsOneWidget);
    expect(find.text('The password is too short.'), findsOneWidget);

    // // Invalid email format
    await tester.enterText(find.byType(TextFormField).first, 'invalidemail');
    await tester.tap(find.byType(ElevatedButton));
    await tester.pumpAndSettle();
    expect(find.text('Incorrect email address'), findsOneWidget);

    // // // Valid email format and empty password
    await tester.enterText(
        find.byType(TextFormField).first, 'test@example.com');
    await tester.tap(find.byType(ElevatedButton));
    await tester.pumpAndSettle();
    expect(find.text('The password is too short.'), findsOneWidget);

    // // Valid email and invalid password format
    // await tester.enterText(find.byType(TextFormField).last, 'password');
    // await tester.tap(find.byType(ElevatedButton));
    // await tester.pumpAndSettle();
    // await Future.delayed(const Duration(seconds: 2));
    // // Future.delayed(const Duration(seconds: 5), () {
    // expect(find.text('Error'), findsOneWidget);
    // });

    // // Valid email and password format
    // await tester.enterText(find.byType(TextFormField).first, 'test@gmail.com');
    // await tester.enterText(find.byType(TextFormField).last, '123qweA!');
    // await tester.tap(find.text('Login'));
    // await tester.pumpAndSettle();
    // verify(mockNavigatorObserver.didPush());
    // verify(mockNavigatorObserver.didPop());
    // await Future.delayed(const Duration(seconds: 10));
    // expect(find.byType(HomePage), findsOneWidget);
  });

  // testWidgets('Sign in using email and password test',
  //     (WidgetTester tester) async {
  //   when(mockFirebaseAuth.signInWithEmailAndPassword(
  //     email: "Ali",
  //     password: "Pass",
  //   )).thenAnswer((_) async => mockUserCredential);

  //   when(mockUserCredential.user).thenReturn(mockUser);

  //   await tester.pumpWidget(MaterialApp(home: login));

  //   await tester.enterText(
  //       find.byType(TextFormField).first, 'test@example.com');
  //   await tester.enterText(find.byType(TextFormField).last, 'Password1');
  //   await tester.tap(find.text('Login'));
  //   await tester.pumpAndSettle();

  //   verify(mockFirebaseAuth.signInWithEmailAndPassword(
  //     email: 'test@example.com',
  //     password: 'Password1',
  //   )).called(1);

  //   // verify(mockUserCredential.user).called(1);
  //   // expect(find.text('Login Successful'), findsOneWidget);
  // });
}
