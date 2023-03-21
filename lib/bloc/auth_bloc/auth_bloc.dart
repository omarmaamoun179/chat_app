import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<AuthEvent>((event, emit)  async{
      if(event is LoginEvent) {
         emit(LoginLoading());
    try {
      UserCredential user = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email:event.email, password: event.password);
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
    });
  }
}
