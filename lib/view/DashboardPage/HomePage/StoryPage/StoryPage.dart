import 'package:ajari/component/AppBar/AppBarBack.dart';
import 'package:ajari/theme/PaletteColor.dart';
import 'package:ajari/theme/SpacingDimens.dart';
import 'package:ajari/view/DashboardPage/HomePage/StoryPage/ChildStoryPage/NabiIbrahimPage.dart';
import 'package:ajari/view/DashboardPage/HomePage/StoryPage/ChildStoryPage/NabiMusaPage.dart';
import 'package:flutter/material.dart';

class StoryPage extends StatefulWidget {
  const StoryPage({Key? key}) : super(key: key);

  @override
  _StoryPageState createState() => _StoryPageState();
}

class _StoryPageState extends State<StoryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PaletteColor.primarybg,
      appBar: AppBarBack(
        ctx: context,
        title: "Halaman Story",
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView(
          physics: const BouncingScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
          ),
          children: [
            cardStry(
              image: 'assets/images/nabi_ibrahim.png',
              title: const Text(
                "Kisah Nabi Ibrahim",
                style: TextStyle(color: PaletteColor.primarybg, fontSize: 16),
              ),
              color: const Color(0xFF9F5A2A),
              onTap: (){
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const NabiIbrahimPage(),
                  ),
                );
              }
            ),
            cardStry(
              image: 'assets/images/nabi_musa.png',
              title: const Text(
                "Kisah Nabi Musa",
                style: TextStyle(color: Color(0xFF620101), fontSize: 16),
              ),
              color: const Color(0xFFF7EAC0),
              onTap: (){
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const NabiMusaPage(),
                  ),
                );
              }
            ),
            cardStry(
              image: 'assets/images/nabi_nuh.png',
              title: const Text(
                "Kisah Nabi Nuh",
                style: TextStyle(color: PaletteColor.primarybg, fontSize: 16),
              ),
              color: const Color(0xFF8DAA3C),
              onTap: (){
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const NabiMusaPage(),
                  ),
                );
              }
            ),
          ],
        ),
      ),
    );
  }

  Widget cardStry({image, title, color, onTap}) {
    return Padding(
      padding: const EdgeInsets.all(2),
      child: Card(
        color: color,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: TextButton(
          style: ButtonStyle(
            padding: MaterialStateProperty.all<EdgeInsets>(const EdgeInsets.all(0)),
          ),
          onPressed: onTap,
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: SpacingDimens.spacing8),
                child: Align(
                  child: Image.asset(
                    image,
                    height: 100,
                  ),
                  alignment: Alignment.bottomLeft,
                ),
              ),
              SizedBox(
                width: 120,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: title,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
