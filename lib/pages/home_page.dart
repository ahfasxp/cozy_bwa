import 'package:cozy_bwa/models/city.dart';
import 'package:cozy_bwa/models/space.dart';
import 'package:cozy_bwa/models/tips.dart';
import 'package:cozy_bwa/pages/card_page.dart';
import 'package:cozy_bwa/pages/email_page.dart';
import 'package:cozy_bwa/pages/favorite_page.dart';
import 'package:cozy_bwa/providers/space_provider.dart';
import 'package:cozy_bwa/theme.dart';
import 'package:cozy_bwa/widgets/bottom_navbar_item.dart';
import 'package:cozy_bwa/widgets/city_card.dart';
import 'package:cozy_bwa/widgets/space_card.dart';
import 'package:cozy_bwa/widgets/tips_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedIndex = 0;

  List<Widget> _listWidget = [
    ExplorePage(),
    EmailPage(),
    CardPage(),
    FavoritePage()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _listWidget[selectedIndex],

      /// NOTE: FLOATING ACTION BUTTON
      floatingActionButton: Container(
        width: MediaQuery.of(context).size.width,
        height: 65,
        margin: EdgeInsets.symmetric(
          horizontal: edge,
        ),
        decoration: BoxDecoration(
          color: Color(0xffF6F7F8),
          borderRadius: BorderRadius.circular(23),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            navItem(
              index: 0,
              imageUrl: 'assets/images/icon_home.png',
              imageSelected: 'assets/images/icon_home_selected.png',
            ),
            navItem(
              index: 1,
              imageUrl: 'assets/images/icon_email.png',
              imageSelected: 'assets/images/icon_email_selected.png',
            ),
            navItem(
              index: 2,
              imageUrl: 'assets/images/icon_card.png',
              imageSelected: 'assets/images/icon_card_selected.png',
            ),
            navItem(
              index: 3,
              imageUrl: 'assets/images/icon_love.png',
              imageSelected: 'assets/images/icon_love_selected.png',
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Widget navItem(
      {required int index,
      required String imageUrl,
      required String imageSelected}) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedIndex = index;
        });
      },
      child: BottomNavbarItem(
        imageUrl: selectedIndex == index ? imageSelected : imageUrl,
        isActive: selectedIndex == index ? true : false,
      ),
    );
  }
}

class ExplorePage extends StatelessWidget {
  const ExplorePage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var spaceProvider = Provider.of<SpaceProvider>(context);

    return SafeArea(
      child: ListView(
        padding: EdgeInsets.only(bottom: 145),
        children: [
          /// NOTE: TITLE/HEADER
          Padding(
            padding: EdgeInsets.only(left: edge, top: edge),
            child: Text(
              'Explore Now',
              style: blackTextStyle.copyWith(fontSize: 24),
            ),
          ),
          SizedBox(
            height: 2,
          ),
          Padding(
            padding: EdgeInsets.only(left: edge),
            child: Text(
              'Mencari kosan yang cozy',
              style: greyTextStyle.copyWith(fontSize: 16),
            ),
          ),
          SizedBox(
            height: 30,
          ),

          /// NOTE: POPULAR CITIES
          Padding(
            padding: EdgeInsets.only(left: edge),
            child: Text(
              'Popular Cities',
              style: regularTextStyle.copyWith(
                fontSize: 16,
              ),
            ),
          ),
          SizedBox(
            height: 16,
          ),
          Container(
            height: 150,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                SizedBox(
                  width: 24,
                ),
                CityCard(
                  City(
                    id: 1,
                    name: 'Jakarta',
                    imageUrl: 'assets/images/city1.png',
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                CityCard(
                  City(
                    id: 2,
                    name: 'Bandung',
                    imageUrl: 'assets/images/city2.png',
                    isPopular: true,
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                CityCard(
                  City(
                    id: 3,
                    name: 'Surabaya',
                    imageUrl: 'assets/images/city3.png',
                  ),
                ),
                SizedBox(
                  width: 24,
                ),
                CityCard(
                  City(
                    id: 4,
                    name: 'Palembang',
                    imageUrl: 'assets/images/city4.png',
                  ),
                ),
                SizedBox(
                  width: 24,
                ),
                CityCard(
                  City(
                    id: 5,
                    name: 'Aceh',
                    imageUrl: 'assets/images/city5.png',
                    isPopular: true,
                  ),
                ),
                SizedBox(
                  width: 24,
                ),
                CityCard(
                  City(
                    id: 6,
                    name: 'Bogor',
                    imageUrl: 'assets/images/city6.png',
                  ),
                ),
                SizedBox(
                  width: 24,
                ),
              ],
            ),
          ),
          SizedBox(
            height: 30,
          ),

          /// NOTE: RECOMMENDED SPACE
          Padding(
            padding: EdgeInsets.only(
              left: edge,
            ),
            child: Text(
              'Recommended Space',
              style: regularTextStyle.copyWith(
                fontSize: 16,
              ),
            ),
          ),
          SizedBox(
            height: 16,
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: edge,
            ),
            child: FutureBuilder(
                future: spaceProvider.getRecommendedSpaces(),
                builder: (context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    List<Space> data = snapshot.data;

                    int index = 0;

                    return Column(
                      children: data.map((item) {
                        index++;
                        return Container(
                          margin: EdgeInsets.only(
                            top: index == 1 ? 0 : 30,
                          ),
                          child: SpaceCard(item),
                        );
                      }).toList(),
                    );
                  }
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }),
          ),
          SizedBox(
            height: 30,
          ),

          /// NOTE: TIPS & GUIDANCE
          Padding(
            padding: EdgeInsets.only(
              left: edge,
            ),
            child: Text(
              'Recommended Space',
              style: regularTextStyle.copyWith(
                fontSize: 16,
              ),
            ),
          ),
          SizedBox(
            height: 16,
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: edge,
            ),
            child: Column(
              children: [
                TipsCard(
                  Tips(
                    id: 1,
                    title: 'City Guidelines',
                    imageUrl: 'assets/images/tips1.png',
                    updatedAt: '20 Apr',
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                TipsCard(Tips(
                  id: 2,
                  title: 'Jakarta Fairship',
                  imageUrl: 'assets/images/tips2.png',
                  updatedAt: '11 Dec',
                )),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
