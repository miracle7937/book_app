import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../Constance/theme.dart';

final themeController = ChangeNotifierProvider<AppTheme>((ref) {
  return AppTheme();
});
