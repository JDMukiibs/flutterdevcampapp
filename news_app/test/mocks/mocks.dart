import 'package:mocktail/mocktail.dart';
import 'package:news_app/authentication/authentication.dart';
import 'package:news_app/storage/storage.dart';

class MockAuthService extends Mock implements AuthService {}

class MockUserInfoStorage extends Mock implements UserInfoStorage {}