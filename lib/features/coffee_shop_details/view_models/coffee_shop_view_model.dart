import 'dart:developer';

import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:coffee_app/features/buying/models/order_details_model.dart';
import 'package:coffee_app/features/coffee_shop_details/service/shop_details_service.dart';
import 'package:coffee_app/features/home/models/offer_model.dart';
import 'package:coffee_app/features/home/models/shop_model.dart';

import '../../home/models/coffee_model.dart';
import '../models/review_model.dart';

part 'coffee_shop_view_model.g.dart';

class ShopStateModel {
  final bool isLoading;
  final List<CoffeeModel>? coffeeModel;
  final ShopModel? shopModel;
  final List<BasketProductModel> selectedCoffeeIds;
  final double totalPrice;
  final List<ReviewModel>? sortedReview;
  final List<ReviewModel>? reviews;
  final List<OfferModel>? offers;
  final List<OfferModel>? selectedOffers;
  final double? selectedFilter;
  final List<double>? averageRating;
  final bool isFavorite;

  ShopStateModel({
    required this.isLoading,
    this.coffeeModel,
    this.shopModel,
    required this.selectedCoffeeIds,
    required this.totalPrice,
    this.sortedReview,
    this.reviews,
    this.offers,
    this.selectedOffers,
    this.selectedFilter,
    this.averageRating,
    required this.isFavorite,
  });

  factory ShopStateModel.initial() {
    return ShopStateModel(
        isFavorite: false,
        isLoading: false,
        selectedCoffeeIds: [],
        totalPrice: 0.0);
  }

  ShopStateModel copyWith({
    bool? isLoading,
    List<CoffeeModel>? coffeeModel,
    ShopModel? shopModel,
    List<BasketProductModel>? selectedCoffeeIds,
    double? totalPrice,
    List<ReviewModel>? reviews,
    List<ReviewModel>? sortedReview,
    double? selectedFilter,
    List<OfferModel>? offers,
    List<OfferModel>? selectedOffers,
    final List<double>? averageRating,
    bool? isFavorite,
  }) {
    return ShopStateModel(
      isLoading: isLoading ?? this.isLoading,
      coffeeModel: coffeeModel ?? this.coffeeModel,
      shopModel: shopModel ?? this.shopModel,
      selectedCoffeeIds: selectedCoffeeIds ?? this.selectedCoffeeIds,
      totalPrice: totalPrice ?? this.totalPrice,
      reviews: reviews ?? this.reviews,
      sortedReview: sortedReview ?? this.sortedReview,
      selectedFilter: selectedFilter ?? this.selectedFilter,
      offers: offers ?? this.offers,
      selectedOffers: selectedOffers ?? this.selectedOffers,
      isFavorite: isFavorite ?? this.isFavorite,
      averageRating: averageRating ?? this.averageRating,
    );
  }
}

@riverpod
class ShopDetailsViewModel extends _$ShopDetailsViewModel {
  @override
  ShopStateModel build() {
    return ShopStateModel.initial();
  }

  Future<void> getBasket(String shopId) async {
    // await ShopDetailsService.addReview();
    final response = await ShopDetailsService.getBasket(shopId);
    response.fold((l) => log(l), (r) {
      double totalPrice = 0;
      for (var element in r) {
        totalPrice += element.totalPrice;
      }
      state = state.copyWith(selectedCoffeeIds: r, totalPrice: totalPrice);
    });
  }

  void removeProductID(BasketProductModel orderModel) {
    ShopDetailsService.removeBasket(
        orderModel.productModel.id, orderModel.shopID);
    state = state.copyWith(
        selectedCoffeeIds: [...state.selectedCoffeeIds..remove(orderModel)],
        totalPrice: double.parse(
            (state.totalPrice - orderModel.totalPrice).toStringAsFixed(3)));
  }

  void addProductID(BasketProductModel orderModel) {
    ShopDetailsService.addBasket(orderModel);
    state = state.copyWith(
        selectedCoffeeIds: [...state.selectedCoffeeIds, orderModel],
        totalPrice: (state.totalPrice + orderModel.totalPrice));
  }

