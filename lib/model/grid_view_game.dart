class GridViewGame {
  String? _gameID;
  String? _steamAppID;
  String? _cheapest;
  String? _cheapestDealID;
  String? _external;
  String? _internalName;
  String? _thumb;

  GridViewGame(
      {String? gameID,
        String? steamAppID,
        String? cheapest,
        String? cheapestDealID,
        String? external,
        String? internalName,
        String? thumb}) {
    if (gameID != null) {
      this._gameID = gameID;
    }
    if (steamAppID != null) {
      this._steamAppID = steamAppID;
    }
    if (cheapest != null) {
      this._cheapest = cheapest;
    }
    if (cheapestDealID != null) {
      this._cheapestDealID = cheapestDealID;
    }
    if (external != null) {
      this._external = external;
    }
    if (internalName != null) {
      this._internalName = internalName;
    }
    if (thumb != null) {
      this._thumb = thumb;
    }
  }

  String? get gameID => _gameID;
  set gameID(String? gameID) => _gameID = gameID;
  String? get steamAppID => _steamAppID;
  set steamAppID(String? steamAppID) => _steamAppID = steamAppID;
  String? get cheapest => _cheapest;
  set cheapest(String? cheapest) => _cheapest = cheapest;
  String? get cheapestDealID => _cheapestDealID;
  set cheapestDealID(String? cheapestDealID) =>
      _cheapestDealID = cheapestDealID;
  String? get external => _external;
  set external(String? external) => _external = external;
  String? get internalName => _internalName;
  set internalName(String? internalName) => _internalName = internalName;
  String? get thumb => _thumb;
  set thumb(String? thumb) => _thumb = thumb;

  GridViewGame.fromJson(Map<String, dynamic> json) {
    _gameID = json['gameID'];
    _steamAppID = json['steamAppID'];
    _cheapest = json['cheapest'];
    _cheapestDealID = json['cheapestDealID'];
    _external = json['external'];
    _internalName = json['internalName'];
    _thumb = json['thumb'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['gameID'] = this._gameID;
    data['steamAppID'] = this._steamAppID;
    data['cheapest'] = this._cheapest;
    data['cheapestDealID'] = this._cheapestDealID;
    data['external'] = this._external;
    data['internalName'] = this._internalName;
    data['thumb'] = this._thumb;
    return data;
  }
}