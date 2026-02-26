import 'package:banthu_app/app/widgets/app_clickable_widget.dart';

import '../../../../app/constants/app_assets.dart';
import '../../../../app/themes/app_colors.dart';
import '../../../../app/themes/app_typography.dart';
import '../../data/models/categories_response_model.dart';
import '../controllers/category_controller.dart';
import 'last_seen_category_section.dart';
import 'last_seen_category_section_title.dart';
import 'recommendation_section.dart';
import 'recommendation_section_title.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:unicons/unicons.dart';

class SubCategoriesGrid extends StatefulWidget {
  const SubCategoriesGrid({super.key, required this.categoryController});

  final CategoryController categoryController;

  @override
  State<SubCategoriesGrid> createState() => _SubCategoriesGridState();
}

class _SubCategoriesGridState extends State<SubCategoriesGrid> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 3,
      child: ColoredBox(
        color: AppColor.neutral0,
        child: ListenableBuilder(
          listenable: widget.categoryController,
          builder: (context, _) {
            if (widget.categoryController.category.id == 42424242424242) {
              return const CustomScrollView(
                slivers: [
                  RecommendationSectionTitle(),
                  RecommendationSection(),
                  LastSeenCategorySectionTitle(),
                  LastSeenCategorySection(),
                ],
              );
            } else {
              if (widget.categoryController.category.child!.isEmpty) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image.asset(AppAssets.noProductIllustration),
                      const SizedBox(height: 24),
                      Text(
                        "No sub-categories found!",
                        style: titleSemiBold.copyWith(
                          color: AppColor.neutral900,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        "We're working to fix this issue as soon as possible",
                        textAlign: TextAlign.center,
                        style: bodyLargeRegular.copyWith(
                          color: AppColor.neutral700,
                        ),
                      ),
                    ],
                  ),
                );
              }
              return SubCategoriesList(
                category: widget.categoryController.category,
              );
            }
          },
        ),
      ),
    );
  }
}

class SubCategoriesList extends StatelessWidget {
  const SubCategoriesList({super.key, required this.category});

  final CategoryModel category;

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Container(
            padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  category.displayName!,
                  style: bodyMediumSemiBold.copyWith(
                    color: AppColor.neutral900,
                  ),
                ),
                const SizedBox(height: 8),
                const Divider(height: 0, color: AppColor.neutral100),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ),
        SliverPadding(
          padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
          sliver: SliverList.separated(
            itemCount: category.child!.length,
            separatorBuilder: (_, _) => const SizedBox(height: 16),
            itemBuilder: (_, index) {
              final SubCategoryModel subcategory = category.child![index];
              return AppClickableWidget(
                onTap: () {},
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: Text(
                            toBeginningOfSentenceCase(subcategory.displayName!),
                            style: bodySmallRegular.copyWith(
                              color: AppColor.neutral700,
                            ),
                          ),
                        ),
                        const Icon(UniconsSolid.angle_right),
                      ],
                    ),
                    const SizedBox(height: 6),
                    const Divider(height: 0, color: AppColor.neutral100),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
