class Game {
  Info? _info;
  CheapestPriceEver? _cheapestPriceEver;
  List<Deals>? _deals;

  Game({Info? info, CheapestPriceEver? cheapestPriceEver, List<Deals>? deals}) {
    if (info != null) {
      this._info = info;
    }
    if (cheapestPriceEver != null) {
      this._cheapestPriceEver = cheapestPriceEver;
    }
    if (deals != null) {
      this._deals = deals;
    }
  }

  Info? get info => _info;
  set info(Info? info) => _info = info;
  CheapestPriceEver? get cheapestPriceEver => _cheapestPriceEver;
  set cheapestPriceEver(CheapestPriceEver? cheapestPriceEver) =>
      _cheapestPriceEver = cheapestPriceEver;
  List<Deals>? get deals => _deals;
  set deals(List<Deals>? deals) => _deals = deals;

  Game.fromJson(Map<String, dynamic> json) {
    _info = json['info'] != null ? new Info.fromJson(json['info']) : null;
    _cheapestPriceEver = json['cheapestPriceEver'] != null
        ? new CheapestPriceEver.fromJson(json['cheapestPriceEver'])
        : null;
    if (json['deals'] != null) {
      _deals = <Deals>[];
      json['deals'].forEach((v) {
        _deals!.add(new Deals.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this._info != null) {
      data['info'] = this._info!.toJson();
    }
    if (this._cheapestPriceEver != null) {
      data['cheapestPriceEver'] = this._cheapestPriceEver!.toJson();
    }
    if (this._deals != null) {
      data['deals'] = this._deals!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Info {
  String? _title;
  String? _steamAppID;
  String? _thumb;

  Info({String? title, String? steamAppID, String? thumb}) {
    if (title != null) {
      this._title = title;
    }
    if (steamAppID != null) {
      this._steamAppID = steamAppID;
    }
    if (thumb != null) {
      this._thumb = thumb;
    }
  }

  String? get title => _title;
  set title(String? title) => _title = title;
  String? get steamAppID => _steamAppID;
  set steamAppID(String? steamAppID) => _steamAppID = steamAppID;
  String? get thumb => _thumb;
  set thumb(String? thumb) => _thumb = thumb;

  Info.fromJson(Map<String, dynamic> json) {
    _title = json['title'];
    _steamAppID = json['steamAppID'];
    _thumb = json['thumb'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this._title;
    data['steamAppID'] = this._steamAppID;
    data['thumb'] = this._thumb;
    return data;
  }
}

class CheapestPriceEver {
  String? _price;
  int? _date;

  CheapestPriceEver({String? price, int? date}) {
    if (price != null) {
      this._price = price;
    }
    if (date != null) {
      this._date = date;
    }
  }

  String? get price => _price;
  set price(String? price) => _price = price;
  int? get date => _date;
  set date(int? date) => _date = date;

  CheapestPriceEver.fromJson(Map<String, dynamic> json) {
    _price = json['price'];
    _date = json['date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['price'] = this._price;
    data['date'] = this._date;
    return data;
  }
}

class Deals {
  String? _storeID;
  String? _dealID;
  String? _price;
  String? _retailPrice;
  String? _savings;

  Deals(
      {String? storeID,
        String? dealID,
        String? price,
        String? retailPrice,
        String? savings}) {
    if (storeID != null) {
      this._storeID = storeID;
    }
    if (dealID != null) {
      this._dealID = dealID;
    }
    if (price != null) {
      this._price = price;
    }
    if (retailPrice != null) {
      this._retailPrice = retailPrice;
    }
    if (savings != null) {
      this._savings = savings;
    }
  }

  String? get storeID => _storeID;
  set storeID(String? storeID) => _storeID = storeID;
  String? get dealID => _dealID;
  set dealID(String? dealID) => _dealID = dealID;
  String? get price => _price;
  set price(String? price) => _price = price;
  String? get retailPrice => _retailPrice;
  set retailPrice(String? retailPrice) => _retailPrice = retailPrice;
  String? get savings => _savings;
  set savings(String? savings) => _savings = savings;

  Deals.fromJson(Map<String, dynamic> json) {
    _storeID = json['storeID'];
    _dealID = json['dealID'];
    _price = json['price'];
    _retailPrice = json['retailPrice'];
    _savings = json['savings'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['storeID'] = this._storeID;
    data['dealID'] = this._dealID;
    data['price'] = this._price;
    data['retailPrice'] = this._retailPrice;
    data['savings'] = this._savings;
    return data;
  }
}