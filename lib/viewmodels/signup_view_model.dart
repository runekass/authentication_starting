import 'package:compound/constants/route_names.dart';
import 'package:compound/locator.dart';
import 'package:compound/services/authentication_service.dart';
import 'package:compound/services/dialog_service.dart';
import 'package:compound/services/navigation_service.dart';
import 'package:flutter/foundation.dart';
import 'base_model.dart';
class SignUpViewModel extends BaseModel {

  final AuthenticationService _authenticationService = locator<AuthenticationService>();
  final DialogService _dialogService = locator<DialogService>();
  final NavigationService _navigationService = locator<NavigationService>();

  Future signUp({
  @required String email,
  @required String password,
  @required String fullName,
  }) async {
    setBusy(true);

    var result = await _authenticationService.signUpWithEmail(
        email: email,
        password: password,
        fullName: fullName,
    );

    setBusy(false);

    if(result is bool) {
      if(result) {
        _navigationService.navigateTo(HomeViewRoute);
      } else {
        await _dialogService.showDialog(
          title: 'Registreringfeil',
          description: 'Generell registreringsfeil. Venligst prøv igjen senere',
        );
      }
    } else {
      await _dialogService.showDialog(
        title: 'Registreringsfeil',
        description: result,
      );
    }
  }
}