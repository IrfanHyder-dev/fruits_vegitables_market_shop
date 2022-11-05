import 'package:flutter/material.dart';

import '../resources/ccolor_manager.dart';

class AppBarCustom {
  final bool showNotification;
  final int notificationCount;
  final VoidCallback? onNotify;
  final VoidCallback? onBack;
  final String title;

  AppBarCustom({
    required this.showNotification,
    required this.title,
    required this.notificationCount,
    required this.onBack,
    required this.onNotify,
  });

  appBar() => AppBar(
        title: Text(title),
        actions: [
          if(showNotification)
          InkWell(
            onTap: onNotify,
            child: _NamedIcon(notificationCount: notificationCount),
          ),
        ],
        leading: InkWell(
          onTap: onBack,
          child: const Icon(
            Icons.arrow_back_ios,
            color: ColorManager.white,
          ),
        ),
      );
}

class _NamedIcon extends StatelessWidget {
  final notificationCount;

  const _NamedIcon({
    this.notificationCount = 0,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 65,
      padding: EdgeInsets.symmetric(horizontal: 8),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Icon(Icons.notifications),
          if (notificationCount != 0)
            Positioned(
              top: 7,
              right: 5,
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 6,
                  vertical: 2,
                ),
                decoration: BoxDecoration(
                  color: Colors.red,
                  shape: BoxShape.circle,
                ),
                alignment: Alignment.center,
                child: Text('$notificationCount'),
              ),
            ),
        ],
      ),
    );
  }
}
