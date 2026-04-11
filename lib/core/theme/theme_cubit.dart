import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeCubit extends Cubit<bool> {
  ThemeCubit() : super(true) {
    _loadTheme();
  }

  void _loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    final isDark = prefs.getBool('isDarkMode') ?? true;
    emit(isDark);
  }

  void toggleTheme() async {
    final newTheme = !state;
    emit(newTheme);
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isDarkMode', newTheme);
  }
}
