import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gem_store/theme/app_colors.dart';
import '../../../common/model/products_model.dart';
import '../../../common/widgets/products_grid_widgets.dart';
import '../bloc/search_bloc.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Gemstore",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 24.sp,
            letterSpacing: 1.5,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            TextFormField(
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.search, color: AppColors.greyColor),
                hintText: 'Search here',
              ),
              onChanged: (text) {
                context.read<SearchBloc>().add(SearchProducts(text));
              },
            ),
            SizedBox(height: 16.h),
            BlocBuilder<SearchBloc, SearchState>(
              builder: (context, state) {
                if (state is SearchInitial) {
                  return const SizedBox.shrink();
                } else if (state is SearchLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is SearchLoaded) {
                  if (state.results.isEmpty) {
                    return Center(
                      child: Text(
                        "No Prodcuts Found",
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                          color: AppColors.greyColor,
                        ),
                      ),
                    );
                  }
                  return GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 16.w,
                      mainAxisSpacing: 4.h,
                      childAspectRatio: 0.65,
                    ),
                    itemCount: state.results.length,
                    itemBuilder: (context, index) {
                      ProductsModel product = state.results[index];
                      return ProductsGridWidgets(product: product);
                    },
                  );
                } else if (state is SearchError) {
                  return Center(child: Text(state.message));
                }
                return const SizedBox.shrink();
              },
            ),
          ],
        ),
      ),
    );
  }
}
