import 'package:app_universal/global/theme.dart';
import 'package:app_universal/widget/receiver_bubble.dart';
import 'package:app_universal/widget/sender_bubble.dart';
import 'package:flutter/material.dart';

class ChatPageAgora extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Widget header() {
      return Container(
        padding: EdgeInsets.only(left: 30, right: 30, bottom: 30, top: 40),
        width: double.infinity,
        decoration: BoxDecoration(
          color:  white,
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(48),
          ),
        ),
        child: Row(
          children: [
            Image.asset(
              'assets/images/iconoisotipo.png',
              width: 55,
              height: 55,
              fit: BoxFit.fill,
            ),
            SizedBox(width: 20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Soporte Ágora',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
                Text(
                  '',
                  style: TextStyle(
                    fontWeight: FontWeight.w300,
                    color: Color(0xff808ba2),
                  ),
                )
              ],
            ),
            Spacer(),
            Image.asset(
              'assets/icons/btn-call.png',
              width: 55,
              height: 55,
              fit: BoxFit.fill,
            )
          ],
        ),
      );
    }

    Widget body() {
      return Expanded(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 30),
          child: ListView(
            children: [
              ReceiverBubble(
                imageUrl: 'assets/images/people1.png',
                text: 'How are you guys?',
                time: '2:30',
              ),
              ReceiverBubble(
                imageUrl: 'assets/images/people2.png',
                text: 'Find here..',
                time: '3:11',
              ),
              SenderBubble(
                  imgUrl: 'assets/images/people3.png',
                  text: 'Thinking about how to deal with this client from hell',
                  time: '22:08'),
              ReceiverBubble(
                imageUrl: 'assets/images/people2.png',
                text: 'Find here..',
                time: '23:11',
              )
            ],
          ),
        ),
      );
    }

    Widget chatField() {
      return Container(
        margin: EdgeInsets.symmetric(horizontal: 30),
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        width: double.infinity,
        decoration: BoxDecoration(
          color: white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          children: [
            Expanded(
              child: TextField(
                decoration: InputDecoration.collapsed(
                  hintText: 'Mensaje...',
                  hintStyle: TextStyle(fontSize: 14),
                ),
              ),
            ),
            InkWell(
              onTap: () {
                showDialog(
                    context: context,
                    builder: (_) => AlertDialog(
                          title: Text(
                            'Gracias por contactar!',
                            style: subtitleTextStyle,
                            textAlign: TextAlign.center,
                          ),
                          elevation: 10.0,
                          backgroundColor: white,
                        ),
                    barrierDismissible: true);
              },
              child: Image.asset(
                'assets/icons/btn-send.png',
                width: 35,
              ),
            )
          ],
        ),
      );
    }

    return Scaffold(
      backgroundColor: Color(0xfff8fafc),
      floatingActionButton: chatField(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: SafeArea(
        top: false,
        child: Column(
          children: [
            header(),
            body(),
          ],
        ),
      ),
    );
  }
}
