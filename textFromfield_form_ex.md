
https://github.com/JohannesMilke/textformfield_example


```dart

import 'package:flutter/material.dart';

class TextfieldGeneralWidget extends StatefulWidget {
  const TextfieldGeneralWidget({super.key});

  @override
  State<TextfieldGeneralWidget> createState() => _TextfieldGeneralWidgetState();
}

class _TextfieldGeneralWidgetState extends State<TextfieldGeneralWidget> {
  var textController = TextEditingController();

  String? username = '';

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: EdgeInsets.all(20),
        child: Form(
          key: formKey,
          child: Column(
            // mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              buildUsername(),
              SizedBox(
                height: 24,
              ),
              SizedBox(
                height: 30,
                child: ElevatedButton(
                  child: Text('Submit'),
                  onPressed: () {
                    // print(textController.text);
                    final isvalid = formKey.currentState?.validate();
                    debugPrint(textController.text);
                    if (isvalid!) {
                      formKey.currentState?.save();

                      debugPrint("userName: $username");
                    }
                  },
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Text(
                "UserName : $username",
                style: TextStyle(fontSize: 20),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildUsername() => TextFormField(
        controller: textController,
        decoration: InputDecoration(
          labelText: 'Username',
          border: OutlineInputBorder(),
          // errorBorder:
          //     OutlineInputBorder(borderSide: BorderSide(color: Colors.purple)),
          // focusedErrorBorder:
          //     OutlineInputBorder(borderSide: BorderSide(color: Colors.purple)),
          // errorStyle: TextStyle(color: Colors.purple),
        ),
        validator: (value) {
          if ((value?.length)! < 4) {
            return 'Enter at least 4 characters';
          } else {
            return null;
          }
        },
        maxLength: 30,
        onSaved: (value) => setState(() => username = value),
      );
}
```
