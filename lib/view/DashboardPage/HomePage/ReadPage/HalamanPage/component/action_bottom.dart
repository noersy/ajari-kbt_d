import 'package:ajari/theme/palette_color.dart';
import 'package:ajari/theme/spacing_dimens.dart';
import 'package:ajari/theme/typography_style.dart';
import 'package:flutter/material.dart';

class ActionBottom extends StatefulWidget {
  final VoidCallback nextAction;
  final VoidCallback prevAction;
  final int curretHalaman;

  const ActionBottom({
    Key? key,
    required this.nextAction,
    required this.prevAction,
    required this.curretHalaman,
  }) : super(key: key);

  @override
  _ActionBottomState createState() => _ActionBottomState();
}

class _ActionBottomState extends State<ActionBottom> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
        left: SpacingDimens.spacing8,
        right: SpacingDimens.spacing8,
        bottom: SpacingDimens.spacing8,
      ),
      width: 300,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          if(widget.curretHalaman > 1) ElevatedButton(
            onPressed: widget.prevAction,
            style: ElevatedButton.styleFrom(
              primary: PaletteColor.primarybg,
              onPrimary: PaletteColor.primary,
              padding: const EdgeInsets.all(SpacingDimens.spacing4),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25),
              ),
            ),
            child: Row(
              children: const [
                Padding(
                  padding: EdgeInsets.all(SpacingDimens.spacing4),
                  child: Icon(
                    Icons.arrow_back,
                    size: 20,
                    color: PaletteColor.grey,
                  ),
                ),
              ],
            ),
          )
          else const SizedBox(width: 70),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              primary: PaletteColor.primarybg,
              onPrimary: PaletteColor.primary,
              padding: const EdgeInsets.all(SpacingDimens.spacing4),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25),
              ),
            ),
            child: Row(
              children: [
                if(widget.curretHalaman > 1) Padding(
                  padding: const EdgeInsets.only(
                    left: SpacingDimens.spacing8,
                    right: SpacingDimens.spacing8,
                  ),
                  child: Text(
                    "${widget.curretHalaman - 1}",
                    style: TypographyStyle.caption1,
                  ),
                )
                else const SizedBox(width: 20),
                Padding(
                  padding: const EdgeInsets.only(
                    left: SpacingDimens.spacing24,
                    right: SpacingDimens.spacing24,
                  ),
                  child: Text(
                    "${widget.curretHalaman}",
                    style: TypographyStyle.button1,
                  ),
                ),
                if(widget.curretHalaman < 30) Padding(
                  padding: const EdgeInsets.only(
                    left: SpacingDimens.spacing8,
                    right: SpacingDimens.spacing8,
                  ),
                  child: Text(
                    "${widget.curretHalaman + 1}",
                    style: TypographyStyle.caption1,
                  ),
                )
                else const SizedBox(width: 20),
              ],
            ),
          ),
          if(widget.curretHalaman < 30) ElevatedButton(
            onPressed: widget.nextAction,
            style: ElevatedButton.styleFrom(
              primary: PaletteColor.primarybg,
              onPrimary: PaletteColor.primary,
              padding: const EdgeInsets.all(SpacingDimens.spacing4),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25),
              ),
            ),
            child: Row(
              children: const [
                Padding(
                  padding: EdgeInsets.all(SpacingDimens.spacing4),
                  child: Icon(
                    Icons.arrow_forward,
                    size: 20,
                    color: PaletteColor.grey,
                  ),
                ),
              ],
            ),
          )
          else const SizedBox(width: 70),
        ],
      ),
    );
  }
}
