import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class RequestUserInfo extends StatefulWidget {
  RequestUserInfo({
    String initialUserNameValue = '',
    String? initialPreferredPronounValue,
    required String Function(String) introductoryTextProvider,
    required void Function(String, String) onSubmitUserInfo,
    required String Function() supportedPronounsProvider,
  })  : _initialPreferredPronounValue = initialPreferredPronounValue,
        _initialUserNameValue = initialUserNameValue,
        _introductoryTextProvider = introductoryTextProvider,
        _onSubmitUserInfo = onSubmitUserInfo,
        _supportedPronounsProvider = supportedPronounsProvider;

  final String? _initialPreferredPronounValue;
  final String _initialUserNameValue;
  final String Function(String) _introductoryTextProvider;
  final void Function(String, String) _onSubmitUserInfo;
  final String Function() _supportedPronounsProvider;

  @override
  State<StatefulWidget> createState() => _RequestUserInfoState();
}

class _RequestUserInfoState extends State<RequestUserInfo> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late final TextEditingController _userNameController;
  late final FocusNode _userNameFocusNode;
  String? _preferredPronoun;

  void _onPreferredPrnounChanged(String? value) {
    setState(() {
      _preferredPronoun = value;
    });
  }

  void _trySubmitTheForm() {
    if (_formKey.currentState!.validate()) {
      widget._onSubmitUserInfo(_userNameController.text, _preferredPronoun!);
    }
  }

  @override
  Widget build(BuildContext context) {
    AppLocalizations l10n = AppLocalizations.of(context);

    List<String> optionValues = widget._supportedPronounsProvider().split('\n');
    List<String> optionLabels = l10n.pronounOptions_labels.split('\n');
    assert(optionValues.length == optionLabels.length);

    // // logic duplicates approach for cursorColor from text_field.dart
    // final ThemeData theme = Theme.of(context);
    // final DefaultSelectionStyle selectionStyle = DefaultSelectionStyle.of(context);
    // final Color activeColor;

    // switch (theme.platform) {
    //   case TargetPlatform.iOS:
    //   case TargetPlatform.macOS:
    //     final CupertinoThemeData cupertinoTheme = CupertinoTheme.of(context);
    //     activeColor = selectionStyle.cursorColor ?? cupertinoTheme.primaryColor;
    //     break;

    //   case TargetPlatform.android:
    //   case TargetPlatform.fuchsia:
    //   case TargetPlatform.linux:
    //   case TargetPlatform.windows:
    //     activeColor = selectionStyle.cursorColor ?? theme.colorScheme.primary;
    //     break;
    // }

    List<Widget> options = [];

    for (int i = 0; i < optionValues.length; i++) {
      options.add(RadioListTile<String>(
        title: Text(optionLabels[i]),
        value: optionValues[i],
        groupValue: _preferredPronoun,
        // activeColor: activeColor,
        onChanged: _onPreferredPrnounChanged,
      ));
    }

    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(widget._introductoryTextProvider(_preferredPronoun ?? '')),
          const SizedBox(height: 20),
          TextFormField(
            controller: _userNameController,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: l10n.hintForUserNameRequest(_preferredPronoun ?? ''),
            ),
            focusNode: _userNameFocusNode,
            validator: (String? value) {
              if (value == null ||
                  value.isEmpty ||
                  value.replaceAll(RegExp(r'\s+'), '').isEmpty) {
                _userNameFocusNode.requestFocus();
                return l10n
                    .askUserToSpecifyNotEmptyOwnName(_preferredPronoun ?? '');
              }
              return null;
            },
            onFieldSubmitted: (String value) {
              _trySubmitTheForm();
            },
          ),
          const SizedBox(height: 20),
          FormField(
            builder: (FormFieldState<Object?> field) {
              return InputDecorator(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  errorText: field.hasError ? field.errorText : null,
                  labelText: l10n
                      .hintForPreferredPronounRequest(_preferredPronoun ?? ''),
                ),
                child: Column(
                  children: options,
                ),
              );
            },
            validator: (value) {
              if (_preferredPronoun == null) {
                return l10n.askUserToSpecifyPreferredPronoun('');
              }
              return null;
            },
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: _trySubmitTheForm,
            child: Text(AppLocalizations.of(context).nextButtonText),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _userNameController.dispose();
    _userNameFocusNode.dispose();

    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    _userNameController = TextEditingController();
    _userNameController.text = widget._initialUserNameValue;
    _userNameFocusNode = FocusNode();

    List<String> optionValues = widget._supportedPronounsProvider().split('\n');
    bool initialPreferredPronounValueIsValid = false;
    for (String optionValue in optionValues) {
      if (optionValue == widget._initialPreferredPronounValue) {
        initialPreferredPronounValueIsValid = true;
        break;
      }
    }
    if (initialPreferredPronounValueIsValid) {
      _preferredPronoun = widget._initialPreferredPronounValue;
    }
  }
}
