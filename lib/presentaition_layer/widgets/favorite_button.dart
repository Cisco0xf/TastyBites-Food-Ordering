import 'package:flutter/material.dart';
import 'package:foodapp/common/commons.dart';
import 'package:foodapp/data_layer/data_base/global_demo_data_model.dart';
import 'package:foodapp/statemanagement/favoriter_items/add_to_favorite_provider.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';

typedef AddToFavorite = void Function();

class FavoriteButtonWidget extends StatelessWidget {
  const FavoriteButtonWidget({
    super.key,
    required this.item,
  });

  final FoodModel item;

  @override
  Widget build(BuildContext context) {
    return Consumer<WishListProvider>(
      builder: (context, wishList, child) {
        final bool isExist =
            wishList.favoriteItems.any((ele) => ele.id == item.id);

        final bool isLoading = context.watch<WishListProvider>().isLoading;
        return Container(
          decoration: BoxDecoration(
            border: Border.all(color: const Color(0xFFFF6D28), width: 1),
            color: Colors.black26,
            borderRadius: borderRaduis(7),
          ),
          child: IconButton(
            padding: padding(0),
            onPressed: () async {
              await wishList.addItemToFirestoreWishList(item);
            },
            icon: isLoading
                ? LoadingAnimationWidget.threeArchedCircle(
                    color: Colors.orange,
                    size: 25.0,
                  )
                : isExist
                    ? const Icon(Icons.favorite,
                        color: Color(0xFFFF6D28), size: 30)
                    : const Icon(Icons.favorite_outline,
                        color: Color(0xFFFF6D28), size: 30),
          ),
        );
      },
    );
  }
}
