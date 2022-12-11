import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/svg.dart';
import 'package:meeting_web_app/bloc/auth_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GoogleSignInButton extends StatelessWidget {
  const GoogleSignInButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      height: 100,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(2.0)),
      ),
      child: Material(
        color: Colors.lightBlue,
        child: InkWell(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SvgPicture.network("https://upload.wikimedia.org/wikipedia/commons/5/53/Google_%22G%22_Logo.svg"),
              const Text("Sign in with Google"),
            ],
          ),
          onTap: () => _authenticateWithGoogle(context),
        ),
      ),
    );
  }
  void _authenticateWithGoogle(context) {
    BlocProvider.of<AuthBloc>(context).add(
      GoogleSignInRequested(),
    );
  }
}