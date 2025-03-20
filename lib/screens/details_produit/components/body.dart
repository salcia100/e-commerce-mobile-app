import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:inscri_ecommerce/screens/details_produit/components/description&review.dart';
import 'package:inscri_ecommerce/screens/details_produit/components/productOptions.dart';
import 'package:inscri_ecommerce/screens/details_produit/components/addToCartButton.dart';
import '../../../model/Product.dart';

class Body extends StatefulWidget {
  final Product product;

  const Body({Key? key, required this.product}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  bool isExpanded = false;
  bool isReviewsExpanded = false;

  final int rating = 5;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          SizedBox(
              height: size.height,
              child: Stack(children: <Widget>[
                Container(
                  margin: EdgeInsets.only(top: size.height * 0.4),
                  //height: 500,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(24),
                        topRight: Radius.circular(24),
                      )),
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
                    child: Column(
                      crossAxisAlignment:
                          CrossAxisAlignment.start, // Aligns text properly
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 20.0, vertical: 10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment
                                .spaceBetween, // Distributes name & price
                            children: [
                              Expanded(
                                child: Text(
                                  widget.product.name,
                                  style: TextStyle(
                                    color: Color(0xFF1D1F22),
                                    fontSize: 18,
                                    fontWeight: FontWeight.w700,
                                  ),
                                  overflow: TextOverflow
                                      .ellipsis, // Adds "..." if name is too long
                                ),
                              ),
                              Text(
                                "\$${widget.product.price.toStringAsFixed(2)}", // Formats price properly
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 26,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: 119,
                          height: 16,
                          clipBehavior: Clip.antiAlias,
                          decoration: BoxDecoration(),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: List.generate(5, (index) {
                              return Icon(
                                Icons.star,
                                size: 16.0,
                                color: index < rating
                                    ? Colors.yellow
                                    : Colors.grey,
                              );
                            }),
                          ),
                        ),
                        ProductOptions(),
                        DescriptionReview(product: widget.product),
                        AddToCartButton(product: widget.product),
                      ],
                    ),
                  ),
                ),
                Stack(
                  children: [
                    // Image
                    Container(
                      width: 700, // Keep your image width
                      height: 365, // Keep your image height
                      child: CachedNetworkImage(
                        imageUrl: widget.product.image,
                        fit: BoxFit.contain,
                        placeholder: (context, url) =>
                            CircularProgressIndicator(), // Placeholder while loading
                        errorWidget: (context, url, error) => Icon(
                            Icons.image_not_supported,
                            size: 50), // Ensures the whole image is visible
                      ),
                    ),

                    // Like Button Positioned at Top Left
                    Positioned(
                      top: 10, // Adjust this value for positioning
                      right: 10, // Adjust this value for positioning
                      child: Container(
                        width: 32,
                        height: 32,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(25.5),
                          boxShadow: [
                            BoxShadow(
                              color: Color(0x3F000000),
                              blurRadius: 3,
                              offset: Offset(0, 1),
                              spreadRadius: 0,
                            ),
                          ],
                        ),
                        child: Icon(Icons.favorite_border,
                            color: Colors.red), // Like Icon
                      ),
                    ),
                  ],
                ),
              ]))
        ],
      ),
    );
  }
}
