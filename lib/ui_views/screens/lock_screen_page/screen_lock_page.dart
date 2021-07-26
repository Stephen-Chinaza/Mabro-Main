library passcode_screen;

import 'dart:async';

import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'circle.dart';
import 'keyboard.dart';
import 'shake_curve.dart';

typedef PasswordEnteredCallback = void Function(String text);
typedef IsValidCallback = void Function();
typedef CancelCallback = void Function();

class PasscodeScreen extends StatefulWidget {
  final Widget title;
  final int passwordDigits;
  final Color backgroundColor;
  final PasswordEnteredCallback passwordEnteredCallback;

  //isValidCallback will be invoked after passcode screen will pop.
  final IsValidCallback isValidCallback;
  final CancelCallback cancelCallback;

  // Cancel button and delete button will be switched based on the screen state
  final Widget cancelButton;
  final Widget deleteButton;
  final Stream<bool> shouldTriggerVerification;
  final Widget bottomWidget;
  final CircleUIConfig circleUIConfig;
  final KeyboardUIConfig keyboardUIConfig;
  final List<String> digits;

  PasscodeScreen({
    Key key,
    @required this.title,
    this.passwordDigits = 4,
    @required this.passwordEnteredCallback,
    @required this.cancelButton,
    @required this.deleteButton,
    @required this.shouldTriggerVerification,
    this.isValidCallback,
    CircleUIConfig circleUIConfig,
    KeyboardUIConfig keyboardUIConfig,
    this.bottomWidget,
    this.backgroundColor,
    this.cancelCallback,
    this.digits,
  })  : circleUIConfig =
            circleUIConfig == null ? const CircleUIConfig() : circleUIConfig,
        keyboardUIConfig = keyboardUIConfig == null
            ? const KeyboardUIConfig()
            : keyboardUIConfig,
        super(key: key);

  @override
  State<StatefulWidget> createState() => _PasscodeScreenState();
}

