import 'package:flutter/material.dart';

final search = TextEditingController();
var arrDishes = [
  {"image": "assets/images/biryani.png", "name": "Biryani"},
  {"image": "assets/images/cake.png", "name": "Cake"},
  {"image": "assets/images/chicken.png", "name": "Chicken"},
  {"image": "assets/images/pizza.png", "name": "Pizza"},
  {"image": "assets/images/burger.png", "name": "Burger"},
  {"image": "assets/images/dosa.png", "name": "Dosa"},
  {"image": "assets/images/rice.png", "name": "Rice"},
  {"image": "assets/images/Shawrma.png", "name": "Shawarma"},
];
var arrRestaurant = [
  {
    "image": "assets/images/zyaka.jpg",
    "name": "Zaika's Restaurant ",
    "variety": " CHINESE  |  NORTH INDIAN",
    "route": "/stall1",
    "details": [
      {
        "image": "assets/images/zyaka.jpg",
        "name": "Zaika's Restaurant ",
        "variety": " CHINESE  |  NORTH INDIAN",
        "Logo": "assets/images/zyzka logo.jpg",
        "Menu": [
          {
            "Name": "Samosa",
            "Price": 15,
            "photo": "assets/images/samosa.jpg",
            "isVeg": true,
            "desciption":
            "Indulge in our savory samosa: crispy pastry, filled with spiced potatoes and peas, perfect with chutney."
          },
          {
            "Name": "Paratha",
            "Price": 25,
            "photo": "assets/images/paratha.jpeg",
            "isVeg": true,
            "desciption":
            "Discover our delicious paratha: whole wheat, pan-fried, filled with spiced vegetables or paneer. "
          },
          {
            "Name": "Samosa",
            "Price": 15,
            "photo": "assets/images/samosa.jpg",
            "isVeg": true,
            "desciption":
            "Indulge in our savory samosa: crispy pastry, filled with spiced potatoes and peas, perfect with chutney."
          },
          {
            "Name": "Paratha",
            "Price": 25,
            "photo": "assets/images/paratha.jpeg",
            "isVeg": true,
            "desciption":
            "Discover our delicious paratha: whole wheat, pan-fried, filled with spiced vegetables or paneer. "
          },
          {
            "Name": "Samosa",
            "Price": 15,
            "photo": "assets/images/samosa.jpg",
            "isVeg": true,
            "desciption":
            "Indulge in our savory samosa: crispy pastry, filled with spiced potatoes and peas, perfect with chutney."
          },
          {
            "Name": "Paratha",
            "Price": 25,
            "photo": "assets/images/paratha.jpeg",
            "isVeg": true,
            "desciption":
            "Discover our delicious paratha: whole wheat, pan-fried, filled with spiced vegetables or paneer. "
          },
        ]
      }
    ]
  },
  {
    "image": "assets/images/pizza.jpeg",
    "name": "Dominos",
    "variety": " PIZZA  |  COKE ",
    "route": "/stall2",
    "details": [
      {
        "image": "assets/images/pizza.jpeg",
        "name": "Dominos",
        "variety": " PIZZA  |  COKE ",
        "Logo": "assets/images/dominos logo.png",
        "Menu": [
          {
            "Name": "Panner Pizza",
            "Price": 250,
            "photo": "assets/images/paneer-pizza.jpg",
            "isVeg": true,
            "desciption":
            "Delicious paneer pizza with rich tomato sauce, fresh vegetables, creamy paneer, and golden crust perfection."
          },
          {
            "Name": "Chicken Tikka Pizza",
            "Price": 300,
            "photo": "assets/images/chicken tikka pizza.jpg",
            "isVeg": false,
            "desciption":
            "Succulent chicken tikka,spicy sauce,melted cheese,and crispy crust for a mouthwatering delight."
          },
          {
            "Name": "Panner Pizza",
            "Price": 250,
            "photo": "assets/images/paneer-pizza.jpg",
            "isVeg": true,
            "desciption":
            "Delicious paneer pizza with rich tomato sauce,fresh vegetables, creamy paneer, and golden crust perfection."
          },
          {
            "Name": "Chicken Tikka Pizza",
            "Price": 300,
            "photo": "assets/images/chicken tikka pizza.jpg",
            "isVeg": false,
            "desciption":
            "Succulent chicken tikka,spicy sauce,melted cheese,and crispy crust for a mouthwatering delight."
          },
          {
            "Name": "Panner Pizza",
            "Price": 250,
            "photo": "assets/images/paneer-pizza.jpg",
            "isVeg": true,
            "desciption":
            "Delicious paneer pizza with rich tomato sauce, fresh vegetables, creamy paneer, and golden crust perfection."
          },
          {
            "Name": "Chicken Tikka Pizza",
            "Price": 300,
            "photo": "assets/images/chicken tikka pizza.jpg",
            "isVeg": false,
            "desciption":
            "Succulent chicken tikka,spicy sauce,melted cheese,and crispy crust for a mouthwatering delight."
          },
        ]
      }
    ]
  },
  {
    "image": "assets/images/Tandoori-Momos-2B.jpg",
    "name": "WoW Momos",
    "variety": "  VEG  |  NON - VEG",
    "route": "/stall3",
    "details": [
      {
        "image": "assets/images/Tandoori-Momos-2B.jpg",
        "name": "WoW Momos",
        "variety": "  VEG  |  NON - VEG",
        "Logo": "assets/images/wow momos logo.jpg",
        "Menu": [
          {
            "Name": "Veg Momo",
            "Price": 80,
            "photo": "assets/images/veg momos.jpeg",
            "isVeg": true,
            "desciption":
            "Steamed dumplings filled with fresh vegetables, served with a spicy dipping sauce."
          },
          {
            "Name": "Non-Veg Momo",
            "Price": 100,
            "photo": "assets/images/nonveg momo.jpg",
            "isVeg": false,
            "desciption":
            "Juicy meat-filled dumplings, steamed to perfection, accompanied by a tangy chili sauce."
          },
          {
            "Name": "Veg Momo",
            "Price": 80,
            "photo": "assets/images/veg momos.jpeg",
            "isVeg": true,
            "desciption":
            "Steamed dumplings filled with fresh vegetables, served with a spicy dipping sauce."
          },
          {
            "Name": "Non-Veg Momo",
            "Price": 100,
            "photo": "assets/images/nonveg momo.jpg",
            "isVeg": false,
            "desciption":
            "Juicy meat-filled dumplings, steamed to perfection, accompanied by a tangy chili sauce."
          },
          {
            "Name": "Veg Momo",
            "Price": 80,
            "photo": "assets/images/veg momos.jpeg",
            "isVeg": true,
            "desciption":
            "Steamed dumplings filled with fresh vegetables, served with a spicy dipping sauce."
          },
          {
            "Name": "Non-Veg Momo",
            "Price": 100,
            "photo": "assets/images/nonveg momo.jpg",
            "isVeg": false,
            "desciption":
            "Juicy meat-filled dumplings, steamed to perfection, accompanied by a tangy chili sauce."
          },
        ]
      }
    ]
  },
  {
    "image": "assets/images/burger-with-melted-cheese.jpeg",
    "name": "Burger King",
    "variety": "BURGERS  |  FRIES",
    "route": "/stall4",
    "details": [
      {
        "image": "assets/images/burger-with-melted-cheese.jpeg",
        "name": "Burger King",
        "variety": "BURGERS  |  FRIES",
        "Logo": "assets/images/burger king logo.png",
        "Menu": [
          {
            "Name": "Burger",
            "Price": 60,
            "photo": "assets/images/burger.jpg",
            "isVeg": true,
            "desciption":
            "Juicy patty, fresh lettuce, tomatoes, pickles, and melted cheese in a soft bun."
          },
          {
            "Name": "Fries",
            "Price": 40,
            "photo": "assets/images/fries.jpeg",
            "isVeg": true,
            "desciption":
            "Golden, crispy potato fries, perfectly seasoned for a delightful crunch in every bite."
          },
          {
            "Name": "Burger",
            "Price": 60,
            "photo": "assets/images/burger.jpg",
            "isVeg": true,
            "desciption":
            "Juicy patty, fresh lettuce, tomatoes, pickles, and melted cheese in a soft bun."
          },
          {
            "Name": "Fries",
            "Price": 40,
            "photo": "assets/images/fries.jpeg",
            "isVeg": true,
            "desciption":
            "Golden, crispy potato fries, perfectly seasoned for a delightful crunch in every bite."
          },
          {
            "Name": "Burger",
            "Price": 60,
            "photo": "assets/images/burger.jpg",
            "isVeg": true,
            "desciption":
            "Juicy patty, fresh lettuce, tomatoes, pickles, and melted cheese in a soft bun."
          },
          {
            "Name": "Fries",
            "Price": 40,
            "photo": "assets/images/fries.jpeg",
            "isVeg": true,
            "desciption":
            "Golden, crispy potato fries, perfectly seasoned for a delightful crunch in every bite."
          },
        ]
      }
    ]
  },
  {
    "image": "assets/images/ice cream.jpeg",
    "name": "Kwality Walls",
    "variety": " ICE - CREAMS  |  SHAKES",
    "route": "/stall5",
    "details": [
      {
        "image": "assets/images/ice cream.jpeg",
        "name": "Kwality Walls",
        "variety": " ICE - CREAMS  |  SHAKES",
        "Logo": "assets/images/kwality walls icon.png",
        "Menu": [
          {
            "Name": "Ice-Creams",
            "Price": 30,
            "photo": "assets/images/ice-cream.jpg",
            "isVeg": true,
            "desciption":
            "Creamy, rich ice cream in various flavors, a perfect treat to cool you down."
          },
          {
            "Name": "Shakes",
            "Price": 50,
            "photo": "assets/images/shakes.jpeg",
            "isVeg": true,
            "desciption":
            "Thick, creamy milkshakes in assorted flavors, blended to perfection for a refreshing treat."
          },
          {
            "Name": "Ice-Creams",
            "Price": 30,
            "photo": "assets/images/ice-cream.jpg",
            "isVeg": true,
            "desciption":
            "Creamy, rich ice cream in various flavors, a perfect treat to cool you down."
          },
          {
            "Name": "Shakes",
            "Price": 50,
            "photo": "assets/images/shakes.jpeg",
            "isVeg": true,
            "desciption":
            "Thick, creamy milkshakes in assorted flavors, blended to perfection for a refreshing treat."
          },
          {
            "Name": "Ice-Creams",
            "Price": 30,
            "photo": "assets/images/ice-cream.jpg",
            "isVeg": true,
            "desciption":
            "Creamy, rich ice cream in various flavors, a perfect treat to cool you down."
          },
          {
            "Name": "Shakes",
            "Price": 50,
            "photo": "assets/images/shakes.jpeg",
            "isVeg": true,
            "desciption":
            "Thick, creamy milkshakes in assorted flavors, blended to perfection for a refreshing treat."
          },
        ]
      }
    ]
  },
];

final Orders = [
  {
        "Stall": "Kwality Walls",
        "Data": [
          {
            "Item": "Peach MilkShake",
            "num" : 3,
            "price": 25
          },
          {
            "Item": "Ice-Cream",
            "num" : 4,
            "price": 35
          },
        ],
      },
  {
        "Stall": "Kwality Walls",
        "Data": [
          {
            "Item": "Peach MilkShake",
            "num" : 3,
            "price": 25
          },
          {
            "Item": "Ice-Cream",
            "num" : 4,
            "price": 35
          },
        ],
      }
];

final List<String> images = [
  'assets/images/1.jpg',
 'assets/images/2.jpg',
 'assets/images/1.jpg',
 'assets/images/2.jpg',
 'assets/images/1.jpg',

];

final PageController pageController = PageController();