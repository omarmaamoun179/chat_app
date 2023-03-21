import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());
  Future<void> registerUser(
      {required String email, required String password}) async {
    emit(RegisterLoading());
    try {
      UserCredential user = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      print(user.user!.displayName);
      emit(RegisterSuccess());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        emit(RegisterFailed(errorMessage: 'weak-password'));
      } else if (e.code == 'email-already-in-use')
        emit(RegisterFailed(
            errorMessage: 'The account already exists for that email.'));
    } catch (e) {
      emit(RegisterFailed(errorMessage: 'There was an error'));
    }
  }
  Future<void> loginUser(
      {required String email, required String password}) async {
    emit(LoginLoading());
    try {
      UserCredential user = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      print(user.user!.displayName);
      emit(LoginSuccess());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        emit(LoginFailed(errorMessage: 'User Not Found '));
      } else if (e.code == 'wrong-password')
        emit(LoginFailed(errorMessage: 'Wrong Password'));
    } catch (e) {
      emit(LoginFailed(errorMessage: ' There was an error'));
    }
  }
}
