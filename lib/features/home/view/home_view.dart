import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pepperfry/features/auth/view/login_view_button.dart';

class HomeView extends ConsumerWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        // backgroundColor: Colors.white,
        automaticallyImplyLeading: true,
      ),
      drawer: SafeArea(
        bottom: false,
        child: Row(
          children: [
            Expanded(
              flex: 6,
              child: Container(
                color: Colors.white,
                child: Column(
                  children: [
                    SizedBox(
                      height: 65,
                      child: Row(
                        children: [
                          // SizedBox(width: 8),
                          Expanded(
                            flex: 4,
                            child: LoginViewButton(
                                buttonStyle: OutlinedButton.styleFrom(
                                  // padding: const EdgeInsets.symmetric(
                                  //     vertical: 16, horizontal: 12),
                                  // backgroundColor: Colors.white,
                                  shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.zero,
                                    side: BorderSide(style: BorderStyle.none),
                                  ),
                                ),
                                child: Row(
                                  children: [
                                    const Icon(
                                      Icons.wallet_giftcard_rounded,
                                      color: Colors.black,
                                    ),
                                    const SizedBox(
                                      width: 12,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        const Text(
                                          "Register Now and Get -->",
                                          style: TextStyle(
                                              fontSize: 11.5,
                                              color: Colors.black87,
                                              fontWeight: FontWeight.w400),
                                        ),
                                        const SizedBox(height: 3),
                                        Text(
                                          "5001 Credits",
                                          style: TextStyle(
                                              fontSize: 12,
                                              color: Colors.amber.shade900,
                                              fontWeight: FontWeight.w400),
                                        ),
                                      ],
                                    )
                                  ],
                                )),
                          ),
                          Expanded(
                            flex: 1,
                            child: ActionChip(
                              backgroundColor: Colors.amber.shade900,
                              // padding: const EdgeInsets.symmetric(
                              //     horizontal: 14, vertical: 13.5),
                              shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.zero),
                              onPressed: () {},
                              label: const Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.home_outlined,
                                    color: Colors.white,
                                  ),
                                  Text(
                                    'Home',
                                    style: TextStyle(
                                        fontSize: 10, color: Colors.white),
                                    maxLines: 1,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    OutlinedButton(
                      style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                              vertical: 19, horizontal: 12)),
                      onPressed: () {},
                      child: const Row(
                        children: [
                          Icon(
                            Icons.move_up_rounded,
                            color: Colors.black,
                          ),
                          SizedBox(width: 12),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Browse All Categories',
                                style: TextStyle(
                                    fontSize: 11.5, color: Colors.black),
                              ),
                              SizedBox(height: 3),
                              Text(
                                "Furniture, Mattresses, Decor, Lighting and More",
                                style: TextStyle(
                                    fontSize: 8,
                                    overflow: TextOverflow.fade,
                                    color: Colors.black54),
                              ),
                            ],
                          ),
                          SizedBox(width: 82),
                          Icon(
                            Icons.arrow_forward_ios_rounded,
                            size: 15,
                            color: Colors.black,
                          ),
                        ],
                      ),
                    ),
                    ExpansionTile(
                      backgroundColor: Colors.grey.shade200,
                      expandedCrossAxisAlignment: CrossAxisAlignment.start,
                      iconColor: Colors.black,
                      collapsedIconColor: Colors.black,
                      collapsedTextColor: Colors.black,
                      textColor: Colors.black,
                      expandedAlignment: Alignment.centerLeft,
                      childrenPadding: const EdgeInsets.only(left: 8),
                      title: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.handshake_rounded,
                            color: Colors.black,
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          Text(
                            'Partner with us',
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 11.5,
                            ),
                          ),
                        ],
                      ),
                      children: [
                        ActionChip(
                          pressElevation: 0,
                          backgroundColor: Colors.grey.shade200,
                          padding: EdgeInsets.zero,
                          materialTapTargetSize:
                              MaterialTapTargetSize.shrinkWrap,
                          labelStyle: const TextStyle(
                              fontWeight: FontWeight.w400, fontSize: 11.5),
                          label: const Text(
                            'Sell on Pepperfry',
                          ),
                          onPressed: () {},
                        ),
                        ActionChip(
                          pressElevation: 0,
                          backgroundColor: Colors.grey.shade200,
                          padding: EdgeInsets.zero,
                          materialTapTargetSize:
                              MaterialTapTargetSize.shrinkWrap,
                          labelStyle: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w400,
                              fontSize: 11.5),
                          label: const Text(
                            'Become a Franchisee',
                          ),
                          onPressed: () {},
                        ),
                        ActionChip(
                          pressElevation: 0,
                          backgroundColor: Colors.grey.shade200,
                          padding: EdgeInsets.zero,
                          materialTapTargetSize:
                              MaterialTapTargetSize.shrinkWrap,
                          labelStyle: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w400,
                              fontSize: 11.5),
                          label: const Text(
                            'Become a Channel Partner',
                          ),
                          onPressed: () {},
                        ),
                        ActionChip(
                          pressElevation: 0,
                          backgroundColor: Colors.grey.shade200,
                          padding: EdgeInsets.zero,
                          materialTapTargetSize:
                              MaterialTapTargetSize.shrinkWrap,
                          labelStyle: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w400,
                              fontSize: 11.5),
                          label: const Text(
                            'Become our Pep Home',
                          ),
                          onPressed: () {},
                        ),
                      ],
                    ),
                    TextButton(
                      style: TextButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                            vertical: 19, horizontal: 12),
                        shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.zero),
                      ),
                      onPressed: () {},
                      child: const Row(
                        children: [
                          Icon(
                            Icons.location_pin,
                            color: Colors.black,
                          ),
                          SizedBox(
                            width: 12,
                          ),
                          Text(
                            'Visit our Nearest Studio',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 11.5,
                                fontWeight: FontWeight.w400),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(
                height: double.infinity,
                color: Colors.black12.withAlpha(35),
                alignment: Alignment.topCenter,
                child: IconButton(
                  icon: const Icon(
                    Icons.clear_rounded,
                    color: Colors.white,
                  ),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ),
            )
          ],
        ),
      ),
      body: Navigator(
        initialRoute: '/categoryScreen',
        //TODO
        //Add default page not found
        onGenerateRoute: (settings) {
          if (settings.name == '/categoryScreen') {
            return MaterialPageRoute(
              builder: (context) => const CategoryScreen(),
            );
          } else if (settings.name == '/subCategoryScreen') {
            return MaterialPageRoute(
              builder: (context) => const SubCategoryScreen(),
            );
          }
        },
      ),
    );
  }
}

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text("Category Screen"),
          const Text("More soon"),
          FilledButton(
            onPressed: () => Navigator.pushNamed(context, '/subCategoryScreen'),
            child: const Text('sub category scrren'),
          ),
        ],
      ),
    );
  }
}

class SubCategoryScreen extends StatelessWidget {
  const SubCategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text("sub Category Screen"),
          const Text("More soon"),
          FilledButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('pop to category screen'),
          ),
        ],
      ),
    );
  }
}
