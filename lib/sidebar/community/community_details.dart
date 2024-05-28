import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_custom_tabs/flutter_custom_tabs.dart';
import 'package:major_project/colors/colors.dart';
import 'package:major_project/theme/style_card_title.dart';

class CommunityDetails extends StatelessWidget {
  String title;
  String desc;
  String type;
  String size;
  String status;
  String link;
  CommunityDetails({super.key, required this.title, required this.desc, required this.type,

    required this.size,required this.status,required this.link,
  });


  Future<void> _launchURLInDefaultBrowserOnAndroid(BuildContext context, String url) async {
    try {
      await launchUrl(
        Uri.parse(url),
        customTabsOptions: CustomTabsOptions(
          colorSchemes: CustomTabsColorSchemes.defaults(
            toolbarColor: backgroundAppbar,
            navigationBarColor: backgroundAppbar,
          ),
          urlBarHidingEnabled: true,
          showTitle: true,
          browser: const CustomTabsBrowserConfiguration(
            prefersDefaultBrowser: true,

          ),
        ),
      );
    } catch (e) {
      debugPrint(e.toString());
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundScaffold,
      appBar: AppBar(
        backgroundColor: backgroundAppbar,
        title: Text(title, style: CustomTextStyles.style_appbar,),
        iconTheme: IconThemeData(color: Colors.white),
      ),

      body: Column(
        children: [

          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
              
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('About us', style: CustomTextStyles.style_card_title,),
                        Text(desc, style: CustomTextStyles.style_card_desc,),
              
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
                          child: Divider(thickness: 0.1,),
                        ),
              
                        Text('Organisation size', style: CustomTextStyles.style_card_title,),
                        Text(size, style: CustomTextStyles.style_card_desc,),
              
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
                          child: Divider(thickness: 0.1,),
                        ),
              
                        Text('Organization type', style: CustomTextStyles.style_card_title,),
                        Text(type, style: CustomTextStyles.style_card_desc,),
              
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
                          child: Divider(thickness: 0.1,),
                        ),
              
                        Text('Registration status', style: CustomTextStyles.style_card_title,),
                        Text(status, style: TextStyle(
                          color: status == 'Open'? Colors.green : Colors.red ,  fontFamily: 'Namun',
                        ),),
              
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
            child: Container(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                ),
                onPressed: (){

                  _launchURLInDefaultBrowserOnAndroid(context, link);
                },
                child: Text(
                  "Register for ${title.toString()}",
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
