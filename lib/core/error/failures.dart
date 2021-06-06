
abstract class Failure {
}

// General failures
class ServerFailure extends Failure{
  int errorCode;
  List<String> errorMessage;
  ServerFailure({this.errorCode,this.errorMessage});
  setErrorCode(int errorCode){
    this.errorCode = errorCode;
  }
  int getErrorCode() {return errorCode;}
  List parseErrorCode(){
    switch (errorCode){
      case 400:
        return [400,"Bad Request"];
      case 401:
        return [401,"UnAuthorized"];
      case 403:
        return [403,"Forbidden"];
      case 404:
        return [404,"Not Found"];
      case 422:
        return [422,"Not Found"];
      case 500:
        return [500,"Internal Server Error"];
      case 501:
        return [501,"Not Implemented"];
      case 502:
        return [502,"Bad Gateway"];
      case 503:
        return [503,"Service Unavailable"];
      case 651:
        return [651,"Not Found Record Exception"];
      case 654:
        return [654,"Duplication Record Exception"];
      case 701:
        return [701,"Token is invalid"];
      case 702:
        return [702,"Token is not expired yet"];
      case 703:
        return [703,"Refresh token not found"];
      case 705:
        return [705,"refresh token has been used"];
      case 706:
        return [706,"refresh token is not match"];
      case 707:
        return [707,"Token is expired"];
      default:
        return [0,"unHandle"];
    }
  }
}

class CacheFailure extends Failure {}
