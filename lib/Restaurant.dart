class Restaurant {
  String _name;
  int _id;
  Restaurant(this._name);
  Restaurant.withID(this._id, this._name);
  Restaurant.fromDB(Map<String, dynamic> data) {
    this._id = data['id'];
    this._name = data['restaurantname'];
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> data = {
      'restaurantname': this._name,
    };
    if (_id != null) {
      data['id'] = this._id;
    }
    return data;
  }

  int getId() {
    return this._id;
  }

  String getUsername() {
    return this._name;
  }
}
