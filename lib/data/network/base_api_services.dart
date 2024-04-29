
abstract class BaseApiServices {

  Future<dynamic> getApi({required String url,required bool isHeaderRequired}) ;


  Future<dynamic> postApi({required dynamic data,required String url,required bool isHeaderRequired}) ;
 Future<dynamic> putApi({required dynamic data,required String url,required bool isHeaderRequired}) ;

}