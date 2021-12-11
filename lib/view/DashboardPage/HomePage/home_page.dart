import 'package:ajari/model/profile.dart';
import 'package:ajari/providers/profile_providers.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'component/view_santri.dart';
import 'component/view_ustaz.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Profile profile = Provider.of<ProfileProvider>(context, listen: false).profile;

    return DecoratedBox(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF62D282),
            Color(0xFF008165),
          ],
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: profile.role == "Santri"
            ? ViewSantri(name: profile.name)
            : ViewUstaz(name: profile.name),
      ),
    );
  }
}
