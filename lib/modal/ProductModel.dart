class ProductModel {
    List<Result> _result;

    ProductModel({List<Result> result}) {
        this._result = result;
    }

    List<Result> get result => _result;
    set result(List<Result> result) => _result = result;

    ProductModel.fromJson(Map<String, dynamic> json) {
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
    String _cid;
    Object _price;
    String _oldPrice;
    String _pic;
    String _sPic;

    Result(
        {String sId,
            String title,
            String cid,
            Object price,
            String oldPrice,
            String pic,
            String sPic}) {
        this._sId = sId;
        this._title = title;
        this._cid = cid;
        this._price = price;
        this._oldPrice = oldPrice;
        this._pic = pic;
        this._sPic = sPic;
    }

    String get sId => _sId;
    set sId(String sId) => _sId = sId;
    String get title => _title;
    set title(String title) => _title = title;
    String get cid => _cid;
    set cid(String cid) => _cid = cid;
    Object get price => _price;
    set price(Object price) => _price = price;
    String get oldPrice => _oldPrice;
    set oldPrice(String oldPrice) => _oldPrice = oldPrice;
    String get pic => _pic;
    set pic(String pic) => _pic = pic;
    String get sPic => _sPic;
    set sPic(String sPic) => _sPic = sPic;

    Result.fromJson(Map<String, dynamic> json) {
        _sId = json['_id'];
        _title = json['title'];
        _cid = json['cid'];
        _price = json['price'];
        _oldPrice = json['old_price'];
        _pic = json['pic'];
        _sPic = json['s_pic'];
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['_id'] = this._sId;
        data['title'] = this._title;
        data['cid'] = this._cid;
        data['price'] = this._price;
        data['old_price'] = this._oldPrice;
        data['pic'] = this._pic;
        data['s_pic'] = this._sPic;
        return data;
    }
}
