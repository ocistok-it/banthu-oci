import '../../../app/constants/app_assets.dart';
import 'widgets/categories_list.dart';
import 'widgets/sub_categories_grid.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../app/themes/app_colors.dart';
import '../../../app/themes/app_typography.dart';
import '../../../core/dependencies/injector.dart';
import '../data/models/categories_response_model.dart';
import '../domain/usecases/categories_usecase.dart';
import 'blocs/categories_bloc/categories_bloc.dart';
import 'controllers/category_controller.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:
          (context) =>
              CategoriesBloc(usecase: sl<CategoriesUsecase>())
                ..add(CategoriesRequested()),
      child: const CategoriesView(),
    );
  }
}

class CategoriesView extends StatefulWidget {
  const CategoriesView({super.key});

  @override
  State<CategoriesView> createState() => _CategoriesViewState();
}

class _CategoriesViewState extends State<CategoriesView> {
  final CategoryController _categoryController = CategoryController();

  @override
  void dispose() {
    _categoryController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.neutral50,
      appBar: AppBar(
        title: const Text("Product Categories"),
        shape: const Border(bottom: BorderSide(color: AppColor.neutral100)),
      ),
      body: BlocBuilder<CategoriesBloc, CategoriesState>(
        builder: (context, state) {
          if (state is CategoriesLoadComplete) {
            final List<CategoryModel> categories = state.categories;
            if (categories.isEmpty) {
              return const ErrorWidget(
                title: "No categories found!",
                message: "We're working to fix this issue as soon as possible.",
              );
            }
            return Row(
              children: [
                CategoriesList(
                  categories: state.categories,
                  categoryController: _categoryController,
                ),
                const SizedBox(width: 8),
                SubCategoriesGrid(categoryController: _categoryController),
              ],
            );
          } else if (state is CategoriesLoadFailure) {
            return ErrorWidget(
              title: "Internal Error Happened!",
              message: state.errorMessage,
            );
          } else {
            return const CategoriesLoading();
          }
        },
      ),
    );
  }
}

class ErrorWidget extends StatelessWidget {
  const ErrorWidget({super.key, required this.title, required this.message});

  final String title;
  final String message;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(AppAssets.noProductIllustration),
          const SizedBox(height: 24),
          Text(
            title,
            style: titleSemiBold.copyWith(color: AppColor.neutral900),
          ),
          const SizedBox(height: 16),
          Text(
            message,
            textAlign: TextAlign.center,
            style: bodyLargeRegular.copyWith(color: AppColor.neutral700),
          ),
        ],
      ),
    );
  }
}

class CategoriesLoading extends StatelessWidget {
  const CategoriesLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: ColoredBox(
            color: AppColor.neutral0,
            child: CustomScrollView(
              slivers: [
                SliverList.separated(
                  itemCount: 5,
                  separatorBuilder: (_, _) => const SizedBox(height: 16),
                  itemBuilder: (_, index) {
                    return Container(
                      height: 96,
                      decoration: const BoxDecoration(
                        color: AppColor.brandPrimary25,
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
        Expanded(
          flex: 3,
          child: ColoredBox(
            color: AppColor.neutral0,
            child: CustomScrollView(
              slivers: [
                SliverPadding(
                  padding: const EdgeInsets.only(
                    left: 16,
                    right: 16,
                    bottom: 16,
                    top: 16,
                  ),
                  sliver: SliverGrid(
                    gridDelegate:
                        const SliverGridDelegateWithMaxCrossAxisExtent(
                          maxCrossAxisExtent: 80,
                          mainAxisSpacing: 16,
                          childAspectRatio: 80 / 92,
                          crossAxisSpacing: 16,
                        ),
                    delegate: SliverChildBuilderDelegate(
                      (context, index) => Container(
                        height: 48,
                        decoration: const BoxDecoration(
                          color: AppColor.brandPrimary25,
                        ),
                      ),
                      childCount: 5,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
