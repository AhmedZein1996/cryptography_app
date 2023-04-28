import 'package:cryptography/symetric.dart';
import 'package:flutter/material.dart';
import 'package:encrypt/encrypt.dart' as encrypt;

import 'constant.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String plainText; //'Lorem ipsum dolor sit amet, consectetur adipiscing elit';
  var secretKey;
  var iv;

  encrypt.Encrypted encryptedMessage;
  String decryptedMessage;

  String inputCipherText;
  final _textController = TextEditingController();
  //TextEditingController _plainTextController;

  @override
  void initState() {
    _createAESKey();
    super.initState();
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  void _createAESKey() {
    secretKey = encrypt.Key.fromUtf8('my 32 length key................');
    iv = encrypt.IV.fromLength(16);
    // R4PxiU3h8YoIRqVowBXm36ZcCeNeZ4s1OvVBTfFlZRdmohQqOpPQqD1YecJeZMAop/hZ4OxqgC1WtwvX/hP9mw==
  }

  void _encryption() {
    if (plainText == null) {
      return;
    }
    if (plainText.isEmpty) {
      print('empty');
      return;
    }
    if (plainText.isNotEmpty) {
      setState(() {
        encryptedMessage = Symmetric.doAESEncryption(plainText, secretKey, iv);
      });
      _textController.text = encryptedMessage.base64;
      inputCipherText = encryptedMessage.base64;
      showDialog(
          context: context,
          builder: (context) =>
              _buildDialog('Encrypted message:', encryptedMessage.base64));
    }
  }

  void _decryption() {
    if (plainText == null || encryptedMessage == null) {
      return;
    }
    if (plainText.isEmpty) {
      print('empty');
      return;
    }
    if (inputCipherText != encryptedMessage.base64) {
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(
        buildSnackBar(),
      );
      return;
    }
    if (plainText.isNotEmpty) {
      setState(() {
        decryptedMessage =
            Symmetric.doAESDecryption(encryptedMessage, secretKey, iv);
      });
      showDialog(
          context: context,
          builder: (context) =>
              _buildDialog('Decrypted message:', decryptedMessage));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: TextField(
                  decoration: kInputTextFieldDecoration,
                  onChanged: (value) {
                    plainText = value;
                  },
                  maxLines: 2,
                  style: TextStyle(fontSize: 18, color: Colors.indigoAccent),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                height: 55,
                width: 150,
                child: RaisedButton(
                  child: Text(
                    'Encrypt',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  color: Colors.orange.shade600,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(25),
                    ),
                  ),
                  onPressed: _encryption,
                ),
              ),
//              SizedBox(
//                height: 10,
//              ),
//              plainText == null
//                  ? Text('')
//                  : Text(
//                      'Encrypted message:${encryptedMessage.base64}',
//                      style: TextStyle(fontSize: 18, color: Colors.purple),
//                    ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: TextField(
                  controller: _textController,
                  decoration: kInputTextFieldDecoration.copyWith(
                      hintText:
                          'Here will show cipher text you want to decrypt'),
                  onChanged: (value) {
                    inputCipherText = value;
                  },
                  maxLines: 2,
                  style: TextStyle(fontSize: 18, color: Colors.indigoAccent),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                height: 55,
                width: 150,
                child: RaisedButton(
                    elevation: 5,
                    child: Text(
                      'Decrypt',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    color: Colors.orange.shade600,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(25),
                      ),
                    ),
                    onPressed: _decryption),
              ),
            ],
          ),
        ),
      ),
    );
  }

  AlertDialog _buildDialog(type, text) {
    return AlertDialog(
      title: Text(type),
      content: Text(
        text,
        style: TextStyle(fontSize: 18, color: Colors.purple),
      ),
      actions: <Widget>[
        FlatButton(
          child: Text(
            'Okay',
            style: TextStyle(fontSize: 18),
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }

  SnackBar buildSnackBar() {
    return SnackBar(
      content: Text(
          'oops, the input cipher text does not matched with the original enrypted message!'),
    );
  }
}
