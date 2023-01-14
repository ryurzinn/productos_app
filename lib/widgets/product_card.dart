

import 'package:flutter/material.dart';

import '../models/product.dart';


class ProductCard extends StatelessWidget {
  

  final Product product;

  const ProductCard({
   super.key,
   required this.product
   });

  

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        margin: const EdgeInsets.only(top: 30, bottom: 50),
        width: double.infinity,
        height: 400,
        decoration: _cardBorders(),
        child: Stack(
          alignment: Alignment.bottomLeft,
          children: [

          _BackgroundImg(product.picture),

         _ProductDetails(title: product.name, subtitle: product.id!,),

         Positioned(
          top: 0,
          right: 0,
          child: _PriceTag(price: product.price,)
          ),


          if(product.available)
          Positioned(
          top: 0,
          left: 0,
          child: _NotAvaible()
          ),
        ]),
        
      
      ),
    );
  }

  BoxDecoration _cardBorders() => BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(25,),
    boxShadow: const [ 
      BoxShadow(
      color: Colors.black12,
      offset: Offset(0,07),
      blurRadius: 10,
    )
    ]
  );
}

class _NotAvaible extends StatelessWidget {
 

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 70,
      decoration: BoxDecoration(
        color: Colors.yellow[100],
        borderRadius: const BorderRadius.only(topLeft: Radius.circular(25), bottomRight: Radius.circular(25),),
      ),
      child: const FittedBox(
        fit: BoxFit.contain,
        child: Padding(padding: EdgeInsets.symmetric(horizontal: 10),
        child: Text(
          'No disponible',
          style: TextStyle(color: Colors.white, fontSize: 20),
          
          ),
          
          ),
      ),
    );
  }
}

class _PriceTag extends StatelessWidget {
  
  final double price;

  const _PriceTag({required this.price});

  @override
  Widget build(BuildContext context) {
    return Container(
     width: 100,
     height: 70,
     alignment: Alignment.center,
     decoration: const BoxDecoration(
      color: Colors.indigo,
      borderRadius: BorderRadius.only(topRight: Radius.circular(25), topLeft: Radius.circular(25),),
     ),
     child: FittedBox(
      fit: BoxFit.contain,
       child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Text(
           '\$$price', 
         style: const TextStyle(color: Colors.white, fontSize: 20),)
         ),
     ),
    );
  }
}

class _ProductDetails extends StatelessWidget {

    final String title;
    final String subtitle;

  const _ProductDetails({required this.title, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Padding(
        padding: const EdgeInsets.only(right: 50),
        child: Container(
        width: double.infinity,
        height: 70,
        decoration: _buildBoxDecoration(),
        child: Column(
          crossAxisAlignment:CrossAxisAlignment.start ,
          children: [
            Text(
            title,
             style: const TextStyle(fontSize: 20,color: Colors.white, fontWeight: FontWeight.bold,),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            ),

             Text(
             subtitle,
             style: const TextStyle(fontSize: 15,color: Colors.white,),
           
            ),
          ],
        ),
        ),
      ),
    );
  }

  BoxDecoration _buildBoxDecoration() => const BoxDecoration(
    color: Colors.indigo,
    borderRadius: BorderRadius.only(bottomLeft: Radius.circular(25), topRight: Radius.circular(25))

  );
}

class _BackgroundImg extends StatelessWidget {
  
   final String? url;

   const _BackgroundImg( this.url);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(25),
      child:  SizedBox(
        width: double.infinity,
        height: 400,
        child: url == null
              ? const Image(image: AssetImage('assets/no-image.png'),)
              
              :FadeInImage(
          
          placeholder: const AssetImage('assets/jar-loading.gif'),
          image: NetworkImage(url!),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}