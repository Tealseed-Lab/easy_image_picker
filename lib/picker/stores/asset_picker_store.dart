import 'package:easy_image_picker/picker/config/config.dart';
import 'package:easy_image_picker/picker/models/asset_image.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:photo_manager/photo_manager.dart';

part 'asset_picker_store.g.dart';

enum LoadingStatus {
  loading,
  initial,
  complete,
  loadingMore,
  noMore,
  noContent,
  error,
}

enum AppPermissionState {
  authorized,
  denied,
  notDetermined,
}

class AssetPickerStore = AssetPickerStoreBase with _$AssetPickerStore;

abstract class AssetPickerStoreBase with Store {
  AssetPickerStoreBase() {
    scrollController.addListener(_onScroll);
  }

  // prooperties
  final ScrollController scrollController = ScrollController();
  final limit = 100;

  // state
  @readonly
  var _offset = 0;

  @readonly
  ObservableList<String> _selectedAssetIds = ObservableList.of([]);

  @readonly
  ObservableList<AssetEntity> _loadedAssets = ObservableList.of([]);

  @readonly
  LoadingStatus _loadingStatus = LoadingStatus.initial;

  @readonly
  ObservableList<AssetImageInfo>? _initialSelectedAssets;

  @readonly
  int _maxSelection = 9;

  @readonly
  AppPermissionState _permissionState = AppPermissionState.notDetermined;

  Future<void> config({
    required AssetPickerConfig config,
  }) async {
    _initialSelectedAssets = ObservableList.of(config.initialSelectedAssets ?? []);
    _maxSelection = config.maxSelection;
    _selectedAssetIds = ObservableList.of(
      config.initialSelectedAssets?.map((e) => e.id).whereType<String>().toList() ?? [],
    );
    refreshAssets();
  }

  @action
  Future<void> refreshAssets() async {
    if (_loadingStatus == LoadingStatus.loading || _loadingStatus == LoadingStatus.loadingMore) return;
    _loadingStatus = LoadingStatus.loading;
    final result = await PhotoManager.requestPermissionExtend();
    if (result == PermissionState.authorized) {
      _permissionState = AppPermissionState.authorized;
      final assets = await PhotoManager.getAssetListRange(
        type: RequestType.image,
        start: _offset,
        end: _offset + limit,
      );
      _loadedAssets = ObservableList.of(assets);
      if (assets.isEmpty) {
        _loadingStatus = LoadingStatus.noContent;
      } else if (assets.length < limit) {
        _loadingStatus = LoadingStatus.noMore;
      } else {
        _loadingStatus = LoadingStatus.complete;
      }
    } else {
      _permissionState = AppPermissionState.denied;
    }
  }

  @action
  Future<void> loadMoreAssets() async {
    if (_loadingStatus == LoadingStatus.loading ||
        _loadingStatus == LoadingStatus.noMore ||
        _loadingStatus == LoadingStatus.loadingMore ||
        _loadingStatus == LoadingStatus.noContent) {
      return;
    }
    _loadingStatus = LoadingStatus.loadingMore;
    _offset += limit;
    final assets = await PhotoManager.getAssetListRange(
      type: RequestType.image,
      start: _offset,
      end: _offset + limit,
    );
    _loadedAssets.addAll(assets);
    if (assets.length < limit) {
      _loadingStatus = LoadingStatus.noMore;
    } else {
      _loadingStatus = LoadingStatus.complete;
    }
  }

  @action
  Future<void> selectAsset(AssetEntity asset) async {
    if (_selectedAssetIds.contains(asset.id)) {
      _selectedAssetIds.remove(asset.id);
    } else {
      if (_selectedAssetIds.length >= _maxSelection) {
        return;
      }
      _selectedAssetIds.add(asset.id);
    }
  }

  @action
  Future<void> openAppSettings() async {
    await PhotoManager.openSetting();
  }

  @action
  void dispose() {}

  // private
  Future<void> _onScroll() async {
    if (scrollController.position.pixels >= scrollController.position.maxScrollExtent - 100) {
      await loadMoreAssets();
    }
  }
}
