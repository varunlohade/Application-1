import 'package:News_App/views/article_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:News_App/components/gradient.dart';
import 'package:share/share.dart';

//This is the news tile to be displayed
class Tile extends StatefulWidget {
  final String img;
  final String head;
  final String des;

  Tile({this.img, this.head, this.des});

  @override
  _TileState createState() => _TileState();
}

_onShare(BuildContext context, String url) async {
  final RenderBox box = context.findRenderObject();
  await Share.share(url,
      subject: 'Invofinity',
      sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size);
}

class _TileState extends State<Tile> {
  final bgColor = const Color(0xFFffffff);
  final cardColor = const Color(0xFFf8f8f8);
  final txtColor = const Color(0xFF171717);
  final border = Colors.grey[300];
  final border1 = Colors.grey[400];

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ArticleView(
                      blogUrl: widget.des,
                    )));
      },
      child: Container(
        height: 100.0,
        width: MediaQuery.of(context).size.width,
        margin: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          color: bgColor,
          border: Border.all(color: border, width: 1.5),
          //boxShadow: [
          /*BoxShadow(
                  color: txtColor.withOpacity(0.25),
                  offset: Offset(0, 1),
                  blurRadius: 0.5),
            ]*/
        ),
        child: Padding(
          padding: EdgeInsets.all(5.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              /*Stack(children: [
                Positioned(
                  left: 30.0,
                  top: 200.0,
                  child: Container(
                    decoration: BoxDecoration(
                      color: bgColor,
                      image: DecorationImage(
                          image: NetworkImage(
                            widget.img,
                          ),
                          fit: BoxFit.cover),
                    ),
                  ),
                ),
              ]),*/
              Container(
                width: 90.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.0),
                  color: bgColor,
                  image: DecorationImage(
                      image: NetworkImage(
                        widget.img,
                      ),
                      fit: BoxFit.cover),
                ),
              ),
              SizedBox(
                width: 15.0,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    height: 50,
                    width: MediaQuery.of(context).size.width - 45 - 70 - 8 - 14,
                    child: Text(
                      widget.head,
                      maxLines: 3,
                      style: TextStyle(
                        fontFamily: 'PoppinsSemiBold',
                        fontWeight: FontWeight.bold,
                        fontSize: 14.0,
                        color: txtColor,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 16.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 30,
                        child: Text('Source',
                            style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 10,
                                color: border1)),
                      ),
                      SizedBox(width: MediaQuery.of(context).size.width - 190),
                      GestureDetector(
                        onTap: () => _onShare(context, widget.des),
                        child: Container(
                          child: Icon(
                            Feather.share_2,
                            size: 15,
                            color: border1,
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
              /*SizedBox(
                height: 12.0,
              ),
              Text(
                widget.des,
                maxLines: 2,
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 12,
                  color: txtColor,
                ),
              ),*/
            ],
          ),
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class Save extends StatefulWidget {
  bool isPlaying;
  @override
  _SaveState createState() => _SaveState();
  Save({Key key, this.isPlaying}) : super(key: key);
}

class _SaveState extends State<Save> with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  var articles = [];
  bool isPlaying = false;
  int index = 0;

  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 300));
  }

  @override
  void dispose() {
    super.dispose();
    _animationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        child: Container(
          child: RadiantGradientMask(
              child: Icon(
            isPlaying ? FontAwesome.bookmark : FontAwesome.bookmark_o,
            size: 21,
          )),
        ),
        onTap: () => {
              _handleOnPressed(),
            });
  }

  void _handleOnPressed() {
    setState(() {
      isPlaying = !isPlaying;
      isPlaying
          ? _animationController.forward()
          : _animationController.reverse();
    });
  }
}

class Saved extends StatefulWidget {
  @override
  _SavedState createState() => _SavedState();
}

class _SavedState extends State<Saved> {
  final bgColor = const Color(0xFFffffff);
  final txtColor = const Color(0xFF171717);
  final up = const Color(0xFFff416c);
  final down = const Color(0xFFff4b2b);
  List<Tile> savedArticles = [];
  String image;
  String heading;
  String description;

  void setTodo(/*String img, String head*/ String des) {
    //image = img;
    //heading = head;
    description = des;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 14,
          ),
          Text(
            'Saved',
            style: TextStyle(
                color: txtColor, fontFamily: 'PoppinsBold', fontSize: 18),
          ),
          SizedBox(
            height: 14,
          ),
          Expanded(
              child: ListView.builder(
                  itemCount: savedArticles.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () =>
                          /*Navigator.pushNamed(context, '/information',
                          arguments: {
                            '/link': savedArticles[index].url,
                            '/content': savedArticles[index].content,
                            '/head': savedArticles[index].head,
                            '/img': savedArticles[index].img
                          })*/
                          Tile(
                        //img: image,
                        //head: heading,
                        des: description,
                      ),
                    );
                  }))
        ],
      ),
    );
  }
}
