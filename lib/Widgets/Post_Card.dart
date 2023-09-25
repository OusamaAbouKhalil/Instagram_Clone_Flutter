import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/Resources/fire_Store.dart';
import 'package:instagram_clone/Screens/comments_screen.dart';
import 'package:instagram_clone/Widgets/like_Animations.dart';
import 'package:instagram_clone/utils/Colors.dart';
import 'package:instagram_clone/utils/Utils.dart';
import 'package:intl/intl.dart';

class PostCard extends StatefulWidget {
  // ignore: prefer_typing_uninitialized_variables
  final post;

  const PostCard({Key? key, required this.post}) : super(key: key);

  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  bool isAnimating = false;
  int commentLen = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchCommentLen();
  }

  fetchCommentLen() async {
    try {
      QuerySnapshot snap = await FirebaseFirestore.instance
          .collection('posts')
          .doc(widget.post['postId'])
          .collection('comments')
          .get();
      commentLen = snap.docs.length;
    } catch (err) {
      showSnackBar(
        context,
        err.toString(),
      );
    }
    setState(() {});
  }

  deletePost(String postId) async {
    try {
      await FireStoreMethods().deletePost(postId);
    } catch (err) {
      showSnackBar(
        context,
        err.toString(),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        color: mobileBackgroundColor,
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 14)
                  .copyWith(right: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        //Header Card
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            image: NetworkImage(widget.post['profImage']),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        widget.post['username'],
                        style: const TextStyle(
                            color: primaryColor,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  IconButton(
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (context) => Dialog(
                              child: ListView(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 12, horizontal: 16),
                                  shrinkWrap: true,
                                  children: [
                                    'Delete Post',
                                  ]
                                      .map(
                                        (e) => InkWell(
                                          onTap: () {
                                            showSnackBar(
                                                context,
                                                widget.post['postId']
                                                    .toString());
                                          },
                                          child: Container(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 12),
                                            child: Text(
                                              e,
                                              style: const TextStyle(
                                                  color: primaryColor,
                                                  fontSize: 16),
                                            ),
                                          ),
                                        ),
                                      )
                                      .toList())));
                    },
                    icon: const Icon(Icons.more_horiz),
                    color: primaryColor,
                  )
                ],
              ),
            ),

            // IMAGE SECTION OF THE POST
            GestureDetector(
              onDoubleTap: () {
                FireStoreMethods().likePost(
                  widget.post['postId'].toString(),
                  FirebaseAuth.instance.currentUser!.uid,
                  widget.post['likes'],
                );
                setState(() {
                  isAnimating = true;
                });
              },
              child: Stack(
                alignment: Alignment.center,
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.35,
                    width: double.infinity,
                    child: Image.network(
                      widget.post['postUrl'].toString(),
                      fit: BoxFit.cover,
                    ),
                  ),
                  AnimatedOpacity(
                    duration: const Duration(milliseconds: 200),
                    opacity: isAnimating ? 1 : 0,
                    child: LikeAnimation(
                      isAnimating: isAnimating,
                      duration: const Duration(
                        milliseconds: 400,
                      ),
                      onEnd: () {
                        setState(() {
                          isAnimating = false;
                        });
                      },
                      child: const Icon(
                        Icons.favorite,
                        color: Colors.white,
                        size: 100,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Row(
              children: [
                IconButton(
                    onPressed: () {
                      FireStoreMethods().likePost(
                        widget.post['postId'].toString(),
                        FirebaseAuth.instance.currentUser!.uid,
                        widget.post['likes'],
                      );
                    },
                    icon: widget.post['likes']
                            .contains(FirebaseAuth.instance.currentUser!.uid)
                        ? const Icon(
                            Icons.favorite,
                            color: Colors.red,
                          )
                        : const Icon(Icons.favorite_border),
                    color: primaryColor),
                IconButton(
                    //comments
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => Comments(
                              postIds: widget.post['postId'].toString())));
                    },
                    icon: const Icon(Icons.comment_outlined)),
                IconButton(
                    //share
                    onPressed: () {},
                    icon: const Icon(Icons.send_outlined)),
                Expanded(
                    //bookmark
                    child: Align(
                  alignment: Alignment.centerRight,
                  child: IconButton(
                      onPressed: () {
                        // showSnackBar(context, postIds); testing this part of code
                      },
                      icon: const Icon(Icons.bookmark_border)),
                ))
              ],
            ),

            //Like, Discrption and number of comments

            Container(
              padding: const EdgeInsets.symmetric(horizontal: 14),
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 12)
                  .copyWith(right: 10),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  DefaultTextStyle(
                    style: Theme.of(context)
                        .textTheme
                        .bodyText2!
                        .copyWith(fontWeight: FontWeight.w800),
                    child: Text(
                      '${widget.post['likes'].length} Likes',
                      style: Theme.of(context)
                          .textTheme
                          .bodyText2!
                          .copyWith(color: primaryColor),
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.only(top: 14),
                    child: RichText(
                      text: TextSpan(
                        style: const TextStyle(
                          color: primaryColor,
                        ),
                        children: [
                          TextSpan(
                            text: widget.post['username'] + ' ',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          TextSpan(
                            text: widget.post['description'],
                          ),
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {},
                    child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.only(top: 14),
                        child: Text(
                          'View all ${commentLen} comments',
                          style: Theme.of(context)
                              .textTheme
                              .bodyText2!
                              .copyWith(color: primaryColor.withOpacity(0.5)),
                        )),
                  ),
                  Container(
                      padding: const EdgeInsets.symmetric(vertical: 4),
                      child: Text(
                        DateFormat.yMMMd()
                            .format(widget.post['datePublished'].toDate()),
                        style: Theme.of(context).textTheme.bodyText2!.copyWith(
                            color: primaryColor.withOpacity(0.5), fontSize: 16),
                      )),
                ],
              ),
            ),
          ],
        ));
  }
}
