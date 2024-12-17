import 'package:fakestore_app/blocs/category/category_bloc.dart';
import 'package:fakestore_app/blocs/product/product_bloc.dart';
import 'package:fakestore_app/repositories/category_repository.dart';
import 'package:fakestore_app/repositories/product_repository.dart';
import 'package:fakestore_app/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<ProductRepository>(
            create: (context) => ProductRepository()),
        RepositoryProvider<CategoryRepository>(
            create: (context) => CategoryRepository()),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) =>
                ProductBloc(RepositoryProvider.of<ProductRepository>(context))
                  ..add(FetchProducts()),
          ),
          BlocProvider(
            create: (context) =>
                CategoryBloc(RepositoryProvider.of<CategoryRepository>(context))
                  ..add(FetchCategories()),
          ),
        ],
        child: MaterialApp(
          theme: ThemeData(scaffoldBackgroundColor: const Color(0xFFFEFFFF)),
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          home: const HomeScreen(),
        ),
      ),
    );
  }
}
