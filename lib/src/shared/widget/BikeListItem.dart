import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BikeListItem extends StatelessWidget {
  final String thirdTitle;
  final String subTitle;
  final String tag;
  final double elevation;
  final AssetImage assetImage;
  final void Function() onTap;

  const BikeListItem(
      {Key key,
      @required this.thirdTitle,
      @required this.subTitle,
      @required this.assetImage,
      @required this.tag,
      @required this.elevation,
      @required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: elevation,
      child: InkWell(
        borderRadius: BorderRadius.circular(10.0),
        onTap: onTap,
        child: Row(
          children: <Widget>[
            _buildThumbnail(assetImage),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(16.0),
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Expanded(
                          child: Text(
                            thirdTitle,
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 14.0),
                            softWrap: true,
                          ),
                        ),
                        _buildTag(context, tag),
                      ],
                    ),
                    const SizedBox(
                      height: 5.0,
                    ),
                    Text.rich(
                      TextSpan(children: [TextSpan(text: subTitle)]),
                      style: TextStyle(color: Colors.grey.shade700),
                    ),
                    const SizedBox(
                      height: 5.0,
                    ),
                    Row(
                      children: <Widget>[
                        Text('Estrellas'),
                        const SizedBox(
                          width: 10.0,
                        ),
                        Icon(
                          Icons.star,
                          color: Colors.yellow,
                        ),
                        Icon(
                          Icons.star,
                          color: Colors.yellow,
                        ),
                        Icon(
                          Icons.star,
                          color: Colors.yellow,
                        ),
                        Icon(
                          Icons.star,
                          color: Colors.yellow,
                        ),
                        Icon(
                          Icons.star,
                          color: Colors.yellow,
                        ),
                      ],
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

Container _buildThumbnail(imagen) {
  return Container(
      height: 120,
      width: 120,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(10.0),
            topLeft: Radius.circular(10.0),
          ),
          image: DecorationImage(image: imagen, fit: BoxFit.cover)));
}

Container _buildTag(BuildContext context, text) {
  return Container(
    padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 8.0),
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.0),
        color: Theme.of(context).primaryColor),
    child: Text(
      text,
      style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
    ),
  );
}
