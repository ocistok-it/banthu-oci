import 'package:intl/intl.dart';

import '../../../../app/constants/app_assets.dart';
import '../../../../app/themes/app_colors.dart';
import '../../../../app/themes/app_typography.dart';
import '../../../../app/widgets/app_clickable_widget.dart';
import '../../data/models/categories_response_model.dart';
import '../controllers/category_controller.dart';
import 'package:flutter/material.dart';

class CategoriesList extends StatefulWidget {
  const CategoriesList({
    super.key,
    required this.categories,
    required this.categoryController,
  });

  final List<CategoryModel> categories;
  final CategoryController categoryController;

  @override
  State<CategoriesList> createState() => _CategoriesListState();
}

class _CategoriesListState extends State<CategoriesList> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: ColoredBox(
        color: AppColor.neutral0,
        child: CustomScrollView(
          slivers: [
            SliverList.builder(
              itemCount: widget.categories.length,
              itemBuilder: (_, index) {
                final CategoryModel category = widget.categories[index];
                return ListenableBuilder(
                  listenable: widget.categoryController,
                  builder: (context, _) {
                    return AppClickableWidget(
                      onTap: () {
                        if (widget.categoryController.category == category) {
                          return;
                        }
                        widget.categoryController.setCategory(category);
                      },
                      child: Container(
                        height: 96,
                        padding: const EdgeInsets.symmetric(horizontal: 4),
                        decoration: BoxDecoration(
                          color:
                              widget.categoryController.category == category
                                  ? AppColor.brandPrimary25
                                  : null,
                          border:
                              widget.categoryController.category == category
                                  ? const Border(
                                    right: BorderSide(
                                      color: AppColor.brandPrimary400,
                                      width: 2,
                                    ),
                                  )
                                  : null,
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            if (category.image == null ||
                                category.image!.isEmpty) ...[
                              Image.asset(
                                AppIcons.defCategoryIcon,
                                filterQuality: FilterQuality.high,
                                fit: BoxFit.fill,
                                height: 24,
                                width: 24,
                              ),
                            ] else ...[
                              Image.asset(
                                category.image!,
                                filterQuality: FilterQuality.high,
                                fit: BoxFit.fill,
                                height: 24,
                                width: 24,
                              ),
                            ],
                            Text(
                              toBeginningOfSentenceCase(category.displayName!),
                              maxLines: 2,
                              textAlign: TextAlign.center,
                              style:
                                  widget.categoryController.category == category
                                      ? bodySmallSemiBold.copyWith(
                                        color: AppColor.brandPrimary400,
                                      )
                                      : bodySmallRegular.copyWith(
                                        color: AppColor.neutral900,
                                      ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
