class PizzaModel {
  final String url;
  final String description;
  final String name;
  final double price;
  final int id;

  const PizzaModel({
    required this.price,
    required this.url,
    required this.description,
    required this.name,
    required this.id,
  });
}

const List<PizzaModel> pizzas = [
  PizzaModel(
      price: 19.99,
      url: ImageConsts.image1,
      description:
          "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
      name: "Hawaiian",
      id: 1),
  PizzaModel(
      price: 14.99,
      url: ImageConsts.image2,
      description:
          "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
      name: "Italian",
      id: 2),
  PizzaModel(
      price: 9.99,
      url: ImageConsts.image3,
      description:
          "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
      name: "Peperoni",
      id: 3),
  PizzaModel(
      price: 29.99,
      url: ImageConsts.image4,
      description:
          "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
      name: "Special",
      id: 4),
];

class ImageConsts {
  static const image1 = "assets/hawaiian_pizza.jpg";
  static const image2 = "assets/italian_pizza.jpg";
  static const image3 = "assets/peperoni.jpg";
  static const image4 = "assets/special_pizza.jpg";
}
