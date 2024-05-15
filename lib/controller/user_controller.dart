import 'package:gwt/services/user_service.dart';
import 'package:gwt/utils/base_controller.dart';

import '../models/user.dart';

class UserController extends BaseController {
  Future<User?> register({
    required String email,
    required String password,
    required String name,
  }) async {
    return callService<User?>(
      UserService.shared.register(
        email: email,
        password: password,
        name: name,
      ),
    );
  }
}
