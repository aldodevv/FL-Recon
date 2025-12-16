// lib/core/services/directory_service.dart
import 'dart:io';
import 'package:path_provider/path_provider.dart';

class DirectoryService {
  const DirectoryService();

  /// TEMPORARY
  /// Android ✅ | iOS ✅
  Future<Directory> getTempDir() async {
    return getTemporaryDirectory();
  }

  /// APPLICATION DOCUMENTS
  /// Android ✅ | iOS ✅
  Future<Directory> getAppDocumentsDir() async {
    return getApplicationDocumentsDirectory();
  }

  /// APPLICATION SUPPORT
  /// Android ✅ | iOS ✅
  Future<Directory> getAppSupportDir() async {
    return getApplicationSupportDirectory();
  }

  /// APPLICATION LIBRARY
  /// ❌ Android | ✅ iOS
  Future<Directory?> getAppLibraryDir() async {
    if (!Platform.isIOS) return null;
    return getLibraryDirectory();
  }

  /// APPLICATION CACHE
  /// Android ✅ | iOS ✅
  Future<Directory> getAppCacheDir() async {
    return getApplicationCacheDirectory();
  }

  /// DOWNLOADS
  /// Android ✅ | iOS ✅
  Future<Directory?> getDownloadsDir() async {
    return getDownloadsDirectory();
  }

  /// EXTERNAL STORAGE (Android ✅)
  Future<Directory?> getExternalStorageDir() async {
    if (!Platform.isAndroid) return null;
    return getExternalStorageDirectory();
  }

  /// EXTERNAL CACHE (Android ✅)
  Future<List<Directory>?> getExternalCacheDirs() async {
    if (!Platform.isAndroid) return null;
    return getExternalCacheDirectories();
  }

  /// EXTERNAL STORAGE DIRS (Android ✅)
  Future<List<Directory>?> getExternalStorageDirs({
    StorageDirectory type = StorageDirectory.documents,
  }) async {
    if (!Platform.isAndroid) return null;
    return getExternalStorageDirectories(type: type);
  }
}
