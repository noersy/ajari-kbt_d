import 'package:ajari/component/appbar/silver_appbar_back.dart';
import 'package:ajari/component/dialog/dialog_delete.dart';
import 'package:ajari/providers/kelas_providers.dart';
import 'package:ajari/theme/palette_color.dart';
import 'package:ajari/theme/spacing_dimens.dart';
import 'package:ajari/theme/typography_style.dart';
import 'package:ajari/view/DashboardPage/KelasPage/MeetingPage/component/dialogcreate_meet.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';


class MeetingPage extends StatefulWidget {
  const MeetingPage({Key? key}) : super(key: key);

  @override
  State<MeetingPage> createState() => _MeetingPageState();
}

class _MeetingPageState extends State<MeetingPage> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: PaletteColor.primarybg,
      body: SilverAppBarBack(
        barTitle: 'List Pertemuan',
        floating: true,
        pinned: true,
        body: StreamBuilder<QuerySnapshot>(
          stream: Provider.of<KelasProvider>(context).getsMeetings(),
          builder: (context, snapshot) {

            if(!snapshot.hasData){
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(
                      Icons.create_new_folder_outlined,
                      size:80,
                      color: PaletteColor.grey40,
                    ),
                    Text("Belum ada data disini.", style: TextStyle(
                        color: PaletteColor.grey60
                    ),)
                  ],
                ),
              );
            }

            if(snapshot.data!.size <= 0  ){
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(
                      Icons.create_new_folder_outlined,
                      size:80,
                      color: PaletteColor.grey40,
                    ),
                    Text("Belum ada data disini.", style: TextStyle(
                        color: PaletteColor.grey60
                    ),)
                  ],
                ),
              );
            }

            return SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: snapshot.data!.docs.map((e) {
                  var data = e.data() as Map<String, dynamic>;
                  var datetime = (data["datetime"] as Timestamp).toDate();
                  String subject = data["subject"];
                  return MeetCardList(datetime : datetime, subject : subject);
                }).toList(),
              ),
            );
          }
        ),
      ),
      floatingActionButton: FloatingActionButton(
        splashColor: PaletteColor.green,
        backgroundColor: PaletteColor.primary,
        child: const Icon(Icons.add),
        onPressed: () async {
          var result = await showDialog(
            context: context,
            builder: (context) =>  const DialogCreateMeet(),
          );

          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(result)));
        },
      ),
    );
  }
}

class MeetCardList extends StatelessWidget {
  final DateTime datetime;
  final String subject;

  const MeetCardList({
    Key? key,
    required this.datetime,
    required this.subject,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _text = DateFormat("yyyy-MM-dd").format(datetime);

    return Padding(
      padding: const EdgeInsets.only(
        top: SpacingDimens.spacing8,
        left: SpacingDimens.spacing16,
        right: SpacingDimens.spacing16,
      ),
      child: ElevatedButton(
        onLongPress: ()  => showDialog(
          context: context,
          builder: (context) => DialogDelete(
            content: "This will delete the selected item.",
            onPressedFunction: () {
              Provider.of<KelasProvider>(context, listen: false).deleteMeet(date: datetime);
              Navigator.of(context).pop();
            },
          ),
        ),
        onPressed: () {},
        child: Container(
          width: double.infinity,
          height: SpacingDimens.spacing44,
          alignment: Alignment.centerLeft,
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Row(
                  children: [
                    const Icon(
                      Icons.date_range,
                      color: PaletteColor.text,
                      size: 18,
                    ),
                    const SizedBox(width: SpacingDimens.spacing4),
                    Text(_text, style: TypographyStyle.button2)
                  ],
                ),
                Row(
                  children: [
                    const Icon(
                      Icons.meeting_room_sharp,
                      color: PaletteColor.text,
                      size: 18,
                    ),
                    const SizedBox(width: SpacingDimens.spacing4),
                    Text(subject, style: TypographyStyle.button2)
                  ],
                ),
              ],
            ),
          ),
        ),
        style: ElevatedButton.styleFrom(
          elevation: 1,
          onPrimary: PaletteColor.primary,
          primary: PaletteColor.primarybg2,
          shape: RoundedRectangleBorder(
              side: BorderSide(
                color: PaletteColor.grey80.withOpacity(0.08),
              ),
              borderRadius: BorderRadius.circular(4.0),
          ),
        ),
      ),
    );
  }


}

