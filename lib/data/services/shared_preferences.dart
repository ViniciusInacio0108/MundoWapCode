import 'package:mundo_wap_teste/utils/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// SharedPreferencesService is a class for a less complicated local storage.
/// Meant for those String or simple type of data that need to be storaged locally.
///
/// Do not use this class for complex data types. For those, use [DBService]
class SharedPreferencesService {
  Future<ResponseResult<String>> get(String key) async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final data = prefs.get(key) as String?;

      if (data == null) {
        return ResponseResult.error(Exception('Empty data'));
      } else {
        return ResponseResult.ok(data);
      }
    } on Exception catch (e) {
      return ResponseResult.error(e);
    }
  }
}
