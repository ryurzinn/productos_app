import 'dart:convert';
import 'dart:io';


import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;


import 'package:flutter/cupertino.dart';

import '../models/product.dart';

class ProductsService extends ChangeNotifier{

  final String _baseUrl = 'flutter-varios-6182b-default-rtdb.firebaseio.com';
  final List<Product> products = [];
  late Product selectedProduct;

  final storage = const FlutterSecureStorage();


  File? newPictureFile;

  bool isLoading = true;
  bool isSaving = false;




  ProductsService() {
    loadProducts();
  }


  Future loadProducts() async {

    isLoading = true;
    notifyListeners();


    final url = Uri.https(_baseUrl, 'products.json', {
      'auth' : await storage.read(key: 'token') ?? ''
    });
    final resp = await http.get(url);

    final Map<String, dynamic> productsMap = json.decode(resp.body);

    productsMap.forEach((key, value) {
      final tempProduct = Product.fromMap(value);
      tempProduct.id = key;
      products.add(tempProduct);
    });

    isLoading = false;
    notifyListeners();
    return products;
     

    
  }

  Future saveOrCreateProduct(Product product) async{
  isSaving = true;
  notifyListeners();

  if(product.id ==null){
    //Es necesario crear
    await createProduct(product);
  }else{
    //actualizar
   await  updateProduct(product);
  }
  

  isSaving = false;
  notifyListeners();

  }
  
  Future<String?> updateProduct (Product product) async{

   final url = Uri.https(_baseUrl, 'products/${product.id}.json', {
       'auth' : await storage.read(key: 'token') ?? ''
  });
    final resp = await http.put(url, body: product.toJson(), );
    final decodedData = resp.body;

    

    //Actualizar la lista de productos
    final index = products.indexWhere((element) => element.id ==product.id);
    products[index] = product;

    

    return product.id;

  }
  Future<String?> createProduct (Product product) async{

    final url = Uri.https(_baseUrl, 'products.json', {
       'auth' : await storage.read(key: 'token') ?? ''
    });
    final resp = await http.post(url, body: product.toJson() );
    final decodedData = json.decode(resp.body);

    product.id = decodedData['name'];

    products.add(product);

    return product.id;

    
  }


  void updateSelectedProductImage(String path) {

    selectedProduct.picture = path;
    newPictureFile = File.fromUri(Uri(path: path));

    notifyListeners();


  }

  Future<String?>uploadImage()async{

    if(newPictureFile ==null)  return null;
    

    isSaving = true;
    notifyListeners();

    final url = Uri.parse('https://api.cloudinary.com/v1_1/djnbkdhcl/image/upload?upload_preset=wotn5cjd');

    final imageUploadRequest = http.MultipartRequest('POST', url  );

    final file  = await http.MultipartFile.fromPath('file', newPictureFile!.path);

    imageUploadRequest.files.add(file);

    final streamResponse = await imageUploadRequest.send();
    final resp = await http.Response.fromStream(streamResponse);

  if(resp.statusCode != 200 && resp.statusCode != 201){
    print('algo salio mal');
    print(resp.body);
    return null;
  }
    newPictureFile = null;

    final decodedData = json.decode(resp.body);
    return decodedData['secure_url'];
  

   

  }


}