import 'package:dio/dio.dart';
import 'package:get_storage/get_storage.dart';
import 'package:navid_app/data/datasources/remote/client.dart';

import '../model/identity_model.dart';

class RefreshTokenInterceptor extends Interceptor{
  GetStorage box = GetStorage();
  @override
  Future onError(DioError error) async{
    if(error.response?.statusCode == 403)
    {
      RequestOptions options = error.response.request;
      Client.dio.interceptors.requestLock.lock();
      Client.dio.interceptors.responseLock.lock();
      Dio tokenDio = Dio();
      tokenDio.options = Client.dio.options;
      Response response = await tokenDio.get('/token');
      String token = IdentityModel.fromJson(response.data).token;
      box.write('token', token);
      options.headers['Authorization']='Bearer $token';
      Client.dio.interceptors.requestLock.unlock();
      Client.dio.interceptors.responseLock.unlock();
      return Client.dio.request(options.path,options: options);
    }else return error;
  }
}