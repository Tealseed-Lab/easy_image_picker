// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'asset_picker_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$AssetPickerStore on AssetPickerStoreBase, Store {
  late final _$_offsetAtom =
      Atom(name: 'AssetPickerStoreBase._offset', context: context);

  int get offset {
    _$_offsetAtom.reportRead();
    return super._offset;
  }

  @override
  int get _offset => offset;

  @override
  set _offset(int value) {
    _$_offsetAtom.reportWrite(value, super._offset, () {
      super._offset = value;
    });
  }

  late final _$_selectedAssetIdsAtom =
      Atom(name: 'AssetPickerStoreBase._selectedAssetIds', context: context);

  ObservableList<String> get selectedAssetIds {
    _$_selectedAssetIdsAtom.reportRead();
    return super._selectedAssetIds;
  }

  @override
  ObservableList<String> get _selectedAssetIds => selectedAssetIds;

  @override
  set _selectedAssetIds(ObservableList<String> value) {
    _$_selectedAssetIdsAtom.reportWrite(value, super._selectedAssetIds, () {
      super._selectedAssetIds = value;
    });
  }

  late final _$_loadedAssetsAtom =
      Atom(name: 'AssetPickerStoreBase._loadedAssets', context: context);

  ObservableList<AssetEntity> get loadedAssets {
    _$_loadedAssetsAtom.reportRead();
    return super._loadedAssets;
  }

  @override
  ObservableList<AssetEntity> get _loadedAssets => loadedAssets;

  @override
  set _loadedAssets(ObservableList<AssetEntity> value) {
    _$_loadedAssetsAtom.reportWrite(value, super._loadedAssets, () {
      super._loadedAssets = value;
    });
  }

  late final _$_loadingStatusAtom =
      Atom(name: 'AssetPickerStoreBase._loadingStatus', context: context);

  LoadingStatus get loadingStatus {
    _$_loadingStatusAtom.reportRead();
    return super._loadingStatus;
  }

  @override
  LoadingStatus get _loadingStatus => loadingStatus;

  @override
  set _loadingStatus(LoadingStatus value) {
    _$_loadingStatusAtom.reportWrite(value, super._loadingStatus, () {
      super._loadingStatus = value;
    });
  }

  late final _$_initialSelectedAssetsAtom = Atom(
      name: 'AssetPickerStoreBase._initialSelectedAssets', context: context);

  ObservableList<AssetImageInfo>? get initialSelectedAssets {
    _$_initialSelectedAssetsAtom.reportRead();
    return super._initialSelectedAssets;
  }

  @override
  ObservableList<AssetImageInfo>? get _initialSelectedAssets =>
      initialSelectedAssets;

  @override
  set _initialSelectedAssets(ObservableList<AssetImageInfo>? value) {
    _$_initialSelectedAssetsAtom
        .reportWrite(value, super._initialSelectedAssets, () {
      super._initialSelectedAssets = value;
    });
  }

  late final _$_maxSelectionAtom =
      Atom(name: 'AssetPickerStoreBase._maxSelection', context: context);

  int get maxSelection {
    _$_maxSelectionAtom.reportRead();
    return super._maxSelection;
  }

  @override
  int get _maxSelection => maxSelection;

  @override
  set _maxSelection(int value) {
    _$_maxSelectionAtom.reportWrite(value, super._maxSelection, () {
      super._maxSelection = value;
    });
  }

  late final _$_permissionStateAtom =
      Atom(name: 'AssetPickerStoreBase._permissionState', context: context);

  AppPermissionState get permissionState {
    _$_permissionStateAtom.reportRead();
    return super._permissionState;
  }

  @override
  AppPermissionState get _permissionState => permissionState;

  @override
  set _permissionState(AppPermissionState value) {
    _$_permissionStateAtom.reportWrite(value, super._permissionState, () {
      super._permissionState = value;
    });
  }

  late final _$refreshAssetsAsyncAction =
      AsyncAction('AssetPickerStoreBase.refreshAssets', context: context);

  @override
  Future<void> refreshAssets() {
    return _$refreshAssetsAsyncAction.run(() => super.refreshAssets());
  }

  late final _$loadMoreAssetsAsyncAction =
      AsyncAction('AssetPickerStoreBase.loadMoreAssets', context: context);

  @override
  Future<void> loadMoreAssets() {
    return _$loadMoreAssetsAsyncAction.run(() => super.loadMoreAssets());
  }

  late final _$selectAssetAsyncAction =
      AsyncAction('AssetPickerStoreBase.selectAsset', context: context);

  @override
  Future<void> selectAsset(AssetEntity asset) {
    return _$selectAssetAsyncAction.run(() => super.selectAsset(asset));
  }

  late final _$openAppSettingsAsyncAction =
      AsyncAction('AssetPickerStoreBase.openAppSettings', context: context);

  @override
  Future<void> openAppSettings() {
    return _$openAppSettingsAsyncAction.run(() => super.openAppSettings());
  }

  late final _$AssetPickerStoreBaseActionController =
      ActionController(name: 'AssetPickerStoreBase', context: context);

  @override
  void dispose() {
    final _$actionInfo = _$AssetPickerStoreBaseActionController.startAction(
        name: 'AssetPickerStoreBase.dispose');
    try {
      return super.dispose();
    } finally {
      _$AssetPickerStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''

    ''';
  }
}
