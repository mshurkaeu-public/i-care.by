import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class RequestNotEmptyListOfPersonsNames extends StatefulWidget {
  const RequestNotEmptyListOfPersonsNames({
    super.key,
    required String hintForInputField,
    //TODO: review a possibility to convert this parameter to List<String>
    String initialValue = '',
    required String introductoryText,
    int? maxLines = 1,
    required String messageIfListIsEmpty,
    String messageIfThereAreTooFewNames = '',
    int? minLines,
    int minNames = 1,
    required void Function(String) onSubmitNames,
  })  : _hintForInputField = hintForInputField,
        _initialValue = initialValue,
        _introductoryText = introductoryText,
        _maxLines = maxLines,
        _messageIfListIsEmpty = messageIfListIsEmpty,
        _messageIfThereAreTooFewNames = messageIfThereAreTooFewNames,
        _minLines = minLines,
        _minNames = minNames,
        _onSubmitNames = onSubmitNames;

  final String _hintForInputField;
  final String _initialValue;
  final String _introductoryText;
  final int? _maxLines;
  final String _messageIfListIsEmpty;
  final String _messageIfThereAreTooFewNames;
  final int? _minLines;
  final int _minNames;
  final Function(String) _onSubmitNames;

  @override
  State<StatefulWidget> createState() =>
      _RequestNotEmptyListOfPersonsNamesState();
}

class _RequestNotEmptyListOfPersonsNamesState
    extends State<RequestNotEmptyListOfPersonsNames> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late final TextEditingController _namesController;
  late final FocusNode _namesFocusNode;

  void _trySubmitTheForm() {
    if (_formKey.currentState!.validate()) {
      widget._onSubmitNames(_namesController.text);
    } else {
      _namesFocusNode.requestFocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(widget._introductoryText),
          const SizedBox(height: 20),
          TextFormField(
            controller: _namesController,
            decoration: InputDecoration(
              border: const OutlineInputBorder(),
              labelText: widget._hintForInputField,
            ),
            focusNode: _namesFocusNode,
            validator: (value) {
              if (value == null ||
                  value.isEmpty ||
                  value.replaceAll(RegExp(r'\s+'), '').isEmpty) {
                return widget._messageIfListIsEmpty;
              } else if (widget._minNames > 1) {
                List<String> names = value.split('\n');
                int actualNamesCount = 0;
                for (String name in names) {
                  name = name.trim();
                  if (name.isNotEmpty) {
                    actualNamesCount++;
                  }
                }
                if (actualNamesCount < widget._minNames) {
                  return widget._messageIfThereAreTooFewNames;
                }
              }

              return null;
            },
            onFieldSubmitted: (value) {
              _trySubmitTheForm();
            },
            maxLines: widget._maxLines,
            minLines: widget._minLines,
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
    _namesController.dispose();
    _namesFocusNode.dispose();

    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    _namesController = TextEditingController();
    _namesController.text = widget._initialValue;
    _namesFocusNode = FocusNode();
  }
}
