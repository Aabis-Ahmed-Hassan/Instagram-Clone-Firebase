import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:instagram_clone_firebase/utils/colors.dart';
import 'package:instagram_clone_firebase/view/bottom_nav_bar_screens/profile_screen.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final _searchController = TextEditingController();

  bool isSearchingUser = false;

  @override
  void dipose() {
    super.dispose();
    _searchController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height * 1;
    double width = MediaQuery.of(context).size.width * 1;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mobileBackgroundColor,
        title: TextFormField(
          controller: _searchController,
          decoration: InputDecoration(
            hintText: 'Search',
          ),
          onFieldSubmitted: (_) {
            setState(() {
              isSearchingUser = true;
            });
          },
        ),
      ),
      body: Padding(
        padding: EdgeInsets.only(
          left: width * 0.03,
          right: width * 0.03,
          top: height * 0.02,
        ),
        child: isSearchingUser
            ? FutureBuilder(
                future: FirebaseFirestore.instance
                    .collection('Users')
                    .where('username',
                        isGreaterThanOrEqualTo: _searchController.text)
                    .get(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Center(child: CircularProgressIndicator());
                  } else {
                    return ListView.builder(
                      itemCount: (snapshot.data as dynamic).docs.length,
                      itemBuilder: (context, index) {
                        if (snapshot.data!.docs[index]['username']
                            .toString()
                            .contains(_searchController.text)) {
                          return ListTile(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ProfileScreen(
                                    uid: snapshot.data!.docs[index]['uid'],
                                  ),
                                ),
                              );
                            },
                            leading: CircleAvatar(
                              backgroundImage: NetworkImage(
                                (snapshot.data as dynamic).docs[index]
                                    ['imageUrl'],
                              ),
                            ),
                            title: Text((snapshot.data as dynamic).docs[index]
                                ['username']),
                          );
                        }
                      },
                    );
                  }
                },
              )
            : FutureBuilder(
                future: FirebaseFirestore.instance.collection('Posts').get(),
                builder: (context,
                    AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                        snapshot) {
                  if (!snapshot.hasData) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    return GridView.custom(
                      gridDelegate: SliverQuiltedGridDelegate(
                        crossAxisCount: 3,
                        mainAxisSpacing: width * 0.02,
                        crossAxisSpacing: width * 0.02,
                        repeatPattern: QuiltedGridRepeatPattern.inverted,
                        pattern: [
                          QuiltedGridTile(2, 2),
                          QuiltedGridTile(1, 1),
                          QuiltedGridTile(1, 1),
                        ],
                      ),
                      childrenDelegate: SliverChildBuilderDelegate(
                        (context, index) => Image(
                          fit: BoxFit.cover,
                          image: NetworkImage(
                            snapshot.data!.docs[index]['postImageUrl'],
                          ),
                        ),
                        childCount: snapshot.data!.docs.length,
                      ),
                    );
                  }
                },
              ),
      ),
    );
  }
}
//
//
// return MasonryGridView.count(
// itemCount: snapshot.data!.docs.length,
// crossAxisCount: 2,
// itemBuilder: (context, index) {
// return Image(
// height: height * 0.175,
// image: NetworkImage(
// snapshot.data!.docs[index]['postImageUrl'],
// ),
// );
// },
// );
