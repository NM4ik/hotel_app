import 'package:internet_connection_checker/internet_connection_checker.dart';

// abstract class NetworkInfo {
//   Future<bool> get isConnected;
// }
//
// class NetworkInfoImpl implements NetworkInfo {
//   final InternetConnectionChecker connectionChecker;
//
//   NetworkInfoImpl(this.connectionChecker);
//
//   @override
//   // TODO: implement isConnected
//   Future<bool> get isConnected => connectionChecker.hasConnection;
// }

class NetworkInfo{
  final InternetConnectionChecker connectionChecker;
  NetworkInfo(this.connectionChecker);

  Future<bool> getIsConnected() =>  connectionChecker.hasConnection;

}
