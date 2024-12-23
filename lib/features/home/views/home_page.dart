import 'package:coffee_app/core/app_colors.dart';
import 'package:coffee_app/core/fonts.dart';
import 'package:coffee_app/core/size.dart';
import 'package:coffee_app/features/home/models/coffee_model.dart';
import 'package:coffee_app/features/home/view_models/home_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

final _titleFont = subtitleFont(fontSize: 17,fontWeight: FontWeight.w700);

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final images = [
    "https://media.istockphoto.com/id/1428594094/photo/empty-coffee-shop-interior-with-wooden-tables-coffee-maker-pastries-and-pendant-lights.jpg?s=612x612&w=0&k=20&c=dMqeYCJDs3BeBP_jv93qHRISDt-54895SPoVc6_oJt4=",
    "https://images.pexels.com/photos/2159065/pexels-photo-2159065.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500",
    "https://www.barniescoffee.com/cdn/shop/articles/bar-1869656_1920.jpg?v=1660683986",
    "https://coffeebusiness.com/wp-content/uploads/2019/08/14tenents-pt2.jpg",
    "https://b.zmtcdn.com/data/collections/e7e6c3774795c754eac6c2bbeb0ba57a_1709896412.png?fit=around|562.5:360&crop=562.5:360;*,*"
  ];

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) => context.read<HomeViewModel>().getPopularCoffee());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final homeViewModel = context.watch<HomeViewModel>();
    return Scaffold(
      appBar: _appBar(),
      body: ListView(
        children: [
          Container(
            width: double.infinity,
            height: 200,
            margin: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: AppColors.secondaryColor(context),
              borderRadius: BorderRadius.circular(15),
              image: const DecorationImage(
                image: AssetImage("assets/banner1.png"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          _homeScreenCategoryText("Nearby Shop"),
          LimitedBox(maxHeight: size.width*0.65,maxWidth: size.width,child: ListView(
            padding: const EdgeInsets.only(left: 5),
            scrollDirection: Axis.horizontal,
            children: List.generate(images.length, (index) => _nearbyShopCard(size,images[index])),
          )),
          _homeScreenCategoryText("Popular Menu"),
          height20,
          Wrap(
            alignment: WrapAlignment.center,
            spacing: 15,
            runSpacing: 10,
            children: List.generate(homeViewModel.popularCoffees.length, (index) => _coffeeCard(size,homeViewModel.popularCoffees[index]),),
          )
          

        ],
      ),
    );
  }

  _coffeeCard(size,CoffeeModel model)
  {
    return Column(
      children: [
        Container(
          width: (size.width / 2) *0.9,
          height: size.width*0.45,
          decoration: BoxDecoration(
            color: AppColors.secondaryColor(context),
            borderRadius: BorderRadius.circular(10),
            image: DecorationImage(
              image: AssetImage(model.imagePath),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 3,vertical: 8.0),
          child: SizedBox(
          width: size.width*0.4,
            child: Column( 
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(model.name,style: _titleFont,maxLines: 2,),
                Text("\$${model.price}",style: const TextStyle(fontSize: 15,color: AppColors.primaryColor))
              ],
            ),
          ),
        )
      ],
    );
  }

  _nearbyShopCard(size,String imageLink)
  {
    return Container(
              width: size.width*0.37,
              height: size.width*0.65,
              margin: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
              ),
              child: Column(
                children: [
                  Container(
                    width: size.width*0.4,
                    height: size.width*0.35,
                    decoration: BoxDecoration(
                      color: AppColors.secondaryColor(context),
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                        image: NetworkImage(imageLink),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: Stack(
                      children: [
                        Positioned(
                          top: 10,
                          left: 10,
                          child: Container(
                            decoration: BoxDecoration(
                              color: AppColors.themeColor(context).withOpacity(0.5),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                            child: const Row(children: [Icon(Icons.star_rate_rounded,color: Colors.orange,),Text("4.8",style: TextStyle(fontSize: 13,color: Colors.white),)],),
                          ),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 3,vertical: 8.0),
                    child: SizedBox(
                    width: size.width*0.4,
                    height: size.width*0.2,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Coffee Shop Cofffeee",style: _titleFont,maxLines: 2),
                          Row(
                            children: [
                              const Icon(Icons.location_on,color: AppColors.primaryColor,size: 17),
                              width5,
                              Text("1.2 km",style: subtitleFont(fontSize: 15),),
                            ],
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            );
  }

  _appBar() {
    return AppBar(
      surfaceTintColor: Theme.of(context).scaffoldBackgroundColor,
      leading: Padding(
        padding: const EdgeInsets.only(left: 10),
        child: CircleAvatar(backgroundColor: AppColors.themeColor(context)),
      ),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Good Morning 🌤️",
            style: subtitleFont(fontSize: 15),
          ),
          const Text(
            "John Doe",
            style: TextStyle(fontSize: 17, fontWeight: FontWeight.w700),
          )
        ],
      ),
      actions: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
              color: AppColors.secondaryColor(context),
              border: Border.all(width: 0.4, color: Colors.grey),
              shape: BoxShape.circle),
          padding: const EdgeInsets.all(9),
          child: Badge(
            largeSize: 10,
            alignment: Alignment.topRight,
            offset: Offset.zero,
            label: const CircleAvatar(
              radius: 1,
              backgroundColor: Colors.transparent,
            ),
            child: Icon(
              CupertinoIcons.bell,
              color: AppColors.themeColor(context),
              size: 30,
            ),
          ),
        )
      ],
    );
  }

  _homeScreenCategoryText(String text)
  {
    return Row(
            children: [
              width20,
              Text(text,style: const TextStyle(fontSize: 19,fontWeight: FontWeight.w600),),
              const Spacer(),
              InkWell(
                onTap: () {},
                child: const Row(
                  children: [
                    Text(
                      "View All",
                      style: TextStyle(
                        color: AppColors.primaryColor,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    width10,
                    Icon(Icons.arrow_forward_ios,
                        size: 15, color: AppColors.primaryColor),
                  ],
                ),
              ),
              width20,
            ],
          );
  }
}