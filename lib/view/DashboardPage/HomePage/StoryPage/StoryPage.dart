import 'package:ajari/component/AppBar/AppBarBack.dart';
import 'package:ajari/theme/PaletteColor.dart';
import 'package:ajari/theme/SpacingDimens.dart';
import 'package:ajari/view/DashboardPage/HomePage/StoryPage/ChildStoryPage/NabiIbrahimPage.dart';
import 'package:ajari/view/DashboardPage/HomePage/StoryPage/ChildStoryPage/NabiMusaPage.dart';
import 'package:flutter/material.dart';

class StoryPage extends StatefulWidget {
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
      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: GridView(
            physics: BouncingScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
            ),
            children: [
              CardStry(
                image: 'assets/images/nabi_ibrahim.png',
                title: Text(
                  "Kisah Nabi Ibrahim",
                  style: TextStyle(color: PaletteColor.primarybg, fontSize: 16),
                ),
                color: Color(0xFF9F5A2A),
                onTap: (){
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => NabiIbrahimPage(),
                    ),
                  );
                }
              ),
              CardStry(
                image: 'assets/images/nabi_musa.png',
                title: Text(
                  "Kisah Nabi Musa",
                  style: TextStyle(color: Color(0xFF620101), fontSize: 16),
                ),
                color: Color(0xFFF7EAC0),
                onTap: (){
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => NabiMusaPage(),
                    ),
                  );
                }
              ),
              CardStry(
                image: 'assets/images/nabi_nuh.png',
                title: Text(
                  "Kisah Nabi Nuh",
                  style: TextStyle(color: PaletteColor.primarybg, fontSize: 16),
                ),
                color: Color(0xFF8DAA3C),
                onTap: (){
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => NabiMusaPage(),
                    ),
                  );
                }
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget CardStry({image, title, color, onTap}) {
    return Padding(
      padding: const EdgeInsets.all(2),
      child: Card(
        color: color,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: TextButton(
          style: ButtonStyle(
            padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.all(0)),
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
              Container(
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
