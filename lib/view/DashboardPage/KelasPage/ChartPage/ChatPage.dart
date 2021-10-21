

import 'package:ajari/component/AppBar/AppBarBack.dart';
import 'package:ajari/theme/PaletteColor.dart';
import 'package:ajari/theme/SpacingDimens.dart';
import 'package:ajari/theme/TypographyStyle.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatefulWidget {
  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PaletteColor.primarybg,
      appBar: AppBarBack(ctx: context, title: "Chat",),
      body: Container(
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          color: PaletteColor.primarybg,
          borderRadius: BorderRadius.circular(4),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top:SpacingDimens.spacing28),
                  child: Column(
                    children: [
                      Text(
                        'Tidak ada pesan.',
                        style: TypographyStyle.paragraph.merge(
                          TextStyle(
                            color: PaletteColor.grey60,
                          ),
                        ),
                      ),
                      SizedBox(height: 38),
                    ],
                  ),
                ),
              ],
            ),
            Container(
              decoration: BoxDecoration(
                color: PaletteColor.primary,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(5),
                  topRight: Radius.circular(5),
                  bottomLeft: Radius.circular(2),
                  bottomRight: Radius.circular(2),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(SpacingDimens.spacing8),
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                            color: PaletteColor.primarybg,
                            borderRadius: BorderRadius.circular(10)),
                        child: TextFormField(
                          decoration: InputDecoration(
                            isDense: true,
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: SpacingDimens.spacing8,
                              vertical: SpacingDimens.spacing8,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: SpacingDimens.spacing8,
                    ),
                    Icon(
                      Icons.send,
                      color: PaletteColor.primarybg,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
