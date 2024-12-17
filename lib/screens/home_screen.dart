import 'package:fakestore_app/blocs/category/category_bloc.dart';
import 'package:fakestore_app/blocs/product/product_bloc.dart';
import 'package:fakestore_app/widgets/item_category.dart';
import 'package:fakestore_app/widgets/skeleton_category.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          children: [
            const ProfileBar(),
            const Gap(20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('CATEGORIES',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        letterSpacing: -0.3)),
                GestureDetector(
                  onTap: () {},
                  child: const Row(
                    children: [
                      Text('See All',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                              letterSpacing: -0.3)),
                      Gap(3),
                      Icon(Icons.arrow_outward_sharp,
                          color: Colors.black, size: 20)
                    ],
                  ),
                )
              ],
            ),
            const Gap(20),
            const CategoryItem(),
            const Gap(20),
            BlocBuilder<ProductBloc, ProductState>(
              builder: (context, state) {
                if (state is ProductLoading) {
                  return Expanded(
                    child: Text('loading product'),
                  );
                } else if (state is ProductLoaded) {
                  return Expanded(
                    child: GridView.count(
                      shrinkWrap: true,
                      crossAxisCount: 2,
                      crossAxisSpacing: 8,
                      mainAxisSpacing: 8,
                      childAspectRatio: 2 / 3,
                      children: state.products.map((product) {
                        return CardProduct(
                          image: product.image,
                          name: product.title,
                          rate: product.rating.rate,
                          price: product.price,
                          onTap: () {
                            print(product.id);
                          },
                        );
                        // return Container(
                        //   padding: const EdgeInsets.all(10),
                        //   decoration: BoxDecoration(
                        //     borderRadius: BorderRadius.circular(10),
                        //     color: Colors.grey.shade200,
                        //   ),
                        //   child: Column(
                        //     crossAxisAlignment: CrossAxisAlignment.start,
                        //     children: [
                        //       Container(
                        //         decoration: BoxDecoration(
                        //           color: Colors.grey.shade300,
                        //           borderRadius: BorderRadius.circular(8),
                        //         ),
                        //         width: double.infinity,
                        //         height: 120,
                        //       ),
                        //       const Gap(12),
                        //       Container(
                        //         width: 100,
                        //         height: 8,
                        //         decoration: BoxDecoration(
                        //           borderRadius: BorderRadius.circular(8),
                        //           color: Colors.grey.shade300,
                        //         ),
                        //       ),
                        //       const Gap(12),
                        //       Container(
                        //         width: 140,
                        //         height: 10,
                        //         decoration: BoxDecoration(
                        //           borderRadius: BorderRadius.circular(8),
                        //           color: Colors.grey.shade300,
                        //         ),
                        //       ),
                        //       const Gap(12),
                        //       Container(
                        //         width: 100,
                        //         height: 10,
                        //         decoration: BoxDecoration(
                        //           borderRadius: BorderRadius.circular(8),
                        //           color: Colors.grey.shade300,
                        //         ),
                        //       ),
                        //     ],
                        //   ),
                        // );
                      }).toList(),
                    ),
                  );
                } else if (state is ProductError) {
                  return const Text('failed fetch products');
                }
                return const Center(child: Text('No Data Products'),); 
              },
            ),
          ],
        ),
      )),
    );
  }
}

class CardProduct extends StatelessWidget {
  final String image;
  final String name;
  final double rate;
  final double price;
  final VoidCallback? onTap;

  const CardProduct(
      {required this.image,
      required this.name,
      required this.rate,
      required this.price,
      this.onTap,
      super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade300),
            borderRadius: BorderRadius.circular(10),
            color: Colors.white),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                image,
                width: double.infinity,
                height: 150,
                alignment: Alignment.topCenter,
                fit: BoxFit.cover,
              ),
            ),
            const Gap(10),
            Text(
              'New Product',
              style: TextStyle(color: Colors.grey.shade600, fontSize: 14),
            ),
            const Gap(5),
            Text(
              name,
              style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  overflow: TextOverflow.ellipsis),
              maxLines: 1,
            ),
            const Gap(10),
            Row(
              children: [
                Icon(
                  Icons.star_rounded,
                  color: Colors.amber.shade800,
                ),
                const Gap(3),
                Text(
                  '$rate',
                  style: const TextStyle(fontWeight: FontWeight.w500),
                ),
                const Spacer(),
                Text(
                  '\$ $price',
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 18),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

class CategoryItem extends StatelessWidget {
  const CategoryItem({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoryBloc, CategoryState>(
      builder: (context, state) {
        if (state is CategoryLoading) {
          return const SkeletonCategory();
        } else if (state is CategoryLoaded) {
          return SizedBox(
              height: 100,
              width: MediaQuery.of(context).size.width,
              child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: state.categories.length,
                  separatorBuilder: (context, index) => const Gap(20),
                  itemBuilder: (context, index) {
                    final category = state.categories[index];
                    return ItemCategory(categoryName: category);
                  }));
        } else {
          return const Text('failed category');
        }
      },
    );
  }
}

class ProfileBar extends StatelessWidget {
  const ProfileBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(50),
          child: Image.network(
            'https://images.unsplash.com/photo-1539571696357-5a69c17a67c6?q=80&w=1974&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
            width: 70,
            height: 70,
            fit: BoxFit.cover,
            alignment: Alignment.topCenter,
          ),
        ),
        const Gap(10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Hello Tehyung',
              style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey.shade600,
                  fontWeight: FontWeight.w400),
            ),
            const Gap(2),
            const Text(
              'Whats do you want?',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
        const Spacer(),
        IconButton(
          onPressed: () {},
          icon: Icon(
            Icons.notifications_none_outlined,
            color: Colors.grey.shade600,
            size: 40,
          ),
        )
      ],
    );
  }
}
