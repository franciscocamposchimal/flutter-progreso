class Pets {
  List<Pet> items = new List();
  Pets();
  Pets.fromJsonList(List<dynamic> jsonList) {
    if (jsonList == null) return;
    for (var item in jsonList) {
      final fixItem = item['data'];
      fixItem['id'] = item['id'];
      final pet = new Pet.fromJsonMap(fixItem);
      items.add(pet);
    }
  }
}

class Pet {
  String id;
  String breed;
  String genus;
  String image;
  String name;
  String picture;
  String size;
  String user;
  String weight;

  Pet({
    this.id,
    this.breed,
    this.genus,
    this.image,
    this.name,
    this.picture,
    this.size,
    this.user,
    this.weight,
  });

  Pet.fromJsonMap(Map<String, dynamic> json) {
    id = json["id"];
    breed = json["breed"];
    genus = json["genus"];
    image = json["image"];
    name = json["name"];
    picture = json["picture"];
    size = json["size"];
    user = json["user"];
    weight = json["weight"];
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "breed": breed,
        "genus": genus,
        "image": image,
        "name": name,
        "picture": picture,
        "size": size,
        "user": user,
        "weight": weight,
      };
}
