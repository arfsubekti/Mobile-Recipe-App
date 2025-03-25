import 'package:shared_preferences/shared_preferences.dart';

class SessionService {
  Future setUser(int id, String nama, String email) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('id', id);
    await prefs.setString('nama', nama);
    await prefs.setString('email', email);

    print("Sukses SAVE DATA");
  }

  Future<Map> getUser() async {
    final prefs = await SharedPreferences.getInstance();
    final id = prefs.getInt('id');
    final nama = prefs.getString('nama');
    final email = prefs.getString('email');

    return {'id':id,'nama':nama,'email':email};
  }

  // tambahi  fungsi untuk menyimpan token dan mengambil token
    Future setToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', token);
  }
    Future<String> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token')??'';
  }
}