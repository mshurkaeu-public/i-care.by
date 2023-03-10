// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:icare_by_app/request_not_empty_list_of_persons_names.dart';

void main() {
  final String inputHint =
      'Input name here ${DateTime.now().toIso8601String()}';
  const String nextButtonText = 'Далей';

  Future<void> singleNameRequestSmokeTest(WidgetTester tester,
      Future<void> Function(WidgetTester tester) submitAction) async {
    bool onSubmitSingleNameWasCalled = false;
    String? theName;
    void onSubmitSingleName(String value) {
      onSubmitSingleNameWasCalled = true;
      theName = value;
    }

    final String introductoryText =
        'Introduction - ${DateTime.now().toIso8601String()}';
    final String messageIfListIsEmpty =
        'Error: there is no name - ${DateTime.now().toIso8601String()}';

    await tester.pumpWidget(MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      routes: {
        '/': (BuildContext context) {
          return Scaffold(
            body: Localizations.override(
              context: context,
              locale: const Locale('be'),
              child: RequestNotEmptyListOfPersonsNames(
                onSubmitNames: onSubmitSingleName,
                hintForInputField: inputHint,
                introductoryText: introductoryText,
                messageIfListIsEmpty: messageIfListIsEmpty,
              ),
            ),
          );
        }
      },
    ));

    expect(find.text(introductoryText), findsOneWidget);
    expect(find.text(inputHint), findsOneWidget);
    expect(find.text(nextButtonText), findsOneWidget);
    expect(find.text(messageIfListIsEmpty), findsNothing);

    final TextField theInput = find
        .ancestor(
          of: find.text(inputHint),
          matching: find.byType(TextField),
        )
        .evaluate()
        .single
        .widget as TextField;

    // check that initially focus is not in the input field
    expect(theInput.focusNode!.hasFocus, false);

    // call "submit" action
    await submitAction(tester);

    // Verify that error message appeared because the list is empty.
    expect(find.text(messageIfListIsEmpty), findsOneWidget);
    // ensure that focus now in the input field
    expect(theInput.focusNode!.hasFocus, true);
    // Verify that callback was not called because of the error.
    expect(onSubmitSingleNameWasCalled, false);
    expect(theName, null);

    final String nameValue = 'Name ${DateTime.now().toIso8601String()}';
    tester.testTextInput.enterText(nameValue);

    // call "submit" action again
    await submitAction(tester);

    expect(onSubmitSingleNameWasCalled, true);
    expect(theName, nameValue);
  }

  testWidgets('Single name request smoke test with next button',
      (WidgetTester tester) async {
    await singleNameRequestSmokeTest(tester, (WidgetTester tester) async {
      await tester.tap(find.text(nextButtonText));
      await tester.pump();
    });
  });

  testWidgets('Single name request smoke test with <Enter> key',
      (WidgetTester tester) async {
    await singleNameRequestSmokeTest(tester, (WidgetTester tester) async {
      await tester.tap(find.ancestor(
        of: find.text(inputHint),
        matching: find.byType(TextField),
      ));

      await tester.testTextInput.receiveAction(TextInputAction.done);
      await tester.pump();
    });
  });

  testWidgets('Multiple names request smoke test', (WidgetTester tester) async {
    bool onSubmitNamesWasCalled = false;
    String? theNames;
    void onSubmitNames(String value) {
      onSubmitNamesWasCalled = true;
      theNames = value;
    }

    final String introductoryText =
        'Introduction - ${DateTime.now().toIso8601String()}';
    final String messageIfListIsEmpty =
        'Error: the list is empty - ${DateTime.now().toIso8601String()}';
    final String messageIfThereAreTooFewNames =
        'Error: the list of names is too short - ${DateTime.now().toIso8601String()}';

    await tester.pumpWidget(MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      routes: {
        '/': (BuildContext context) {
          return Scaffold(
            body: Localizations.override(
              context: context,
              locale: const Locale('be'),
              child: RequestNotEmptyListOfPersonsNames(
                onSubmitNames: onSubmitNames,
                hintForInputField: inputHint,
                introductoryText: introductoryText,
                messageIfListIsEmpty: messageIfListIsEmpty,
                messageIfThereAreTooFewNames: messageIfThereAreTooFewNames,
                minLines: 2,
                minNames: 2,
                maxLines: 10,
              ),
            ),
          );
        }
      },
    ));

    expect(find.text(introductoryText), findsOneWidget);
    expect(find.text(inputHint), findsOneWidget);
    expect(find.text(nextButtonText), findsOneWidget);
    expect(find.text(messageIfListIsEmpty), findsNothing);

    final TextField theInput = find
        .ancestor(
          of: find.text(inputHint),
          matching: find.byType(TextField),
        )
        .evaluate()
        .single
        .widget as TextField;

    // check that initially focus is not in the input field
    expect(theInput.focusNode!.hasFocus, false);

    // call "submit" action
    await tester.tap(find.text(nextButtonText));
    await tester.pump();

    // Verify that error message appeared because the list is empty.
    expect(find.text(messageIfListIsEmpty), findsOneWidget);
    // ensure that focus now in the input field
    expect(theInput.focusNode!.hasFocus, true);
    // Verify that callback was not called because of the error.
    expect(onSubmitNamesWasCalled, false);
    expect(theNames, null);

    final String oneLineTwoNames =
        'Name 1, Name ${DateTime.now().toIso8601String()}';
    tester.testTextInput.enterText(oneLineTwoNames);

    // call "submit" action again
    await tester.tap(find.text(nextButtonText));
    await tester.pump();

    expect(find.text(messageIfListIsEmpty), findsNothing);
    expect(find.text(messageIfThereAreTooFewNames), findsOneWidget);
    expect(theInput.focusNode!.hasFocus, true);
    expect(onSubmitNamesWasCalled, false);
    expect(theNames, null);

    final String twoLinesTwoNames =
        'Name 1\nName ${DateTime.now().toIso8601String()}';
    tester.testTextInput.enterText(twoLinesTwoNames);

    // call "submit" action again
    await tester.tap(find.text(nextButtonText));
    await tester.pump();

    expect(onSubmitNamesWasCalled, true);
    expect(theNames, twoLinesTwoNames);
  });
}
