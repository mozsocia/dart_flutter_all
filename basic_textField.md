https://www.youtube.com/watch?v=C5hJIKCTrvk 

https://github.com/JohannesMilke/textfield_example

```dart

import 'package:flutter/material.dart';

class TextfieldGeneralWidget extends StatefulWidget {
  const TextfieldGeneralWidget({super.key});

  @override
  State<TextfieldGeneralWidget> createState() => _TextfieldGeneralWidgetState();
}

class _TextfieldGeneralWidgetState extends State<TextfieldGeneralWidget> {
  var textController = TextEditingController();
  var _text = "Please Enter text and press submit";

  String password = '';
  bool isPasswordVisible = true;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          // mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            buildEmail(),
            SizedBox(
              height: 24,
            ),
            SizedBox(
              height: 30,
              child: ElevatedButton(
                child: Text('Submit'),
                onPressed: () {
                  print(textController.text);
                  setState(() {
                    _text = textController.text;
                  });
                },
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              "${_text}",
              style: TextStyle(
                fontSize: 30,
                color: Colors.blue[500],
              ),
            ),
            SizedBox(
              height: 30,
            ),
            buildPassword()
          ],
        ),
      ),
    );
  }

  Widget buildEmail() => TextField(
        controller: textController,
        decoration: InputDecoration(
          labelText: 'Email',
          border: OutlineInputBorder(),
        ),
        keyboardType: TextInputType.emailAddress,
        textInputAction: TextInputAction.done,
      );

  Widget buildPassword() => TextField(
        onChanged: (value) => setState(() => this.password = value),
        onSubmitted: (value) => setState(() => this.password = value),
        decoration: InputDecoration(
          hintText: 'Your Password...',
          labelText: 'Password',
          errorText: 'Password is wrong',
          suffixIcon: IconButton(
            icon: isPasswordVisible
                ? Icon(Icons.visibility_off)
                : Icon(Icons.visibility),
            onPressed: () =>
                setState(() => isPasswordVisible = !isPasswordVisible),
          ),
          border: OutlineInputBorder(),
        ),
        obscureText: isPasswordVisible,
      );
}


```