  void clearValues() {
    state = ShopStateModel.initial();
  }

  void addShopFavoriteList() {
    if (state.isFavorite) {
      ShopDetailsService.removeFavoriteList(state.shopModel!);
      state = state.copyWith(isFavorite: false);
      return;
    }
    ShopDetailsService.addFavoriteList(state.shopModel!);
    state = state.copyWith(isFavorite: true);
  }

  void getAverageRating() {
    final List<double> ratingCounts = [0, 0, 0, 0, 0];
    for (var rate in state.shopModel!.allRating) {
      if (rate >= 0.5 && rate <= 1) {
        ratingCounts[0] += 1;
      }
      if (rate >= 1.5 && rate <= 2) {
        ratingCounts[1] += 1;
      }
      if (rate >= 2.5 && rate <= 3) {
        ratingCounts[2] += 1;
      }
      if (rate >= 3.5 && rate <= 4) {
        ratingCounts[3] += 1;
      }
      if (rate >= 4.4 && rate <= 5) {
        ratingCounts[4] += 1;
      }
    }
    ratingCounts[0] = ratingCounts[0] / state.shopModel!.rating;
    ratingCounts[1] = ratingCounts[1] / state.shopModel!.rating;
    ratingCounts[2] = ratingCounts[2] / state.shopModel!.rating;
    ratingCounts[3] = ratingCounts[3] / state.shopModel!.rating;
    ratingCounts[4] = ratingCounts[4] / state.shopModel!.rating;
    state = state.copyWith(averageRating: ratingCounts);
  }

  Future<void> getFavoriteStatus(String shopId) async {
    final response = await ShopDetailsService.getFavoriteStatus(shopId);
    state = state.copyWith(isFavorite: response);
  }

  Future<void> getAllData(String shopId, {bool loading = true}) async {
    state = state.copyWith(isLoading: loading);
    // log("shop loading");
    await getShopDetails(shopId);
    // log("shop loaded");
    getBasket(shopId);
    // log("basket loaded");
    await getFavoriteStatus(shopId);
    // log("favorite status loaded");
    getOffers(shopId);
    // log("offers loaded");
    getReviews(shopId);
    // log("reviews loaded");
    state = state.copyWith(isLoading: false);
  }

  void claimOffer(OfferModel offer) {
    if (state.selectedOffers == null ||
        !state.selectedOffers!.contains(offer)) {
      state = state
          .copyWith(selectedOffers: [...state.selectedOffers ?? [], offer]);
    } else {
      state = state.copyWith(
        selectedOffers:
            state.selectedOffers!.where((element) => element != offer).toList(),
      );
    }
  }

  Future<void> getOffers(String shopid) async {
    final response = await ShopDetailsService.getOffers(shopid);
    response.fold((l) => log(l), (r) => state = state.copyWith(offers: r));
  }

  Future<void> getReviews(String shopid) async {
    final response = await ShopDetailsService.getReviews(shopid);
    response.fold((l) => log(l),
        (r) => state = state.copyWith(reviews: r, sortedReview: r));
    getAverageRating();
  }

  void reviewSort(double rating) {
    List<ReviewModel> sortedReview = [];
    final review = state.reviews;
    for (var element in review!) {
      if (element.rating >= rating && element.rating < rating + 1) {
        log(element.rating.toString());
        sortedReview.add(element);
      }
    }
    state = state.copyWith(sortedReview: sortedReview, selectedFilter: rating);
  }

  void clearFilter() {
    state = state.copyWith(sortedReview: state.reviews, selectedFilter: 10);
  }

  Future<void> getShopDetails(String shopId) async {
    final response = await ShopDetailsService.getShopDetails(shopId);
    response.fold((left) {
      log(left);
    }, (right) {
      state = state.copyWith(shopModel: right);
    });
    // log("shop details loading");
    final productResponse = await ShopDetailsService.getProducts(shopId);
    productResponse.fold((left) {
      log(left);
    }, (right) {
      state = state.copyWith(coffeeModel: right);
    });
    // log("shop details loaded");
  }
}
