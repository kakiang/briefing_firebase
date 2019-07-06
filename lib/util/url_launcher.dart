import 'package:flutter/material.dart';
import 'package:flutter_custom_tabs/flutter_custom_tabs.dart';

class UrlLauncher {
  static Future<void> launchURL(BuildContext context, String link) async {
    try {
      await launch(
        link,
        option: new CustomTabsOption(
          toolbarColor: Theme.of(context).primaryColor,
          enableDefaultShare: true,
          enableUrlBarHiding: true,
          showPageTitle: true,
          enableInstantApps: true,
          animation: CustomTabsAnimation.slideIn(),
          extraCustomTabs: <String>[
            'org.mozilla.firefox',
          ],
        ),
      );
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
