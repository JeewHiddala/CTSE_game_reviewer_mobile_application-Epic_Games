class Games {
  final String gameName;
  final String imagePath;
  final String rating;
  final String developer;
  final String noOfPlayers;
  final String price;
  final String description;

  Games({
    required this.gameName,
    required this.imagePath,
    required this.rating,
    required this.developer,
    required this.noOfPlayers,
    required this.price,
    required this.description,
  });
}

final fortniteGame = Games(
    gameName: "Fortnite",
    imagePath: "assets/images/fortnite.jpg",
    rating: "01",
    developer: "Rooman Vas",
    noOfPlayers: "100+",
    price: '8000',
    description: 'Fortnite is a survival game that fight against each other');
//price: "$20"),
//description: "Fortnite is a survival and very interesting game that fight against each other.");

final pubgGame = Games(
    gameName: "PUBG",
    imagePath: "assets/images/pubg.png",
    rating: "02",
    developer: "PUBG Coroperation",
    noOfPlayers: "100+",
    description:
        'shooter game that happens until fighting to remain the last alive',
    price: '7000');

final spidermanGame = Games(
    gameName: "Spiderman",
    imagePath: "assets/images/spiderman.webp",
    rating: "03",
    developer: "Imsomniac Games",
    noOfPlayers: "10+",
    price: '4000',
    description: 'It is a action adventurous game and interesting');

final adventureGame = Games(
    gameName: "Fast & Furious",
    imagePath: "assets/images/adventure.webp",
    rating: "04",
    developer: "Slightly Mad Studios",
    noOfPlayers: "20+",
    description: 'Recing and action role game which is very interesting',
    price: '3000');

final games = [fortniteGame, pubgGame, spidermanGame, adventureGame];
