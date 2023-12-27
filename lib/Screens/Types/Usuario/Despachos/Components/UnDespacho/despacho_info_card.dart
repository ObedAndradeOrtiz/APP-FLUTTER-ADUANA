import 'package:app_universal/global/constants.dart';
import 'package:flutter/material.dart';

class DespachoInfoCard extends StatelessWidget {
  const DespachoInfoCard({
    Key? key,
    required this.title,
    required this.svgSrc,
    required this.amountOfFiles,
    required this.numOfFiles,
  }) : super(key: key);

  final String title, svgSrc, amountOfFiles;
  final String numOfFiles;
  final double size = 10;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Padding(
            padding: EdgeInsets.only(left: defaultPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontSize: 15, color: primaryColor),
                ),
                Text(numOfFiles,
                    style: const TextStyle(fontSize: 15, color: primaryColor)),
              ],
            ),
          ),
        ),
        Text(amountOfFiles,
            style: const TextStyle(fontSize: 15, color: Colors.greenAccent))
      ],
    );
  }
}
