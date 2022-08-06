class ApisResponse<T> {
  late bool ok;
  late String msg;
  late T result;

  ApisResponse.ok(this.result) {
    ok = true;
  }

  ApisResponse.error(this.msg) {
    ok = false;
  }
}
