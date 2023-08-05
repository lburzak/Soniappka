import 'package:flutter/material.dart';

class IconPicker extends StatelessWidget {
  final List<IconData> icons;
  final IconData? selectedIcon;
  final void Function(IconData iconData) onSelected;

  const IconPicker(
      {super.key,
      required this.icons,
      required this.onSelected,
      this.selectedIcon});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      children: icons
          .map((icon) => _ClickableIcon(
                iconData: icon,
                onTap: () {
                  onSelected(icon);
                },
                selected: icon == selectedIcon,
              ))
          .toList(),
    );
  }
}

class _ClickableIcon extends StatelessWidget {
  final IconData iconData;
  final bool selected;
  final VoidCallback onTap;

  const _ClickableIcon(
      {required this.iconData, required this.onTap, this.selected = false});

  @override
  Widget build(BuildContext context) {
    return Material(
      shape: const CircleBorder(),
      child: InkWell(
        onTap: onTap,
        customBorder: const CircleBorder(),
        child: Ink(
          child: Icon(
            iconData,
            size: 48,
            color: selected ? Colors.blue : Colors.black,
          ),
        ),
      ),
    );
  }
}
