import 'package:ajari/theme/palette_color.dart';
import 'package:ajari/theme/spacing_dimens.dart';
import 'package:ajari/view/DashboardPage/KelasPage/AbsenPage/component/create_absent.dart';
import 'package:ajari/view/DashboardPage/KelasPage/MeetingPage/component/dialogcreate_meet.dart';
import 'package:ajari/view/DashboardPage/KelasPage/component/create_diskusi.dart';
import 'package:flutter/material.dart';

class DialogCreate extends StatelessWidget {
  final DateTime dateTime;

  const DialogCreate({Key? key, required this.dateTime}) : super(key: key);

  void createAbsent(context) async {
    var result = await showDialog(
          context: context,
          builder: (context) => DialogCreateAbsen(date: dateTime),
        ) ?? "Cancel";

    Navigator.of(context).pop();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(result), duration: const Duration(milliseconds: 500),));
  }

  void createMeet(context) async{
    var result = await showDialog(
      context: context,
      builder: (context) =>  DialogCreateMeet(date: dateTime),
    );

    Navigator.of(context).pop();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(result)));
  }

  void createDiskusi(context) async{
    var result = await showDialog(
      context: context,
      builder: (context) =>  DialogCreateDiskusi(date: dateTime),
    );

    Navigator.of(context).pop();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(result)));
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: PaletteColor.primarybg2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      titlePadding: const EdgeInsets.all(0),
      actions: [
        TextButton(
          style: TextButton.styleFrom(
            primary: PaletteColor.primary,
            backgroundColor: PaletteColor.primary.withOpacity(0.2),
            padding: const EdgeInsets.all(SpacingDimens.spacing16),
          ),
          onPressed: () => createAbsent(context),
          child: const SizedBox(
            width: double.infinity,
            child: Center(child: Text("Absent")),
          ),
        ),
        const SizedBox(height: SpacingDimens.spacing8),
        TextButton(
          style: TextButton.styleFrom(
            primary: PaletteColor.primary,
            backgroundColor: PaletteColor.primary.withOpacity(0.2),
            padding: const EdgeInsets.all(SpacingDimens.spacing16),
          ),
          onPressed: () => createMeet(context),
          child: const SizedBox(
            width: double.infinity,
            child: Center(child: Text("Room Meet")),
          ),
        ),
        const SizedBox(height: SpacingDimens.spacing8),
        TextButton(
          style: TextButton.styleFrom(
            primary: PaletteColor.primary,
            backgroundColor: PaletteColor.primary.withOpacity(0.2),
            padding: const EdgeInsets.all(SpacingDimens.spacing16),
          ),
          onPressed: () => createDiskusi(context),
          child: const SizedBox(
            width: double.infinity,
            child: Center(child: Text("Chat Diskusi")),
          ),
        ),
      ],
      contentPadding: const EdgeInsets.all(SpacingDimens.spacing16),
      title: Container(
        padding: const EdgeInsets.all(SpacingDimens.spacing12),
        decoration: BoxDecoration(
            color: PaletteColor.primarybg,
            borderRadius: BorderRadius.circular(10.0),
            boxShadow: [
              BoxShadow(
                color: PaletteColor.grey80.withOpacity(0.05),
                offset: const Offset(0, 1),
                spreadRadius: 2,
              )
            ]),
        child: const Center(child: Text("Buat")),
      ),
    );
  }
}