class _PasscodeScreenState extends State<PasscodeScreen>
    with SingleTickerProviderStateMixin {
  final LocalAuthentication auth = LocalAuthentication();
  bool _canCheckBiometrics = false;
  List<BiometricType> _availableBiometrics;
  String _authorized = 'Not Authorized';
  bool _isAuthenticating = false;

  bool canCheckBiometrics = false;
  bool fingerPrintState;
  bool isPrint;

  Future<void> checkFirstScreen() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    fingerPrintState = (pref.getBool('setup_touch') ?? false);

    setState(() {
      if (_canCheckBiometrics && fingerPrintState) {
        isPrint = true;
        _authenticate();
      } else {
        isPrint = false;
      }
    });
  }

  Future<void> _checkBiometric() async {
    try {
      canCheckBiometrics = await auth.canCheckBiometrics;
    } on PlatformException catch (e) {
      print(e);
    }
    if (!mounted) return;

    setState(() {
      _canCheckBiometrics = canCheckBiometrics;
    });
  }

  Future<void> _getAvailableBiometrics() async {
    List<BiometricType> availableBiometrics;
    try {
      availableBiometrics = await auth.getAvailableBiometrics();
    } on PlatformException catch (e) {
      print(e);
    }
    if (!mounted) return;

    setState(() {
      _availableBiometrics = availableBiometrics;
    });
  }

  Future<void> _authenticate() async {
    bool authenticated = false;
    try {
      setState(() {
        _isAuthenticating = true;
        _authorized = 'Authenticating';
      });
      authenticated = await auth.authenticateWithBiometrics(
          localizedReason:
              "Use biometrics or tap 'Cancel' to enter your Mabro Pin",
          useErrorDialogs: true,
          stickyAuth: true);
      setState(() {
        if (authenticated) {
          _validationCallback();
        }
        _isAuthenticating = false;
        _authorized = 'Authenticating';
      });
    } on PlatformException catch (e) {
      print(e);
    }
    if (!mounted) return;

    final String message = authenticated ? 'Authorized' : 'Not Authorized';
    setState(() {
      _authorized = message;
    });
  }

  StreamSubscription<bool> streamSubscription;
  String enteredPasscode = '';
  AnimationController controller;
  Animation<double> animation;

  @override
  initState() {
    _checkBiometric();
    super.initState();
    streamSubscription = widget.shouldTriggerVerification
        .listen((isValid) => _showValidation(isValid));
    controller = AnimationController(
        duration: const Duration(milliseconds: 500), vsync: this);
    final Animation curve =
        CurvedAnimation(parent: controller, curve: ShakeCurve());
    animation = Tween(begin: 0.0, end: 10.0).animate(curve)
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          setState(() {
            enteredPasscode = '';
            controller.value = 0;
          });
        }
      })
      ..addListener(() {
        setState(() {});
      });
    fingerPrintState = true;
    isPrint = true;

    checkFirstScreen();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: widget.backgroundColor ?? Colors.black.withOpacity(0.8),
      body: SafeArea(
        child: OrientationBuilder(
          builder: (context, orientation) {
            return orientation == Orientation.portrait
                ? _buildPortraitPasscodeScreen()
                : _buildLandscapePasscodeScreen();
          },
        ),
      ),
    );
  }

  _buildPortraitPasscodeScreen() => Stack(
        children: [
          Positioned(
            top: 100,
            left: 8,
            right: 10,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                widget.title,
                Container(
                  margin: const EdgeInsets.only(top: 20),
                  height: 40,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: _buildCircles(),
                  ),
                ),
                _buildKeyboard(),
                widget.bottomWidget != null
                    ? widget.bottomWidget
                    : GestureDetector(
                        onTap: () {
                          _authenticate();
                          print(isPrint);
                        },
                        child: Visibility(
                          visible: isPrint,
                          child: Icon(Icons.fingerprint_sharp,
                              size: 60, color: Colors.white),
                        ))
              ],
            ),
          ),
          Positioned(
            child: Align(
              alignment: Alignment.bottomRight,
              child: _buildDeleteButton(),
            ),
          ),
        ],
      );

  _buildLandscapePasscodeScreen() => Stack(
        children: [
          Positioned(
            child: Center(
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    child: Stack(
                      children: <Widget>[
                        Positioned(
                          child: Align(
                            alignment: Alignment.center,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                widget.title,
                                Container(
                                  margin: const EdgeInsets.only(top: 20),
                                  height: 40,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: _buildCircles(),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        widget.bottomWidget != null
                            ? Positioned(
                                child: Align(
                                    alignment: Alignment.topCenter,
                                    child: widget.bottomWidget),
                              )
                            : Container()
                      ],
                    ),
                  ),
                  _buildKeyboard(),
                ],
              ),
            ),
          ),
          Positioned(
            child: Align(
              alignment: Alignment.bottomRight,
              child: _buildDeleteButton(),
            ),
          )
        ],
      );

  _buildKeyboard() => Container(
        child: Keyboard(
          onKeyboardTap: _onKeyboardButtonPressed,
          keyboardUIConfig: widget.keyboardUIConfig,
          digits: widget.digits,
        ),
      );

  List<Widget> _buildCircles() {
    var list = <Widget>[];
    var config = widget.circleUIConfig;
    var extraSize = animation.value;
    for (int i = 0; i < widget.passwordDigits; i++) {
      list.add(
        Container(
          margin: EdgeInsets.all(8),
          child: Circle(
            filled: i < enteredPasscode.length,
            circleUIConfig: config,
            extraSize: extraSize,
          ),
        ),
      );
    }
    return list;
  }

  _onDeleteCancelButtonPressed() {
    if (enteredPasscode.length > 0) {
      setState(() {
        enteredPasscode =
            enteredPasscode.substring(0, enteredPasscode.length - 1);
      });
    } else {
      if (widget.cancelCallback != null) {
        widget.cancelCallback();
      }
    }
  }

  _onKeyboardButtonPressed(String text) {
    setState(() {
      if (enteredPasscode.length < widget.passwordDigits) {
        enteredPasscode += text;
        if (enteredPasscode.length == widget.passwordDigits) {
          widget.passwordEnteredCallback(enteredPasscode);
        }
      }
    });
  }

  @override
  didUpdateWidget(PasscodeScreen old) {
    super.didUpdateWidget(old);
    // in case the stream instance changed, subscribe to the new one
    if (widget.shouldTriggerVerification != old.shouldTriggerVerification) {
      streamSubscription.cancel();
      streamSubscription = widget.shouldTriggerVerification
          .listen((isValid) => _showValidation(isValid));
    }
  }

  @override
  dispose() {
    controller.dispose();
    streamSubscription.cancel();
    super.dispose();
  }

  _showValidation(bool isValid) {
    if (isValid) {
      _validationCallback();
    } else {
      controller.forward();
    }
  }

  _validationCallback() {
    if (widget.isValidCallback != null) {
      widget.isValidCallback();
    } else {
      print(
          "You didn't implement validation callback. Please handle a state by yourself then.");
    }
  }

  Widget _buildDeleteButton() {
    return Container(
      child: CupertinoButton(
        onPressed: _onDeleteCancelButtonPressed,
        child: Container(
          margin: widget.keyboardUIConfig.digitInnerMargin,
          child: enteredPasscode.length == 0
              ? widget.cancelButton
              : widget.deleteButton,
        ),
      ),
    );
  }
}
