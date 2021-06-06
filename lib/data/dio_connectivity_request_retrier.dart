import 'dart:async';

import 'package:connectivity/connectivity.dart';
import 'package:dio/dio.dart';

class DioConnectivityRequestRetrier{
  final Dio dio;
  final Connectivity connectivity;

  DioConnectivityRequestRetrier({this.dio, this.connectivity});
  Future<Response> scheduleRequestRetry(RequestOptions options) async{
    final responseCompleter = Completer<Response>();
    StreamSubscription streamSubscription;
    streamSubscription = connectivity.onConnectivityChanged.listen((
        connectivityResult) {
      if (connectivityResult != ConnectivityResult.none) {
        streamSubscription.cancel();
        responseCompleter.complete(
            dio.request(
                options.path,
                cancelToken: options.cancelToken,
                data: options.data,
                onReceiveProgress: options.onReceiveProgress,
                onSendProgress: options.onSendProgress,
                queryParameters: options.queryParameters,
                options: options
            )
        );
      }
    });
   return responseCompleter.future;
  }
}