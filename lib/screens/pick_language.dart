// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import '../../main.dart';
import '../../main/utils/allConstants.dart';
import '../../Components/widgets/app_bar_buttons.dart';

class Language extends StatefulWidget {
  // ignore: use_key_in_widget_constructors
  const Language({Key? key});

  @override
  State<Language> createState() => _Language();
}

class _Language extends State<Language> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColors.backgroundLight,
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(80),
        child: CustomAppBar(
          titleText: 'Language',
          isActionVisible: false,
          isLeadingVisible: true,
        ),
      ),
      body: ListView(
        children: List.generate(localeLanguageList.length, (index) {
          LanguageDataModel data = localeLanguageList[index];
          return Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                // Image.asset(data.flag.validate(), width: 34),
                // 16.width,
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(data.name.validate(), style: boldTextStyle()),
                    8.height,
                    Text(data.subTitle.validate(), style: secondaryTextStyle()),
                  ],
                ).expand(),
                if (getStringAsync(SELECTED_LANGUAGE_CODE,
                        defaultValue: defaultLanguage) ==
                    data.languageCode)
                  Icon(Icons.check_circle, color: colorPrimary),
              ],
            ),
          ).onTap(
            () async {
              await setValue(SELECTED_LANGUAGE_CODE, data.languageCode);
              selectedLanguageDataModel = data;
              appStore.setLanguage(data.languageCode!, context: context);
              setState(() {});
              LiveStream().emit('UpdateLanguage');
              finish(context);
            },
          );
        }),
      ),
    );
  }
}
