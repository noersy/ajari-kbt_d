import 'package:ajari/route/route_transisition.dart';
import 'package:ajari/theme/palette_color.dart';
import 'package:ajari/theme/spacing_dimens.dart';
import 'package:ajari/theme/typography_style.dart';
import 'package:ajari/view/DashboardPage/KelasPage/DiskusiPage/diskusi_page.dart';
import 'package:flutter/material.dart';

class DiskusiList extends StatefulWidget {
  final Map<String, dynamic> diskusi;
  final DateTime date;
  final String id;

  const DiskusiList({
    Key? key,
    required this.diskusi,
    required this.date,
    required this.id,
  }) : super(key: key);

  @override
  State<DiskusiList> createState() => _DiskusiListState();
}

class _DiskusiListState extends State<DiskusiList> {
  @override
  Widget build(BuildContext context) {
    String _subject = widget.diskusi['subject'];

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(
            bottom: SpacingDimens.spacing12,
            left: SpacingDimens.spacing8,
          ),
          child: Stack(
            alignment: Alignment.centerLeft,
            children: [
              Container(
                margin: const EdgeInsets.only(left: 40.0),
                width: MediaQuery.of(context).size.width - 145,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: PaletteColor.primarybg,
                    elevation: 2,
                    padding: const EdgeInsets.all(SpacingDimens.spacing8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () {
                    Navigator.of(context).push(routeTransition(
                        DiskusiPage(subject: _subject, id: widget.id)));
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Text(
                              _subject,
                              style: TypographyStyle.paragraph,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: PaletteColor.primary,
                          borderRadius: BorderRadius.circular(4.0),
                        ),
                        padding: const EdgeInsets.only(
                          left: SpacingDimens.spacing8,
                          right: SpacingDimens.spacing8,
                          top: SpacingDimens.spacing4,
                          bottom: SpacingDimens.spacing4,
                        ),
                        child: Row(
                          children: [
                            Text(
                              "Gabung",
                              style: TypographyStyle.button2
                                  .copyWith(color: PaletteColor.primarybg),
                            ),
                            const SizedBox(width: 2),
                            const Icon(Icons.chat, size: 18)
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 20,
                    width: 3.5,
                    decoration: BoxDecoration(
                      color: PaletteColor.grey60,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    margin: const EdgeInsets.only(
                        left: SpacingDimens.spacing16 + 1.8),
                  ),
                  Container(
                    height: 8,
                    width: 8,
                    margin: const EdgeInsets.only(
                      top: 2,
                      bottom: 2,
                      left: SpacingDimens.spacing16 - 0.5,
                    ),
                    decoration: BoxDecoration(
                      color: PaletteColor.primary,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  Container(
                    height: 20,
                    width: 3.5,
                    decoration: BoxDecoration(
                      color: PaletteColor.grey60,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    margin: const EdgeInsets.only(
                      left: SpacingDimens.spacing16 + 1.8,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
