import 'package:foodapp/constants/assets.dart';
import 'package:foodapp/data_layer/data_base/global_demo_data_model.dart';
import 'package:foodapp/data_layer/data_models/random_data.dart';

List<FoodModel> italianFoodDemoData = [
  FoodModel(
    foodType: "SpecialFood",
    foodName: "Pizza Napoletana",
    description:
        "Let's start with a basic dish that might as well be a universal favorite. Although a wide range of world cuisines serve up a flatbread with toppings, pizza has got to be close to the top of the popularity charts. ",
    foodPrice: 19.99,
    imagePath: "${Assets.italianBase}Pizza_Napoletana.webp",
    foodRate: 4.5,
    calories: RandomData.getRandomCalories,
    numberOfReviewers: RandomData.getRandomReviewers,
  ),
  FoodModel(
    foodType: "SpecialFood",
    foodName: "Polenta",
    description:
        "A glance at an unassuming pot of polenta might not evoke enthusiasm, but the dish is quite a chameleon. Its creamy consistency makes an excellent base for stews, and there are plenty of sweet and savory ways to pep it up. ",
    foodPrice: 21.99,
    imagePath: "${Assets.italianBase}Polenta.webp",
    foodRate: 4.9,
    calories: RandomData.getRandomCalories,
    numberOfReviewers: RandomData.getRandomReviewers,
  ),
  FoodModel(
    foodType: "SpecialFood",
    foodName: "Ribollita",
    description:
        "Praised for its tall cypress trees and endless rolling hills, Tuscany is also the source of many hearty dishes, one of which is ribollita, a filling soup that will become your new favorite comfort meal. The name means to reboil in Italian, which is exactly what used to be done to it day after day in an effort to stretch it into one more meal.",
    foodPrice: 30.99,
    imagePath: "${Assets.italianBase}Ribollita.webp",
    foodRate: 3.9,
    calories: RandomData.getRandomCalories,
    numberOfReviewers: RandomData.getRandomReviewers,
  ),
  FoodModel(
    foodType: "SpecialFood",
    foodName: "Risotto alla Milanese",
    description:
        "As far as rice-based dishes go, risotto is certainly a popular option with endless variations, including risotto alla Milanese, so named for its city of origin, Milan. The north of the country has excellent growing conditions for rice, making it the perfect ingredient for local dishes. ",
    foodPrice: 20.5,
    imagePath: "${Assets.italianBase}Risotto_alla_Milanese.webp",
    foodRate: 4.3,
    calories: RandomData.getRandomCalories,
    numberOfReviewers: RandomData.getRandomReviewers,
  ),
  FoodModel(
    foodType: "SpecialFood",
    foodName: "Osso Buco alla Milanese",
    description:
        "Osso buco is one of the more familiar meat preparations of Italian cuisine. It's no surprise that it's more common to find the dish named in Italian since the English translation amounts to bone with hole.",
    foodPrice: 40.99,
    imagePath: "${Assets.italianBase}Osso_Buco_alla_Milanese.webp",
    foodRate: 4.7,
    calories: RandomData.getRandomCalories,
    numberOfReviewers: RandomData.getRandomReviewers,
  ),
  FoodModel(
    foodType: "SpecialFood",
    foodName: "Risotto di Seppie alla Veneziana",
    description:
        "Whereas risotto alla Milanese is instantly recognizable by its bright yellow color, risotto di seppie alla Veneziana is inky black. In fact, the rice dish from Venice gets its color after soaking in either cuttlefish or squid ink, common in the surrounding Adriatic Sea. The dish is also popular in Croatia, which sits on the other side of the sea.",
    foodPrice: 60.99,
    imagePath: "${Assets.italianBase}Risotto_di_Seppie_alla_Veneziana.webp",
    foodRate: 4.1,
    calories: RandomData.getRandomCalories,
    numberOfReviewers: RandomData.getRandomReviewers,
  ),
  FoodModel(
    foodType: "SpecialFood",
    foodName: "Bottarga",
    description:
        "With such a lengthy coastline, it should come as no surprise that many Italian specialties display seafood front and center.Bottarga is a sort of Mediterranean caviar since it is, in fact, produced from fish roe.",
    foodPrice: 10.99,
    imagePath: "${Assets.italianBase}Bottarga.webp",
    foodRate: 3.7,
    calories: RandomData.getRandomCalories,
    numberOfReviewers: RandomData.getRandomReviewers,
  ),
  FoodModel(
    foodType: "SpecialFood",
    foodName: "Baccalà",
    description:
        "Baccalà is the name given to cod that has been salted and dried, a common practice in Italy that dates back to a time when the fish was especially abundant. The popular dish is prepared with dozens of regional variations and is often a mainstay on the table around Christmas time.",
    foodPrice: 32.99,
    imagePath: "${Assets.italianBase}Baccalà.webp",
    foodRate: 4.6,
    calories: RandomData.getRandomCalories,
    numberOfReviewers: RandomData.getRandomReviewers,
  ),
  FoodModel(
    foodType: "SpecialFood",
    foodName: "Vitello Tonnato",
    description:
        "When it comes to iconic dishes from the north of Italy, vitello tonnato from Piedmont is certainly a must-try. The combination of ingredients might sound peculiar, but trust us, the flavor pairings somehow work. Thin slices of veal are marinated in white wine and boiled. Nothing out of the ordinary here, but the meat is then covered in a creamy tuna, anchovy, and caper sauce and usually served cold.",
    foodPrice: 90.99,
    imagePath: "${Assets.italianBase}Vitello_Tonnato.webp",
    foodRate: 3.4,
    calories: RandomData.getRandomCalories,
    numberOfReviewers: RandomData.getRandomReviewers,
  ),
  FoodModel(
    foodType: "SpecialFood",
    foodName: "Canederli",
    description:
        "Italy borders a number of countries, and this is especially evident in the cuisine from the northernmost region of South Tyrol, once a part of Austria. Gone are the coastal vistas; here, towns are scattered around the Dolomite mountains. Consequently, the dining options are significantly different from the rest of Italy, and Austrian and German-style dishes are prevalent. ",
    foodPrice: 53.99,
    imagePath: "${Assets.italianBase}Canederli.webp",
    foodRate: 4.1,
    calories: RandomData.getRandomCalories,
    numberOfReviewers: RandomData.getRandomReviewers,
  ),
  FoodModel(
    foodType: "SpecialFood",
    foodName: "Fritto Misto",
    description:
        "Frito misto basically translates as fried mix, but the specifics of the assorted snacks vary by region. Along the coastline, seafood is abundant;crustaceans, mollusks, and tiny fish are lightly floured, deep-fried, and served as a crispy snack.",
    foodPrice: 42.99,
    imagePath: "${Assets.italianBase}Fritto_Misto.webp",
    foodRate: 4.2,
    calories: RandomData.getRandomCalories,
    numberOfReviewers: RandomData.getRandomReviewers,
  ),
  FoodModel(
    foodType: "SpecialFood",
    foodName: "Ragù alla Bolognese",
    description:
        "Whereas spaghetti and meatballs as a dish is purely an Italian-American creation, ragù alla Bolognese is perhaps the original source of inspiration. The name comes from the dish's city of origin, Bologna, and the preparation was first made by one of the pope's chefs. ",
    foodPrice: 67.99,
    imagePath: "${Assets.italianBase}Ragù_alla_Bolognese.webp",
    foodRate: 5.0,
    calories: RandomData.getRandomCalories,
    numberOfReviewers: RandomData.getRandomReviewers,
  ),
  FoodModel(
    foodType: "SpecialFood",
    foodName: "Bistecca Fiorentina",
    description:
        "It might seem fairly basic, but bistecca Fiorentina — beef steak from Florence — is officially considered to be one of Tuscany's traditional food products. Consequently, there are specific requirements as to the type and preparation of the meat. The only breed of cattle permitted for the steak is Chianina, which produces prized lean meat.",
    foodPrice: 25.99,
    imagePath: "${Assets.italianBase}Bistecca_Fiorentina.webp",
    foodRate: 4.9,
    calories: RandomData.getRandomCalories,
    numberOfReviewers: RandomData.getRandomReviewers,
  ),
  FoodModel(
    foodType: "SpecialFood",
    foodName: "Arancini",
    description:
        "Who doesn't love a fried snack? Arancini is undoubtedly one of Italy's more popular crispy offerings, and it's not hard to see why. A mound of rice is stuffed with other ingredients such as meat, peas, cheese, or capers, then coated in breadcrumbs and deep-fried, creating a crunchy orange shell. ",
    foodPrice: 55.99,
    imagePath: "${Assets.italianBase}Arancini.webp",
    foodRate: 4.5,
    calories: RandomData.getRandomCalories,
    numberOfReviewers: RandomData.getRandomReviewers,
  ),
  FoodModel(
    foodType: "SpecialFood",
    foodName: "Melanzane alla Parmigiana",
    description:
        "Melanzane alla parmigiana, aka eggplant Parmesan, has certainly made its way to the U.S. with great popularity. Unsurprisingly, its origin story is somewhat opaque, with people from the city of Parma viewing the dish as being from the north and southern Italians asserting that it comes from Naples or Sicily.",
    foodPrice: 87.99,
    imagePath: "${Assets.italianBase}Melanzane_alla_Parmigiana.webp",
    foodRate: 4.4,
    calories: RandomData.getRandomCalories,
    numberOfReviewers: RandomData.getRandomReviewers,
  ),
  FoodModel(
    foodType: "SpecialFood",
    foodName: "Saltimbocca alla Romana",
    description:
        "Saltimbocca, which translates as jumps in the mouth, hints at the delightful blend of flavors you can expect. The Roman specialty may have been around earlier, but the first written record dates to the end of the 1800s. Again, some confusion as to the origin exists, since the same dish was already common in the city of Brescia in the north of Italy at the start of the 1800s.",
    foodPrice: 32.99,
    imagePath: "${Assets.italianBase}Saltimbocca_alla_Romana.webp",
    foodRate: 3.4,
    calories: RandomData.getRandomCalories,
    numberOfReviewers: RandomData.getRandomReviewers,
  ),
  FoodModel(
    foodType: "SpecialFood",
    foodName: "Cacio e Pepe",
    description:
        "Cacio e pepe is the proof that you can do very much with very little. Two of the three ingredients are displayed in the name — for anyone who speaks the Roman dialect, that is. Cacio means sheep's cheese (usually Pecorino), pepe refers to a black peppercorn, and the final item is, of course, pasta. Long noodles are best for coating with the creamy sauce, and spaghetti is an easy option though other types are also considered appropriate.",
    foodPrice: 99.99,
    imagePath: "${Assets.italianBase}Cacio_e_Pepe.webp",
    foodRate: 4.3,
    calories: RandomData.getRandomCalories,
    numberOfReviewers: RandomData.getRandomReviewers,
  ),
  FoodModel(
    foodType: "SpecialFood",
    foodName: "Gnocchi",
    description:
        "While gnocchi is often served with sauce, much like pasta, it is composed of entirely different ingredients. The little plump dumplings are traditionally made from potatoes, which grow well in the cooler climate in the north of the country. Traditional potato gnocchi likely originated sometime around the 17th century since the root vegetable was not introduced until then. The basic recipe requires a bit of flour to help shape the mounds, and many variations include an egg as a binder.",
    foodPrice: 50.99,
    imagePath: "${Assets.italianBase}Gnocchi.webp",
    foodRate: 4.5,
    calories: RandomData.getRandomCalories,
    numberOfReviewers: RandomData.getRandomReviewers,
  ),
  FoodModel(
    foodType: "SpecialFood",
    foodName: "Spaghetti alle Vongole",
    description:
        "As far as iconic Neapolitan dishes go, spaghetti alle vongole (with clams) is high up on the list. Being a city by the Mediterranean, Naples is the perfect location for dishes showcasing the briny flavors of the sea. Simple, classic, and easily one of the best meals you'll have if it's properly made, spaghetti with clams requires very few ingredients.",
    foodPrice: 105.0,
    imagePath: "${Assets.italianBase}Spaghetti_alle_Vongole.webp",
    foodRate: 4.8,
    calories: RandomData.getRandomCalories,
    numberOfReviewers: RandomData.getRandomReviewers,
  ),
  FoodModel(
    foodType: "SpecialFood",
    foodName: "Lasagna",
    description:
        "Although lasagna is well-cemented in Italian menus locally and internationally, it owes its first variations to Greek cuisine. Nowadays, the dish has expanded to encompass dozens of styles, with plenty of meat and plant-based versions to appeal to the masses. The standard recipe made with bechamel and meat ragu is thought to come from the Italian region of Emilia-Romagna.",
    foodPrice: 60.0,
    imagePath: "${Assets.italianBase}Lasagna.webp",
    foodRate: 4.2,
    calories: RandomData.getRandomCalories,
    numberOfReviewers: RandomData.getRandomReviewers,
  ),
  FoodModel(
    foodType: "SpecialFood",
    foodName: "Minestrone",
    description:
        "It doesn't get much more heartwarming than a bowl of minestrone, especially if it's homemade by a nonna. The soup became widespread among the Romans as early as the 2nd century BC, and it hasn't shown any signs of letting up. Consisting of a mismatched assortment of ingredients, minestrone can take on many different forms depending on what is available. ",
    foodPrice: 120.99,
    imagePath: "${Assets.italianBase}Minestrone.webp",
    foodRate: 4.9,
    calories: RandomData.getRandomCalories,
    numberOfReviewers: RandomData.getRandomReviewers,
  ),
  FoodModel(
    foodType: "SpecialFood",
    foodName: "Focaccia",
    description:
        "What's not to love about focaccia, the simultaneously doughy and light bread? If you've collapsed it into the pizza category in your mind, it's time you placed it into a realm of its own. As a version of flatbread that eventually paved the way for pizza, focaccia dates back to a time before the Roman Empire, when it was likely enjoyed by the Etruscans and Greeks. ",
    foodPrice: 22.99,
    imagePath: "${Assets.italianBase}Focaccia.webp",
    foodRate: 4.1,
    calories: RandomData.getRandomCalories,
    numberOfReviewers: RandomData.getRandomReviewers,
  ),
  FoodModel(
    foodType: "SpecialFood",
    foodName: "Pasta puttanesca",
    description:
        "While there are endless Italian pasta dishes to try, puttanesca is a definite classic yet less popular internationally than, say, carbonara. If you speak a Latin language, the name might sound curious to you, and indeed, it has been the source of much speculation. As a derivative of the Italian word for prostitute, one might wonder what led to the creation of such a dish. ",
    foodPrice: 190.0,
    imagePath: "${Assets.italianBase}Pasta_puttanesca.webp",
    foodRate: 5.0,
    calories: RandomData.getRandomCalories,
    numberOfReviewers: RandomData.getRandomReviewers,
  ),
  FoodModel(
    foodType: "SpecialFood",
    foodName: "Bagna cauda",
    description:
        "This classic specialty from Piedmont incorporates basic ingredients to make a delightful dish traditionally enjoyed by large groups of farmers following a hard day of work. Commonly prepared and enjoyed following fall grape harvests with ingredients from the land, the recipe includes vegetables, garlic, olive oil, and salted anchovies.",
    foodPrice: 90.0,
    imagePath: "${Assets.italianBase}Bagna_cauda.webp",
    foodRate: 4.6,
    calories: RandomData.getRandomCalories,
    numberOfReviewers: RandomData.getRandomReviewers,
  ),
  FoodModel(
    foodType: "SpecialFood",
    foodName: "Andrew's Herb Risotto",
    description:
        "Risotto can stand in for potatoes or noodles as side-dish and is microwave reheatable. Great accompaniment with spring asparagus. The herbs and spices in this recipe are optional, so 'customize' it to suit your tastes!",
    foodPrice: 20.0,
    imagePath: "${Assets.italianBase}Andrew's_Herb_Risotto.webp",
    foodRate: 4.5,
    calories: RandomData.getRandomCalories,
    numberOfReviewers: RandomData.getRandomReviewers,
  ),
  FoodModel(
    foodType: "SpecialFood",
    foodName: "Risotto alla Pavese",
    description:
        "Creamy risotto made with fresh cranberry beans comes from the Lombardy region of Italy. With traditional flavors from the region, this risotto is bursting with flavor and healthy goodness. Cranberry beans are also called borlotti beans. ",
    foodPrice: 50.0,
    imagePath: "${Assets.italianBase}Risotto_alla_Pavese.webp",
    foodRate: 4.3,
    calories: RandomData.getRandomCalories,
    numberOfReviewers: RandomData.getRandomReviewers,
  ),
  FoodModel(
    foodType: "SpecialFood",
    foodName: "Panettone",
    description:
        "Panettone is one of the best Christmas breads from around the world, so you're sure to love it no matter how it's prepared and served. According to Italy Magazine, some people enjoy it with coffee in the morning; others prefer the holiday bread with a glass of Marsala wine or a sparkling Moscato in the evening after a meal.",
    foodPrice: 33.0,
    imagePath: "${Assets.italianBase}Panettone.webp",
    foodRate: 4.4,
    calories: RandomData.getRandomCalories,
    numberOfReviewers: RandomData.getRandomReviewers,
  ),
];
