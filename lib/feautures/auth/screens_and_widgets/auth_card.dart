import 'package:elkood_shop_app/core/routes_names.dart';
import 'package:elkood_shop_app/feautures/auth/bloc/auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

enum AuthMode { signup, login }

class AuthCard extends StatefulWidget {
  const AuthCard({
    Key? key,
  }) : super(key: key);

  @override
  AuthCardState createState() => AuthCardState();
}

class AuthCardState extends State<AuthCard> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  AuthMode _authMode = AuthMode.login;
  String password = '';
  String name = '';
  final _passwordController = TextEditingController();
  bool _obsecureText = true;
  final FocusNode _userNameFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();
  final FocusNode _confirmPasswordFocusNode = FocusNode();
  @override
  void dispose() {
    _userNameFocusNode.dispose();
    _passwordFocusNode.dispose();
    _confirmPasswordFocusNode.dispose();
    super.dispose();
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('An Error Occurred!'),
        content: Text(message),
        actions: [
          ElevatedButton(
            child: const Text('Okay'),
            onPressed: () {
              Navigator.of(ctx).pop();
            },
          )
        ],
      ),
    );
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    _formKey.currentState!.save();

    if (_authMode == AuthMode.login) {
      BlocProvider.of<AuthBloc>(context)
          .add(LoginEvent(name: name, password: password));
    } else {
      BlocProvider.of<AuthBloc>(context)
          .add(SignUpEvent(name: name, password: password));
    }
  }

  void _switchAuthMode() {
    if (_authMode == AuthMode.login) {
      setState(() {
        _authMode = AuthMode.signup;
      });
    } else {
      setState(() {
        _authMode = AuthMode.login;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        elevation: 8.0,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
          height: _authMode == AuthMode.signup ? 350 : 280,
          constraints: BoxConstraints(
              minHeight: _authMode == AuthMode.signup ? 320 : 260),
          width: size.width * 0.75,
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  TextFormField(
                    decoration: const InputDecoration(
                        labelText: 'Username', prefixIcon: Icon(Icons.person)),
                    keyboardType: TextInputType.name,
                    focusNode: _userNameFocusNode,
                    textInputAction: TextInputAction.next,
                    onFieldSubmitted: (value) {
                      FocusScope.of(context).requestFocus(_passwordFocusNode);
                    },
                    validator: (value) {
                      if (value!.isEmpty || value.length < 3) {
                        return 'It\'s too short name!';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      name = value!;
                    },
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                        labelText: 'Password',
                        prefixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              _obsecureText = !_obsecureText;
                            });
                          },
                          icon: Icon(_obsecureText
                              ? Icons.visibility_off
                              : Icons.visibility),
                        )),
                    focusNode: _passwordFocusNode,
                    obscureText: _obsecureText,
                    controller: _passwordController,
                    validator: (value) {
                      if (value!.isEmpty || value.length < 5) {
                        return 'Password is too short!';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      password = value!;
                    },
                    textInputAction: _authMode == AuthMode.signup
                        ? TextInputAction.next
                        : TextInputAction.done,
                    onFieldSubmitted: (value) {
                      _authMode == AuthMode.signup
                          ? FocusScope.of(context)
                              .requestFocus(_passwordFocusNode)
                          : _submit();
                    },
                  ),
                  if (_authMode == AuthMode.signup)
                    TextFormField(
                      enabled: _authMode == AuthMode.signup,
                      decoration: InputDecoration(
                        labelText: 'Confirm Password',
                        prefixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              _obsecureText = !_obsecureText;
                            });
                          },
                          icon: Icon(
                            _obsecureText
                                ? Icons.visibility_off
                                : Icons.visibility,
                          ),
                        ),
                      ),
                      obscureText: _obsecureText,
                      focusNode: _confirmPasswordFocusNode,
                      validator: (value) {
                        if (value != _passwordController.text) {
                          return 'Passwords do not match!';
                        }
                        return null;
                      },
                      textInputAction: TextInputAction.done,
                      onFieldSubmitted: (value) {
                        _submit();
                      },
                    ),
                  const SizedBox(
                    height: 20,
                  ),
                  BlocConsumer<AuthBloc, AuthState>(
                    listener: (context, state) {
                      if (state is ErrorState) {
                        _showErrorDialog(state.errorMessage);
                      } else if (state is LoginDoneState) {
                        Navigator.of(context)
                            .pushReplacementNamed(Routes.productsScreen);
                      }
                    },
                    builder: (context, state) {
                      if (state is LoadinggState) {
                        return const CircularProgressIndicator();
                      } else {
                        return ElevatedButton(
                          onPressed: _submit,
                          child: Text(_authMode == AuthMode.login
                              ? 'LOGIN'
                              : 'SIGN UP'),
                        );
                      }
                    },
                  ),
                  const SizedBox(
                    height: 1,
                  ),
                  TextButton(
                    onPressed: _switchAuthMode,
                    child: Text(
                        '${_authMode == AuthMode.login ? 'SIGNUP' : 'LOGIN'} INSTEAD'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
