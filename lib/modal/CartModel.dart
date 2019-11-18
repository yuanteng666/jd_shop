class CartModel {
    List<Result> _result;

    CartModel({List<Result> result}) {
        this._result = result;
    }

    List<Result> get result => _result;
    set result(List<Result> result) => _result = result;

    CartModel.fromJson(Map<String, dynamic> json) {
        if (json['result'] != null) {
            _result = new List<Result>();
            json['result'].forEach((v) {
                _result.add(new Result.fromJson(v));
            });
        }
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        if (this._result != null) {
            data['result'] = this._result.map((v) => v.toJson()).toList();
        }
        return data;
    }
}

class Result {
    String _sId;
    String _title;
    Object _status;
    String _pic;
    String _pid;
    String _sort;

    Result(
        {String sId,
            String title,
            String status,
            String pic,
            String pid,
            String sort}) {
        this._sId = sId;
        this._title = title;
        this._status = status;
        this._pic = pic;
        this._pid = pid;
        this._sort = sort;
    }

    String get sId => _sId;
    set sId(String sId) => _sId = sId;
    String get title => _title;
    set title(String title) => _title = title;
    Object get status => _status;
    set status(String status) => _status = status;
    String get pic => _pic;
    set pic(String pic) => _pic = pic;
    String get pid => _pid;
    set pid(String pid) => _pid = pid;
    String get sort => _sort;
    set sort(String sort) => _sort = sort;

    Result.fromJson(Map<String, dynamic> json) {
        _sId = json['_id'];
        _title = json['title'];
        _status = json['status'];
        _pic = json['pic'];
        _pid = json['pid'];
        _sort = json['sort'];
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['_id'] = this._sId;
        data['title'] = this._title;
        data['status'] = this._status;
        data['pic'] = this._pic;
        data['pid'] = this._pid;
        data['sort'] = this._sort;
        return data;
    }
}
