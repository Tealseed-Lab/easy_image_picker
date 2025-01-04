import 'dart:ui';

import 'package:easy_image_picker/picker/models/asset_image.dart';

class AssetPickerConfig {
  final int maxSelection;
  final List<AssetImageInfo>? initialSelectedAssets;
  final Duration transitionDuration;
  final Color backgroundColor;
  final Color selectIndicatorColor;
  final Color selectCountColor;
  final Color loadingIndicatorColor;
  final Color imagePlaceholderColor;
  final String permissionDeniedText;
  final String permissionDeniedButtonText;
  AssetPickerConfig({
    this.maxSelection = 9,
    this.initialSelectedAssets,
    this.transitionDuration = const Duration(milliseconds: 300),
    this.backgroundColor = const Color(0xFFFFFFFF),
    this.selectIndicatorColor = const Color(0xFF1DC19A),
    this.selectCountColor = const Color(0xFFFFFFFF),
    this.loadingIndicatorColor = const Color(0xFF1DC19A),
    this.imagePlaceholderColor = const Color(0xFFFAFAFA),
    this.permissionDeniedText = 'Please grant permission to access your photo library',
    this.permissionDeniedButtonText = 'Open Settings',
  });

  static AssetPickerConfig get instance => _instance;
  static AssetPickerConfig _instance = AssetPickerConfig();

  static void setInstance(AssetPickerConfig config) => _instance = config;
}
