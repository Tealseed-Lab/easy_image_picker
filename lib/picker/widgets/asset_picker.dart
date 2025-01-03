import 'dart:ui';

import 'package:easy_image_picker/picker/config/config.dart';
import 'package:easy_image_picker/picker/models/asset_image.dart';
import 'package:easy_image_picker/picker/stores/asset_picker_store.dart';
import 'package:easy_image_picker/picker/widgets/asset_entity_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:photo_manager/photo_manager.dart';

Future<List<AssetImageInfo>?> showAssetPicker(
  BuildContext context, {
  Key? key,
  AssetPickerConfig? config,
}) async {
  if (config != null) {
    AssetPickerConfig.setInstance(config);
  }
  return await showCupertinoModalBottomSheet(
    context: context,
    duration: AssetPickerConfig.instance.transitionDuration,
    builder: (context) => AssetPicker(
      key: key,
      config: AssetPickerConfig.instance,
    ),
  );
}

class AssetPicker extends StatelessWidget {
  final AssetPickerConfig config;
  AssetPicker({
    super.key,
    required this.config,
  }) {
    _store.config(config: config);
  }

  final _store = AssetPickerStore();

  @override
  Widget build(BuildContext context) {
    return ProgressHUD(
      child: Builder(builder: (context) {
        return Scaffold(
          backgroundColor: config.backgroundColor,
          appBar: _buildAppBar(context),
          body: _buildBody(context),
        );
      }),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      toolbarHeight: 60,
      backgroundColor: config.backgroundColor,
      leading: IconButton(
        onPressed: () {
          Navigator.of(context).pop(null);
        },
        icon: const Icon(Icons.close),
      ),
      actions: [
        IconButton(
          onPressed: () async {
            ProgressHUD.of(context)?.show();
            try {
              final theAssets = _store.loadedAssets.where((asset) => _store.selectedAssetIds.contains(asset.id));
              List<AssetImageInfo> results = [];
              for (final asset in theAssets) {
                final file = await asset.file;
                if (file == null) {
                  continue;
                }
                final info = await compressAndCorrectImage(
                  id: asset.id,
                  sourcePath: file.path,
                );
                if (info == null) {
                  continue;
                }
                results.add(info);
              }
              // ignore: use_build_context_synchronously
              Navigator.of(context).pop(results);
            } finally {
              // ignore: use_build_context_synchronously
              ProgressHUD.of(context)?.dismiss();
            }
          },
          icon: const Icon(Icons.done),
        )
      ],
    );
  }

  Widget _buildBody(BuildContext context) {
    return Observer(
      builder: (context) {
        if (_store.loadingStatus == LoadingStatus.loading) {
          return Center(
            child: SizedBox(
              width: 24,
              height: 24,
              child: CircularProgressIndicator(
                color: config.loadingIndicatorColor,
              ),
            ),
          );
        }
        const spacing = 2.0;
        const column = 3;
        final devicePixelRatio = PlatformDispatcher.instance.views.first.devicePixelRatio;
        final itemSize = (MediaQuery.of(context).size.width - (column - 1) * spacing) / column * devicePixelRatio;
        return GridView.builder(
          controller: _store.scrollController,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: column,
            mainAxisSpacing: spacing,
            crossAxisSpacing: spacing,
          ),
          itemCount: _store.loadedAssets.length,
          itemBuilder: (context, index) {
            final asset = _store.loadedAssets[index];
            return FutureBuilder(
              future: asset.thumbnailDataWithSize(ThumbnailSize.square(itemSize.toInt())),
              builder: (context, snapshot) {
                return Container(
                  clipBehavior: Clip.hardEdge,
                  decoration: BoxDecoration(
                    color: config.imagePlaceholderColor,
                  ),
                  child: Stack(
                    children: [
                      if (snapshot.hasData)
                        Positioned.fill(
                          child: Image.memory(
                            snapshot.data!,
                            fit: BoxFit.cover,
                          ),
                        ),
                      Positioned.fill(
                        child: Container(
                          color: Colors.black.withAlpha(51),
                        ),
                      ),
                      Observer(builder: (context) {
                        final asset = _store.loadedAssets[index];
                        final isSelected = _store.selectedAssetIds.contains(asset.id);
                        return AssetEntityItem(
                          asset: asset,
                          isSelected: isSelected,
                          selectedIndex: isSelected ? _store.selectedAssetIds.indexOf(asset.id) : null,
                          onTap: () => _store.selectAsset(asset),
                        );
                      })
                    ],
                  ),
                );
              },
            );
          },
        );
      },
    );
  }

  @override
  Future<AssetImageInfo?> compressAndCorrectImage({
    String? id,
    required String sourcePath,
  }) async {
    final dir = await getTemporaryDirectory();
    final targetPath = join(dir.absolute.path, "${DateTime.now().millisecondsSinceEpoch}.jpg");
    final result = await FlutterImageCompress.compressAndGetFile(
      sourcePath,
      targetPath,
      format: CompressFormat.jpeg,
    );
    if (result == null) {
      return null;
    } else {
      return AssetImageInfo(
        id: id,
        path: result.path,
        mimeType: result.mimeType,
        name: result.name,
      );
    }
  }
}
