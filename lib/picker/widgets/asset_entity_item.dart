import 'package:easy_image_picker/picker/config/config.dart';
import 'package:flutter/material.dart';
import 'package:photo_manager/photo_manager.dart';

class AssetEntityItem extends StatelessWidget {
  final AssetEntity asset;
  final bool isSelected;
  final int? selectedIndex;
  final VoidCallback onTap;
  const AssetEntityItem({
    super.key,
    required this.asset,
    required this.isSelected,
    this.selectedIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        color: Colors.transparent,
        child: Stack(
          children: [
            Positioned(
              top: 6,
              right: 6,
              child: Container(
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                  color: isSelected ? AssetPickerConfig.instance.selectIndicatorColor : Colors.transparent,
                  shape: BoxShape.circle,
                ),
                foregroundDecoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: AssetPickerConfig.instance.selectCountColor,
                    width: 1,
                  ),
                ),
                alignment: Alignment.center,
                child: isSelected
                    ? Text(
                        ((selectedIndex ?? 0) + 1).toString(),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: AssetPickerConfig.instance.selectCountColor,
                          fontWeight: FontWeight.w400,
                          fontSize: 16,
                          height: 1.313,
                          letterSpacing: -0.4,
                        ),
                      )
                    : null,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
