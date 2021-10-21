import 'package:ajari/theme/PaletteColor.dart';
import 'package:ajari/theme/SpacingDimens.dart';
import 'package:ajari/theme/TypographyStyle.dart';
import 'package:ajari/view/DashboardPage/KelasPage/ChartPage/ChatPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RoomPage extends StatefulWidget {
  @override
  _RoomPageState createState() => _RoomPageState();
}

class _RoomPageState extends State<RoomPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
          ),
          Container(
            child: Padding(
              padding: const EdgeInsets.only(
                top: SpacingDimens.spacing32,
                left: SpacingDimens.spacing12,
                right: SpacingDimens.spacing12,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text("In Room", style: TypographyStyle.subtitle1),
                  Flexible(
                    fit: FlexFit.loose,
                    child: GridView(
                      physics: BouncingScrollPhysics(),
                      children: [
                        avatarMeet(nama: "Pengajar"),
                      ],
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 4,
                      ),
                    ),
                  ),
                  Text("Listening", style: TypographyStyle.subtitle1),
                  Flexible(
                    fit: FlexFit.loose,
                    child: GridView(
                      physics: BouncingScrollPhysics(),
                      children: [
                        avatarMeet(nama: "Nur Syahfei"),
                      ],
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 4,
                      ),
                    ),
                  ),
                  SizedBox(height: 100)
                ],
              ),
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height - 100,
            width: MediaQuery.of(context).size.width,
            height: 100,
            child: Container(
              padding: const EdgeInsets.only(
                left: SpacingDimens.spacing16,
                right: SpacingDimens.spacing16,
              ),
              decoration: BoxDecoration(
                color: PaletteColor.primary,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.4),
                    spreadRadius: 1,
                    blurRadius: 2,
                    offset: Offset(0, 0),
                  )
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Row(
                    children: [
                      Container(
                        height: 56,
                        width: 56,
                        margin: const EdgeInsets.only(
                          right: SpacingDimens.spacing12,
                        ),
                        decoration: BoxDecoration(
                          color: PaletteColor.primarybg,
                          borderRadius: BorderRadius.circular(24),
                        ),
                        child: Icon(Icons.mic),
                      ),
                      Container(
                        height: 56,
                        width: 56,
                        margin: const EdgeInsets.only(
                          right: SpacingDimens.spacing12,
                        ),
                        decoration: BoxDecoration(
                          color: PaletteColor.red,
                          borderRadius: BorderRadius.circular(24),
                        ),
                        child: TextButton(
                          style: ButtonStyle(
                            shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                RoundedRectangleBorder()),
                          ),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Icon(
                            Icons.call_end,
                            color: PaletteColor.primarybg,
                          ),
                        ),
                      ),
                      Container(
                        height: 56,
                        width: 56,
                        decoration: BoxDecoration(
                          color: PaletteColor.primarybg,
                          borderRadius: BorderRadius.circular(24),
                        ),
                        child: Icon(Icons.videocam_off),
                      ),
                    ],
                  ),
                  Container(
                    height: 56,
                    width: 56,
                    decoration: BoxDecoration(
                      color: PaletteColor.primarybg,
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: TextButton(
                      style: ButtonStyle(
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder()),
                      ),
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => ChatPage()));
                      },
                      child: Icon(
                        Icons.message,
                        color: PaletteColor.grey,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget avatarMeet({nama}) {
    return Padding(
      padding: const EdgeInsets.only(
        right: SpacingDimens.spacing8,
        left: SpacingDimens.spacing8,
      ),
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.all(2),
            decoration: BoxDecoration(
                color: PaletteColor.grey40,
                borderRadius: BorderRadius.circular(50)),
            child: Padding(
              padding: const EdgeInsets.all(SpacingDimens.spacing8),
              child: Icon(
                Icons.person,
                size: 30,
                color: PaletteColor.grey80,
              ),
            ),
          ),
          Text(nama, overflow: TextOverflow.ellipsis),
        ],
      ),
    );
  }
}
