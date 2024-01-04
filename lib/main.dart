import 'package:flutter/material.dart';
import 'package:statemanagementflutter/API_crud/Get/GetProvider.dart';
import 'package:statemanagementflutter/API_crud/Get/postProvider.dart';
import 'package:statemanagementflutter/DataModel.dart';
import 'package:statemanagementflutter/FutureProvider/FutureProviderCalling.dart';
import 'package:statemanagementflutter/JSONAPI/json_album_api/jsonAlbumProvider.dart';
import 'package:statemanagementflutter/JSONAPI/json_comment_api/jsonCommentProvider.dart';
import 'package:statemanagementflutter/JSONAPI/json_photos_api/jsonPhotoProvider.dart';
import 'package:statemanagementflutter/JSONAPI/json_post_api/jsonPostProvider.dart';
import 'package:statemanagementflutter/JSONAPI/json_todos_api/jsonTodoProvider.dart';
import 'package:statemanagementflutter/JSONAPI/json_users_api/jsonUsersProvider.dart';
import 'package:statemanagementflutter/StreamBuilder/StreamViewPage.dart';
import 'package:statemanagementflutter/api_navigate.dart';
import 'package:statemanagementflutter/myProviderPage.dart';
import 'package:statemanagementflutter/providerPage.dart';
import 'JSONAPI/json_post_api/jsonPostApis.dart';
import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<UserProfileService>(
          create: (context) => UserProfileService(),
        ),
        ChangeNotifierProvider<OrderProductService>(
          create: (context) => OrderProductService(),
        ),
        ChangeNotifierProvider<CustomerService>(
          create: (context) => CustomerService(),
        ),
        ChangeNotifierProvider<PostProvider>(
          create: (context) => PostProvider(),
        ),
        //Json Post Api  Provider
        ChangeNotifierProvider<JsonPostProvider>(create: (context) => JsonPostProvider()),
        ChangeNotifierProvider<JsonCommentProvider>(create: (context)=> JsonCommentProvider()),
        ChangeNotifierProvider<JsonAlbumProvider>(create: (context)=> JsonAlbumProvider()),
        ChangeNotifierProvider<JsonPhotosProvider>(create: (context)=> JsonPhotosProvider()),
        ChangeNotifierProvider<JsonTodoProvider>(create: (context)=> JsonTodoProvider()),
        ChangeNotifierProvider<UserProvider>(create: (context)=> UserProvider()),
      ],
      child:  MaterialApp(
        debugShowCheckedModeBanner: false,
        home: HomeScreen(),
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Multi-provider'),
      ),
      body: ListView(
        children: [
          ElevatedButton(onPressed: (){
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => apiNavigatePage()),
            );
          }, child: const Text("Json Api")),
          const Center(
              child: SizedBox(
            height: 30,
            child: Text(
              "Users Data",
              style: TextStyle(fontSize: 20),
            ),
          )),
          SizedBox(
            height: 100,
            child: Consumer<UserProfileService>(
              builder: (context, userProfileService, _) {
                List<UserProfileData> userProfiles =
                    userProfileService.userProfiles;
                return SizedBox(
                  height: 100,
                  child: ListView.builder(
                    itemCount: userProfiles.length,
                    itemBuilder: (context, index) {
                      UserProfileData userProfile = userProfiles[index];
                      return Card(
                        child: Column(
                          children: [
                            Text(
                              userProfile.name,
                              style: const TextStyle(color: Colors.red),
                            ),
                            // Add other UI elements as needed
                          ],
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ),
          const Center(
              child: SizedBox(
            height: 30,
            child: Text("Product Data", style: TextStyle(fontSize: 20)),
          )),
          SizedBox(
            height: 100,
            child: Consumer<OrderProductService>(
              builder: (context, OrderProductService, _) {
                List<OrderProduct> orderProducts =
                    OrderProductService.orderProducts;
                return SizedBox(
                  height: 200,
                  child: ListView.builder(
                    itemCount: orderProducts.length,
                    itemBuilder: (context, index) {
                      OrderProduct orderProduct = orderProducts[index];
                      return Card(
                        child: Column(
                          children: [
                            Image.network(
                              orderProduct.productImage,
                              fit: BoxFit.cover,
                              height: 100,
                            ),
                            Text(
                              orderProduct.productTitle,
                              style: const TextStyle(color: Colors.red),
                            ),
                            Text(
                              orderProduct.productPrice,
                            ),

                            // Add other UI elements as needed
                          ],
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ),
          const Center(
              child: SizedBox(
            height: 30,
            child: Text(
              "Customer Data",
              style: TextStyle(fontSize: 20),
            ),
          )),
          SizedBox(
            height: 100,
            child: Consumer<CustomerService>(
              builder: (context, customerServiceData, _) {
                List<CustomerData> customerProfiles =
                    customerServiceData.customerProfile;
                return SizedBox(
                  height: 100,
                  child: ListView.builder(
                    itemCount: customerProfiles.length,
                    itemBuilder: (context, index) {
                      CustomerData customerProfile = customerProfiles[index];
                      return Card(
                        child: Column(
                          children: [
                            Text(
                              customerProfile.customerName,
                              style: const TextStyle(color: Colors.red),
                            ),
                            // Add other UI elements as needed
                          ],
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: RefreshIndicator(
        onRefresh: () async {
          UserProfileService userProfileService =
              Provider.of<UserProfileService>(context, listen: false);

          await userProfileService.fetchUserProfiles();

          OrderProductService orderProductService =
              Provider.of<OrderProductService>(context, listen: false);

          await orderProductService.fetchOrderProducts();

          CustomerService customerProfileService =
              Provider.of<CustomerService>(context, listen: false);

          await customerProfileService.fetchCustomerProfiles();
        },
        child: IconButton(
          icon: const Icon(Icons.refresh),
          onPressed: () async {
            try {
              UserProfileService userProfileService = context.read<UserProfileService>();
              await userProfileService.fetchUserProfiles();

              OrderProductService orderProductService = context.read<OrderProductService>();
              await orderProductService.fetchOrderProducts();

              CustomerService customerProfileService = context.read<CustomerService>();
              await customerProfileService.fetchCustomerProfiles();
            } catch (error) {
              print('Error: $error');
            }
          },

        ),
      ),
    );
  }
}
