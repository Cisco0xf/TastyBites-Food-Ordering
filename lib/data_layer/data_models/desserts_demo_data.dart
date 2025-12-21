import 'package:foodapp/constants/assets.dart';
import 'package:foodapp/data_layer/data_base/global_demo_data_model.dart';
import 'package:foodapp/data_layer/data_models/random_data.dart';

// GlobalDamoDataModel

List<FoodModel> dessertDemoData = [
  FoodModel(
    foodType: "Dessert",
    foodName: "Classic cookies",
    description:
        "Baking is an exact science. So, when it comes to dessertsBase there's nothing more valuable than a collection of tried-and-true recipes. Ones you can count on. Ones that have been tested, re-tested and perfected—like these. That’s why we're proud to call them our \"Bests\" and share them with you.",
    foodPrice: 10.0,
    imagePath: "${Assets.dessertsBase}classic_cookies.jpeg",
    foodRate: 4.0,
    calories: RandomData.getRandomCalories,
    numberOfReviewers: RandomData.getRandomReviewers,
  ),
  FoodModel(
    foodType: "Dessert",
    foodName: "Cherry Cobbler",
    description:
        "The best cherry cobbler tastes of rich, sweet cherries, has a light, flakey biscuit topping and takes just a few minutes to pull together. In search of the juiciest, most concentrated filling, we tested cobblers with fresh cherries, cobblers with frozen cherries, cobblers with a lot of cornstarch and cobblers with less. The winner was clear: frozen cherries have the lush, quintessential cherry flavor and perfect velvety texture that make cherry cobbler so beloved. Bonus points for the fact that they don’t require pitting and can be purchased year-round!",
    foodPrice: 40.0,
    imagePath: "${Assets.dessertsBase}Cherry_Cobbler.jpeg",
    foodRate: 4.2,
    calories: RandomData.getRandomCalories,
    numberOfReviewers: RandomData.getRandomReviewers,
  ),
  FoodModel(
    foodType: "Dessert",
    foodName: "Vanilla Cake",
    description:
        "We love the light texture that cake flour gives baked goods, but we didn't want you to buy a whole box of it. So we used a cheat — all-purpose flour mixed with cornstarch. Cornstarch blocks the formation of gluten in the flour and makes the cake airy and tender. We also added 3 tablespoons of vegetable oil, an old baker's trick, to ensure that the cake stays moist. The heavy cream keeps the frosting light and fluffy.",
    foodPrice: 29.0,
    imagePath: "${Assets.dessertsBase}Vanilla_Cake.jpeg",
    foodRate: 4.1,
    calories: RandomData.getRandomCalories,
    numberOfReviewers: RandomData.getRandomReviewers,
  ),
  FoodModel(
    foodType: "Dessert",
    foodName: "Chocolate Chip Cookies",
    description:
        "We skipped the white sugar and went all in with dark brown sugar, which gives our cookies the ideal chewiness and perfect level of sweetness. Paired with the right amount of semisweet chocolate chips, this treat is a definite winner. The recipe makes a lot of cookies, but in our opinion, this is never a problem!",
    foodPrice: 27.0,
    imagePath: "${Assets.dessertsBase}Chocolate_Chip_Cookies.jpeg",
    foodRate: 4.4,
    calories: RandomData.getRandomCalories,
    numberOfReviewers: RandomData.getRandomReviewers,
  ),
  FoodModel(
    foodType: "Dessert",
    foodName: "Lemon Meringue Pie",
    description:
        "It's the stuff of dreams: a classic sweet and tart dessert with a foolproof meringue topping that won't weep! We use mostly butter in our from-scratch pie dough, but add a little vegetable shortening as well — we found that this combination creates a crust that is both tender and flaky.",
    foodPrice: 30.0,
    imagePath: "${Assets.dessertsBase}Lemon_Meringue_Pie.jpeg",
    foodRate: 4.8,
    calories: RandomData.getRandomCalories,
    numberOfReviewers: RandomData.getRandomReviewers,
  ),
  FoodModel(
    foodType: "Dessert",
    foodName: "Strawberry Shortcake",
    foodPrice: 32.0,
    description:
        "For our simple and iconic shortcake, we discovered a great double-stacking technique that creates super light and high biscuits that are easy to split. This makes them easy to fill without crumbling. A simple recipe like this one allows its ingredients to shine, so use the very best berries you can find.",
    imagePath: "${Assets.dessertsBase}Strawberry_Shortcake.jpeg",
    foodRate: 4.2,
    calories: RandomData.getRandomCalories,
    numberOfReviewers: RandomData.getRandomReviewers,
  ),
  FoodModel(
    foodType: "Dessert",
    foodName: "Creme Brulee",
    description:
        "We wanted a rich and creamy custard that wasn't too sweet, so we could fully enjoy the signature crunchy layer of caramelized sugar on top. By only using egg yolks, we achieved a soft and creamy texture. We tried using milk and half-and-half but, in the end, we landed with heavy cream for its richness. Whole vanilla beans give a more intense, pure vanilla flavor that you can't get from extract. We also like seeing the vanilla seeds flecked throughout the custard.",
    foodPrice: 50.0,
    imagePath: "${Assets.dessertsBase}Creme_Brulee.jpeg",
    foodRate: 4.9,
    calories: RandomData.getRandomCalories,
    numberOfReviewers: RandomData.getRandomReviewers,
  ),
  FoodModel(
    foodType: "Dessert",
    foodName: "Coconut Layer Cake",
    description:
        "Can something be impossibly light while also being incredibly rich and decadent? Apparently so. This coconut cake is majestic in its height and a beauty — a flurry of tangy frosting, sweet shredded coconut and tender cake. It will truly put all other coconut cakes to shame. The bar has now been set.",
    foodPrice: 29.0,
    imagePath: "${Assets.dessertsBase}Coconut_Layer_Cake.jpeg",
    foodRate: 4.2,
    calories: RandomData.getRandomCalories,
    numberOfReviewers: RandomData.getRandomReviewers,
  ),
  FoodModel(
    foodType: "Dessert",
    foodName: "Lemon Bars",
    description:
        "It's tough to top a classic lemon bar, but we've done it! We kept the tender, buttery crust and bright filling of the original, and made a few improvements. For our luscious lemon layer, we employed a unique double-cooking method. Simmering first on the stovetop like lemon curd allows us to add butter, which balances the tart and sweet elements and adds a richer, smoother texture.",
    foodPrice: 90.0,
    imagePath: "${Assets.dessertsBase}Lemon_Bars.jpeg",
    foodRate: 4.1,
    calories: RandomData.getRandomCalories,
    numberOfReviewers: RandomData.getRandomReviewers,
  ),
  FoodModel(
    foodType: "Dessert",
    foodName: "Tiramisu",
    description:
        "Making this classic Italian dessert is surprisingly easy. We start the custard with a traditional Marsala-flavored zabaglione — a cooked mixture of egg yolks and sugar. Then we lighten it with tangy mascarpone cheese, which provides just the right creamy, mousse-like texture. Once assembled, the ladyfingers soften sufficiently after 4 hours in the refrigerator, but if you can wait longer, the flavors will meld even more.",
    foodPrice: 110.0,
    imagePath: "${Assets.dessertsBase}Tiramisu.jpeg",
    foodRate: 4.9,
    calories: RandomData.getRandomCalories,
    numberOfReviewers: RandomData.getRandomReviewers,
  ),
  FoodModel(
    foodType: "Dessert",
    foodName: "Cheesecake",
    description:
        "We've created the cheesecake of your dreams — rich, dense and creamy with a buttery, not-too-sweet graham cracker crust. Easy-to-follow instructions ensure a smooth, crack-free top every time.",
    foodPrice: 120.0,
    imagePath: "${Assets.dessertsBase}Cheesecake.jpeg",
    foodRate: 4.3,
    calories: RandomData.getRandomCalories,
    numberOfReviewers: RandomData.getRandomReviewers,
  ),
  FoodModel(
    foodType: "Dessert",
    foodName: "Fudgy Brownies",
    description:
        "We've created the perfect brownie by employing a few tips and tricks. Using both semisweet chocolate and cocoa powder gives us the deep and complex chocolate flavor we crave. Cooking the butter until golden brown adds a toasted nuttiness, while the pop of cream provides luscious texture.",
    foodPrice: 102.0,
    imagePath: "${Assets.dessertsBase}Fudgy_Brownies.jpeg",
    foodRate: 4.2,
    calories: RandomData.getRandomCalories,
    numberOfReviewers: RandomData.getRandomReviewers,
  ),
  FoodModel(
    foodType: "Dessert",
    foodName: "Banana Pudding",
    description:
        "This creamy banana dessert is our very favorite version, piled high with layers of just-ripe bananas, rich vanilla pudding and tender cookies. We used vanilla bean paste instead of extract in our homemade filling for a bold flavor boost and topped the pudding with swirls of freshly whipped cream. When it all comes together, it's dreamy, luscious and feeds a crowd!",
    foodPrice: 203.0,
    imagePath: "${Assets.dessertsBase}Banana_Pudding.jpeg",
    foodRate: 4.3,
    calories: RandomData.getRandomCalories,
    numberOfReviewers: RandomData.getRandomReviewers,
  ),
  FoodModel(
    foodType: "Dessert",
    foodName: "Peanut Brittle",
    description:
        "This sweet and salty peanut brittle has the perfect crunch and sheen. With a little patience, you'll have a delicious brittle to serve to party guests or as an edible gift around the holidays.",
    foodPrice: 39.99,
    imagePath: "${Assets.dessertsBase}Peanut_Brittle.jpeg",
    foodRate: 4.0,
    calories: RandomData.getRandomCalories,
    numberOfReviewers: RandomData.getRandomReviewers,
  ),
  FoodModel(
    foodType: "Dessert",
    foodName: "Apple Pie",
    description:
        "We love using a variety of apples in our pie; it adds both flavor and texture and makes every bite a little different. Vodka in the pie crust makes the dough easier to work with, and since the alcohol burns off during baking, it doesn't impart any flavor. But feel free to use bourbon or apple brandy instead to complement the filling.",
    foodPrice: 201.0,
    imagePath: "${Assets.dessertsBase}Apple_Pie.jpeg",
    foodRate: 4.1,
    calories: RandomData.getRandomCalories,
    numberOfReviewers: RandomData.getRandomReviewers,
  ),
  FoodModel(
    foodType: "Dessert",
    foodName: "Butter Cookies",
    description:
        "Your search is over — this perfect butter cookie will stay in your recipe box for years. It's crisp, yet tender and perfect for tea for two or cookies for someone special. Plus, you have the choice to make drop cookies or a slice-and-bake version!",
    foodPrice: 23.0,
    imagePath: "${Assets.dessertsBase}Butter_Cookies.jpeg",
    foodRate: 4.9,
    calories: RandomData.getRandomCalories,
    numberOfReviewers: RandomData.getRandomReviewers,
  ),
  FoodModel(
    foodType: "Dessert",
    foodName: "Peach Cobbler",
    description:
        "In our classic southern-style peach cobbler, we layer the fruit on top of the batter before baking. In the oven, the sweet batter rises through the peaches, creating a light and airy cake-like topping. We left the peaches unpeeled, which adds a nice color and makes the recipe even easier. Serve it with vanilla ice cream for the perfect summer dessert.",
    foodPrice: 76.0,
    imagePath: "${Assets.dessertsBase}Peach_Cobbler.jpeg",
    foodRate: 4.6,
    calories: RandomData.getRandomCalories,
    numberOfReviewers: RandomData.getRandomReviewers,
  ),
  FoodModel(
    foodType: "Dessert",
    foodName: "Peanut Butter Cookies",
    description:
        "We wanted a super peanut buttery treat but found that store-bought peanut butter made the cookies a bit gummy when we used more than 1 cup. So we ground roasted peanuts ourselves and added that to the batter for an additional boost of flavor. Honey and melted butter add richness and create a soft and chewy cookie with an irresistible crackled exterior. We topped the dough balls with raw sugar for extra crunch and a hit of sweetness that balances the salt of the peanuts.",
    foodPrice: 98.0,
    imagePath: "${Assets.dessertsBase}Peanut_Butter_Cookies.jpeg",
    foodRate: 4.5,
    calories: RandomData.getRandomCalories,
    numberOfReviewers: RandomData.getRandomReviewers,
  ),
  FoodModel(
    foodType: "Dessert",
    foodName: "Chocolate Lava Cakes",
    description:
        "Go ahead and indulge in these perfectly rich and dreamy chocolate lava cakes! Bittersweet chocolate and espresso powder create a luscious and balanced batter that stays molten in the center during baking.",
    foodPrice: 13.0,
    imagePath: "${Assets.dessertsBase}Chocolate_Lava_Cakes.jpeg",
    foodRate: 4.0,
    calories: RandomData.getRandomCalories,
    numberOfReviewers: RandomData.getRandomReviewers,
  ),
  FoodModel(
    foodType: "Dessert",
    foodName: "No-Bake Cheesecake",
    description:
        "Who doesn't love a dessert that can be made without turning on the oven? This no-bake cheesecake is light and fluffy, thanks to the whipped cream that gets folded into the cream-cheese mixture. Have no fear — it will have the signature creamy, tangy flavor of the classic.",
    foodPrice: 10.0,
    imagePath: "${Assets.dessertsBase}No-Bake-Cheesecake.jpeg",
    foodRate: 4.1,
    calories: RandomData.getRandomCalories,
    numberOfReviewers: RandomData.getRandomReviewers,
  ),
  FoodModel(
    foodType: "Dessert",
    foodName: "Chocolate Cupcakes",
    description:
        "The only chocolate cupcake recipe you'll ever need. We love these for the deep rich chocolate flavor and their moist and springy interiors. It's the perfect cake base for any frosting.",
    foodPrice: 22.0,
    imagePath: "${Assets.dessertsBase}Chocolate-Cupcakes.jpeg",
    foodRate: 4.2,
    calories: RandomData.getRandomCalories,
    numberOfReviewers: RandomData.getRandomReviewers,
  ),
  FoodModel(
    foodType: "Dessert",
    foodName: "Banana Cake",
    description:
        "This banana cake is delectably moist, perfectly sweet and easy to make. Dark brown sugar and sour cream add depth to the batter, and we added melted butter instead of vegetable oil for a flavor boost. Fluffy cream cheese frosting and swirls of dulce de leche will make you go back for seconds. We also upped the ante by using bananas in two ways — fresh bananas are mixed into the cake while maple-candied banana chips create a crunchy topping.",
    foodPrice: 210.0,
    imagePath: "${Assets.dessertsBase}Banana-Cake.jpeg",
    foodRate: 3.9,
    calories: RandomData.getRandomCalories,
    numberOfReviewers: RandomData.getRandomReviewers,
  ),
  FoodModel(
    foodType: "Dessert",
    foodName: "Oatmeal Raisin Cookies",
    description:
        "Do you like chewy cookies? Or do you prefer cakey ones? Our oatmeal-raisin cookies can be both! For a chewy cookie, bake them right away. For a cakey cookie, let the dough rest in the refrigerator for at least 3 hours (or overnight works even better) to allow the oatmeal to hydrate.",
    foodPrice: 99.99,
    imagePath: "${Assets.dessertsBase}Oatmeal-Raisin-Cookies.jpeg",
    foodRate: 4.0,
    calories: RandomData.getRandomCalories,
    numberOfReviewers: RandomData.getRandomReviewers,
  ),
  FoodModel(
    foodType: "Dessert",
    foodName: "Bread Pudding",
    description:
        "Toasting the challah adds flavor, but more importantly, it helps the cubes to soak up and hold onto more of the deliciously rich custard. And if that wasn’t enough, we use not 1 but 2 vanilla beans to amp up the custard — plain old extract just doesn’t do it justice.",
    foodPrice: 202.0,
    imagePath: "${Assets.dessertsBase}Bread-Pudding.jpeg",
    foodRate: 4.7,
    calories: RandomData.getRandomCalories,
    numberOfReviewers: RandomData.getRandomReviewers,
  ),
  FoodModel(
    foodType: "Dessert",
    foodName: "Vanilla Cupcakes",
    description:
        "These vanilla cupcakes taste as delicious as they look (which is often not the case when it comes to vanilla cupcakes!). Mixing flour with cornstarch gives the cake a light and airy texture that stays perfectly moist with a bit of added vegetable oil. Each cupcake is topped with a swirl of creamy, fluffy vanilla buttercream that’s super easy to make.",
    foodPrice: 90.0,
    imagePath: "${Assets.dessertsBase}Vanilla-Cupcakes.jpeg",
    foodRate: 4.5,
    calories: RandomData.getRandomCalories,
    numberOfReviewers: RandomData.getRandomReviewers,
  ),
  FoodModel(
    foodType: "Dessert",
    foodName: "Crepes",
    description:
        "Our classic crepe is versatile enough to go sweet or savory, just omit the vanilla if going the savory route. The rest time here is key; the flour absorbs the milk as it sits giving you a more tender crepe and golden color.",
    foodPrice: 23.0,
    imagePath: "${Assets.dessertsBase}Crepes.jpeg",
    foodRate: 4.8,
    calories: RandomData.getRandomCalories,
    numberOfReviewers: RandomData.getRandomReviewers,
  ),
  FoodModel(
    foodType: "Dessert",
    foodName: "Key Lime Pie",
    description:
        "A Floridian classic, this bright, creamy and tart dessert is so simple to make it will become a regular at your summer get togethers. Key lime juice is the star of this pie, adding a slightly more floral note than regular limes. But not to worry if you can't find fresh Key limes or the bottled juice — you can use standard limes with equally delicious results.",
    foodPrice: 22.0,
    imagePath: "${Assets.dessertsBase}Key_Lime_Pie.jpeg",
    foodRate: 4.0,
    calories: RandomData.getRandomCalories,
    numberOfReviewers: RandomData.getRandomReviewers,
  ),
  FoodModel(
    foodType: "Dessert",
    foodName: "Crispy Chocolate Chip Cookies",
    description:
        "These cookies are inspired by the thin and crispy style made popular by the Long Island bakery Tate's Bake Shop. In our version, we've upped the brown sugar, vanilla and chocolate chips for an even more flavorful and decadent treat.",
    foodPrice: 201.0,
    imagePath: "${Assets.dessertsBase}Crispy-Chocolate-Chip-Cookies.jpeg",
    foodRate: 4.1,
    calories: RandomData.getRandomCalories,
    numberOfReviewers: RandomData.getRandomReviewers,
  ),
  FoodModel(
    foodType: "Dessert",
    foodName: "Coconut Cream Pie",
    description:
        "This old-fashioned pie is filled with rich, creamy custard, then capped with a cloud of toasted meringue and a generous sprinkling of sweet coconut flakes. It tastes as if you pulled it straight from the dessert case of your favorite diner, only better.",
    foodPrice: 220.0,
    imagePath: "${Assets.dessertsBase}Coconut-Cream-Pie.jpeg",
    foodRate: 4.2,
    calories: RandomData.getRandomCalories,
    numberOfReviewers: RandomData.getRandomReviewers,
  ),
  FoodModel(
    foodType: "Dessert",
    foodName: "Pecan Pie",
    description:
        "This pie delivers plenty of classic flavors like brown sugar, vanilla and toasted nuts. We found that bourbon made a welcome addition. The alcohol bakes off leaving behind irresistible notes of smoke and caramel. Our all-butter crust perfectly balances the sweetness of the filling.",
    foodPrice: 34.0,
    imagePath: "${Assets.dessertsBase}Pecan-Pie.jpeg",
    foodRate: 4.9,
    calories: RandomData.getRandomCalories,
    numberOfReviewers: RandomData.getRandomReviewers,
  ),
  FoodModel(
    foodType: "Dessert",
    foodName: "Fruitcake",
    description:
        "Fruitcakes have become the punchline of many a holiday joke, but this recipe will give the notorious seasonal gift a whole new reputation. Filled with loads of real dried fruit and nuts along with brandy, warm spices and citrus, this cake tastes like the holidays. The recipe makes two loaves so you can gift one.",
    foodPrice: 229.0,
    imagePath: "${Assets.dessertsBase}Fruitcake.jpeg",
    foodRate: 5.0,
    calories: RandomData.getRandomCalories,
    numberOfReviewers: RandomData.getRandomReviewers,
  ),
];
