import 'package:flutter/material.dart';
import 'package:major_project/colors/colors.dart';
import 'package:major_project/theme/style_card_title.dart';

class ProfileSettingWidget extends StatelessWidget {
  String text;
  IconData icon;

  ProfileSettingWidget({Key? key, required this.text, required this.icon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: color_eventcard
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(icon, color: Colors.white,),
              SizedBox(width: 8),
              Text(
                text,
                style: CustomTextStyles.style_setting_data,
              ),
            ],
          ),

          Icon(Icons.navigate_next_rounded, color: Colors.white,)


        ],
      ),
    );
  }
}
