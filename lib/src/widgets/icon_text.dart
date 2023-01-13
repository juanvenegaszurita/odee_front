import 'package:flutter/material.dart';
import 'package:odee_front/src/utils/utils.dart';

class IconText extends StatelessWidget {
  const IconText({
    super.key,
    this.textBeforeIcon = "",
    this.textAfterIcon = "",
    this.icon = Icons.arrow_right,
    this.finalIcon,
  });

  final String textBeforeIcon;
  final String textAfterIcon;
  final IconData icon;
  final IconData? finalIcon;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: PageUtils.width(context),
      child: Wrap(
        crossAxisAlignment: WrapCrossAlignment.center,
        alignment: WrapAlignment.spaceBetween,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (textBeforeIcon.isNotEmpty) Text(textBeforeIcon),
              Padding(
                padding: const EdgeInsets.only(right: 5),
                child: Icon(icon),
              ),
              if (textAfterIcon.isNotEmpty) Text(textAfterIcon, ),
            ],
          ),
          if (finalIcon != null) Icon(finalIcon),
        ],
      ),
    );
  }
}
