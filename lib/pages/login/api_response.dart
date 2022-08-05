class ApisResponse<T>{
  bool ok;
  String msg;
  T result;

  ApisResponse.ok(this.result){
    ok=true;
  }
  ApisResponse.error(this.msg){
    ok=false;
  }
}