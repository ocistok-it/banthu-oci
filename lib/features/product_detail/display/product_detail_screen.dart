import 'dart:math';
import 'dart:typed_data';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get_video_thumbnail/get_video_thumbnail.dart';
import 'package:get_video_thumbnail/index.dart';
import 'package:sliver_expandable/sliver_expandable.dart';
import 'package:unicons/unicons.dart';
import 'package:video_player/video_player.dart';

import '../../../app/constants/constants.dart';
import '../../../app/design_system/design_system.dart';
import '../../../app/themes/app_colors.dart';
import '../../../app/themes/app_typography.dart';
import '../../../app/widgets/app_clickable_widget.dart';
import '../../../app/widgets/product_card.dart';
import '../../../core/utils/utils.dart';
import '../../../core/dependencies/injector.dart';
import '../../home/home_screen.dart';
import '../data/models/product_detail_response_model.dart';
import '../domain/usecases/product_detail_usecase.dart';
import 'bloc/product_detail_bloc.dart';

class CustomBlocBuilder<T, B extends BlocBase<State>>
    extends BlocBuilder<B, State> {
  CustomBlocBuilder({super.key})
    : super(
        builder:
            (context, state) => switch (state) {
              _ => Container(),
            },
      );
}

class ExpandNotifier with ChangeNotifier {
  bool _expanded = false;

  void changeState() {
    _expanded = !_expanded;
    notifyListeners();
  }
}

class ProductDetailScreen extends StatelessWidget {
  const ProductDetailScreen({
    super.key,
    required this.store,
    required this.productId,
  });

  final String store;
  final String productId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:
          (context) => ProductDetailBloc(usecase: sl<ProductDetailUsecase>())
            ..add(ProductDetailRequested(store: store, productId: productId)),
      child: const ProductDetailView(),
    );
  }
}

class ProductDetailView extends StatefulWidget {
  const ProductDetailView({super.key});

  @override
  State<ProductDetailView> createState() => _ProductDetailViewState();
}

class _ProductDetailViewState extends State<ProductDetailView> {
  @override
  Widget build(BuildContext context) {
    // final width = MediaQuery.sizeOf(context).width;
    // if (width >= PhoneType.foldable) {
    //   return ProductDetailMobile();
    // } else if (width >= PhoneType.largeTablet) {
    //   return ProductDetailMobile();
    // } else if (width >= PhoneType.tablet) {
    //   return ProductDetailMobile();
    // } else if (width >= PhoneType.largeMobile) {
    //   return ProductDetailMobile();
    // } else {
    //   return ProductDetailMobile();
    // }
    return const ProductDetailMobile();
  }
}

class ProductDetailMobile extends StatefulWidget {
  const ProductDetailMobile({super.key});

  @override
  State<ProductDetailMobile> createState() => _ProductDetailMobileState();
}

class _ProductDetailMobileState extends State<ProductDetailMobile> {
  final IndicatorModel _indicator = IndicatorModel();
  final ExpandNotifier _expandNotifier = ExpandNotifier();
  final CarouselSliderController _carouselController =
      CarouselSliderController();

  @override
  void dispose() {
    _indicator.dispose();
    _expandNotifier.dispose();

    super.dispose();
  }

  bool _isProductContainVideo(String? productVideo) {
    return productVideo != null && productVideo.isNotEmpty;
  }

  String formatMinimumText(int index, List<ProductDiscountModel> discounts) {
    if (discounts.length == 1) {
      return 'Minimum: ${discounts[0].kuantiti} piece';
    }

    if (index == 0) {
      return 'Minimum ${discounts[index].kuantiti} piece';
    } else if (index < discounts.length - 1) {
      return '${discounts[index].kuantiti} - ${discounts[index + 1].kuantiti!.toInt() - 1} pieces';
    } else {
      return '>${discounts[index].kuantiti!.toInt() - 1} pieces';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.neutral50,
      bottomNavigationBar: BlocBuilder<ProductDetailBloc, ProductDetailState>(
        builder: (context, state) {
          if (state is ProductDetailLoadComplete) {
            return BottomAppBar(
              color: AppColor.neutral0,
              surfaceTintColor: AppColor.neutral0,
              child: PrimaryButton(
                label: "Check & Calculate",
                onTap: () {
                  final bool isContainsSubVariants =
                      state.productDetailData.variant!.length > 1;

                  _showProductVariantsBottomSheet(
                    context,
                    state.productDetailData.variants ?? [],
                    false,
                  );
                },
              ),
            );
          } else {
            return const SizedBox.shrink();
          }
        },
      ),
      body: CustomScrollView(
        cacheExtent: 3600,
        slivers: [
          SliverAppBar(
            pinned: true,
            title: const Text("Product Detail"),
            actions: [
              IconButton(
                onPressed: () {},
                icon: const Icon(UniconsLine.shopping_cart),
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(UniconsLine.download_alt),
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(UniconsLine.share_alt),
              ),
            ],
          ),
          SliverList(
            delegate: SliverChildListDelegate.fixed([
              BlocBuilder<ProductDetailBloc, ProductDetailState>(
                builder: (context, state) {
                  if (state is ProductDetailLoadInProgress) {
                    return const AspectRatio(
                      aspectRatio: 1,
                      child: RectangleShimmer(),
                    );
                  } else if (state is ProductDetailLoadComplete) {
                    final List<String> productImgs = List.from(
                      state.productDetailData.itemImgs ?? [],
                    );
                    final String? productVideo = state.productDetailData.video;

                    if (productImgs.isEmpty) {
                      return const SizedBox.shrink();
                    }

                    if (_isProductContainVideo(productVideo)) {
                      productImgs.insert(0, productVideo!);
                    }

                    if (productImgs.isEmpty) {
                      return AspectRatio(
                        aspectRatio: 1,
                        child: Container(
                          color: AppColors.neutral[100],
                          child: const Center(child: Text("No Image Preview")),
                        ),
                      );
                    }
                    return Stack(
                      children: [
                        ListenableBuilder(
                          listenable: _indicator,
                          builder: (context, child) {
                            return CarouselSlider.builder(
                              carouselController: _carouselController,
                              options: CarouselOptions(
                                autoPlay: _indicator.currentIndex != 0,
                                aspectRatio: 1,
                                viewportFraction: 1,
                                onPageChanged: (index, reason) {
                                  _indicator.setCurrentIndex(index);
                                },
                              ),
                              itemCount: productImgs.length,
                              itemBuilder: (context, index, realIndex) {
                                if (index == 0 &&
                                    _isProductContainVideo(productVideo)) {
                                  return VideoProduct(
                                    videoUrl: productImgs.first,
                                  );
                                }
                                return SizedBox(
                                  width: double.infinity,
                                  child: Image.network(
                                    productImgs[index],
                                    fit: BoxFit.fill,
                                    filterQuality: FilterQuality.high,
                                  ),
                                );
                              },
                            );
                          },
                        ),
                        ListenableBuilder(
                          listenable: _indicator,
                          builder: (context, child) {
                            if (_indicator.currentIndex == 0 &&
                                _isProductContainVideo(productVideo)) {
                              return const SizedBox.shrink();
                            }
                            return Positioned(
                              left: 32,
                              bottom: 36,
                              right: 32,
                              child: SizedBox(
                                height: 8,
                                child: ListView.separated(
                                  padding: EdgeInsets.zero,
                                  separatorBuilder:
                                      (_, _) => const SizedBox(width: 4.0),
                                  itemBuilder: (_, index) {
                                    return IndicatorWidget(
                                      indicatorNotifier: _indicator,
                                      bannerIndex: index,
                                    );
                                  },
                                  itemCount: productImgs.length,
                                  scrollDirection: Axis.horizontal,
                                ),
                              ),
                            );
                          },
                        ),
                      ],
                    );
                  } else {
                    return AspectRatio(
                      aspectRatio: 1,
                      child: Container(color: AppColors.neutral[100]),
                    );
                  }
                },
              ),
              const ColoredBox(
                color: AppColor.neutral0,
                child: SizedBox(height: 8),
              ),
              BlocBuilder<ProductDetailBloc, ProductDetailState>(
                builder: (context, state) {
                  if (state is ProductDetailLoadInProgress) {
                    return SizedBox(
                      height: 40,
                      child: ColoredBox(
                        color: AppColor.neutral0,
                        child: ListView.separated(
                          scrollDirection: Axis.horizontal,
                          separatorBuilder: (_, _) => const SizedBox(width: 8),
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          itemCount: 4,
                          itemBuilder: (_, _) {
                            return const SizedBox(
                              width: 40,
                              child: RectangleShimmer(),
                            );
                          },
                        ),
                      ),
                    );
                  } else if (state is ProductDetailLoadComplete) {
                    final List<String> productImgs = List.from(
                      state.productDetailData.itemImgs ?? [],
                    );
                    final String? productVideo = state.productDetailData.video;

                    if (productImgs.isEmpty) {
                      return const SizedBox.shrink();
                    }

                    if (_isProductContainVideo(productVideo)) {
                      productImgs.insert(0, productVideo!);
                    }

                    return SizedBox(
                      height: 40,
                      child: ColoredBox(
                        color: AppColor.neutral0,
                        child: ListView.separated(
                          scrollDirection: Axis.horizontal,
                          separatorBuilder: (_, _) => const SizedBox(width: 8),
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          itemCount: productImgs.length,
                          itemBuilder: (_, int index) {
                            if (index == 0 &&
                                _isProductContainVideo(productVideo)) {
                              return ProductThumbnail.video(
                                url: productImgs.first,
                                notifier: _indicator,
                                index: 0,
                                carouselSliderController: _carouselController,
                              );
                            }
                            return ProductThumbnail.pic(
                              url: productImgs[index],
                              notifier: _indicator,
                              index: index,
                              carouselSliderController: _carouselController,
                            );
                          },
                        ),
                      ),
                    );
                  }
                  return SizedBox(
                    height: 40,
                    child: ColoredBox(
                      color: AppColor.neutral0,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        separatorBuilder: (_, _) => const SizedBox(width: 8),
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        itemCount: 4,
                        itemBuilder: (_, _) {
                          return Container(
                            width: 40,
                            color: AppColors.neutral[100],
                          );
                        },
                      ),
                    ),
                  );
                },
              ),
              Container(
                color: AppColor.neutral0,
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 16,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    BlocBuilder<ProductDetailBloc, ProductDetailState>(
                      builder: (context, state) {
                        if (state is ProductDetailLoadInProgress) {
                          return const SizedBox.shrink();
                        } else if (state is ProductDetailLoadComplete) {
                          final List<ProductDiscountModel> productDiscounts =
                              List.from(
                                state.productDetailData.productDiscounts ?? [],
                              );
                          return Wrap(
                            spacing: 16,
                            children:
                                productDiscounts.asMap().entries.map((entry) {
                                  int index = entry.key;
                                  ProductDiscountModel item = entry.value;
                                  double pricePerUnit = 4.8 * item.value!;

                                  return Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      RichText(
                                        text: TextSpan(
                                          children: [
                                            TextSpan(
                                              text:
                                                  AppUtilities.getCurrencySymbol(
                                                    context,
                                                  ),
                                              style: bodyLargeRegular.copyWith(
                                                color: AppColor.neutral900,
                                              ),
                                            ),
                                            TextSpan(
                                              text: pricePerUnit
                                                  .toStringAsFixed(2),
                                              style: heading6SemiBold.copyWith(
                                                color: AppColor.neutral900,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Text(
                                        formatMinimumText(
                                          index,
                                          productDiscounts,
                                        ),
                                        style: bodySmallRegular.copyWith(
                                          color: AppColor.neutral600,
                                        ),
                                      ),
                                    ],
                                  );
                                }).toList(),
                          );
                        }
                        return const SizedBox.shrink();
                      },
                    ),
                    const SizedBox(height: 6),

                    BlocBuilder<ProductDetailBloc, ProductDetailState>(
                      builder: (context, state) {
                        if (state is ProductDetailLoadInProgress) {
                          return const SizedBox.shrink();
                        } else if (state is ProductDetailLoadComplete) {
                          return Text(
                            r"The product price doesn't include service fees, taxes and shipping costs",
                            style: bodySmallRegular.copyWith(
                              color: AppColor.neutral600,
                            ),
                          );
                        }
                        return const SizedBox.shrink();
                      },
                    ),
                    const SizedBox(height: 16),
                    const Divider(color: AppColor.neutral100, height: 0),
                    const SizedBox(height: 16),
                    Row(
                      spacing: 8,
                      children: [
                        BlocBuilder<ProductDetailBloc, ProductDetailState>(
                          builder: (context, state) {
                            if (state is ProductDetailLoadComplete) {
                              final String productName =
                                  state.productDetailData.titleChina ?? "";
                              return Flexible(
                                child: Text(
                                  productName,
                                  style: bodyXlargeSemiBold.copyWith(
                                    color: AppColor.neutral900,
                                  ),
                                  maxLines: 3,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              );
                            }
                            return const Flexible(
                              child: RectangleShimmer(height: 40),
                            );
                          },
                        ),
                        BlocBuilder<ProductDetailBloc, ProductDetailState>(
                          builder: (context, state) {
                            if (state is ProductDetailLoadComplete) {
                              return SizedBox(
                                height: 40,
                                width: 40,
                                child: IconButton(
                                  onPressed: () {},
                                  icon: const Icon(UniconsLine.heart),
                                ),
                              );
                            }
                            return const CircleShimmer(size: 40);
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              "Product sold ",
                              style: bodySmallRegular.copyWith(
                                color: AppColor.neutral600,
                              ),
                            ),
                            BlocBuilder<ProductDetailBloc, ProductDetailState>(
                              builder: (context, state) {
                                if (state is ProductDetailLoadComplete) {
                                  final productSold =
                                      state.productDetailData.totalPenjualan ??
                                      "";
                                  return Text(
                                    productSold,
                                    style: bodySmallSemiBold.copyWith(
                                      color: AppColor.neutral900,
                                    ),
                                  );
                                }
                                return Text(
                                  "-",
                                  style: bodySmallSemiBold.copyWith(
                                    color: AppColor.neutral900,
                                  ),
                                );
                              },
                            ),
                            const SizedBox(
                              height: 16,
                              child: VerticalDivider(),
                            ),
                            Row(
                              spacing: 4,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Icon(
                                  UniconsSolid.star,
                                  color: Colors.amber,
                                ),
                                BlocBuilder<
                                  ProductDetailBloc,
                                  ProductDetailState
                                >(
                                  builder: (context, state) {
                                    if (state is ProductDetailLoadComplete) {
                                      return Text(
                                        state.productDetailData.rating
                                            .toString(),
                                        style: bodySmallSemiBold.copyWith(
                                          color: AppColor.neutral900,
                                        ),
                                      );
                                    }
                                    return Text(
                                      "-",
                                      style: bodySmallSemiBold.copyWith(
                                        color: AppColor.neutral900,
                                      ),
                                    );
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                        BlocBuilder<ProductDetailBloc, ProductDetailState>(
                          builder: (context, state) {
                            return SecondaryButton(
                              onTap:
                                  state is ProductDetailLoadComplete
                                      ? () {
                                        print("OK");
                                      }
                                      : null,
                              appButtonSize: AppButtonSize.xsmall,
                              leading:
                                  (iconColor) => const Icon(UniconsLine.sync),
                              label: "Sync",
                            );
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              Container(
                color: AppColor.neutral0,
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 12,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      spacing: 8,
                      children: [
                        BlocBuilder<ProductDetailBloc, ProductDetailState>(
                          builder: (context, state) {
                            if (state is ProductDetailLoadComplete) {
                              return Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: AppColor.brandPrimary25,
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: const Icon(
                                  UniconsLine.store,
                                  size: 40,
                                  color: AppColor.brandPrimary400,
                                ),
                              );
                            }
                            return const RectangleShimmer(
                              height: 40,
                              width: 40,
                            );
                          },
                        ),
                        BlocBuilder<ProductDetailBloc, ProductDetailState>(
                          builder: (context, state) {
                            if (state is ProductDetailLoadComplete) {
                              return Column(
                                spacing: 8,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    state.productDetailData.seller ?? "-",
                                    style: bodyLargeSemiBold.copyWith(
                                      color: AppColor.neutral900,
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          const Icon(
                                            UniconsSolid.star,
                                            color: Colors.amber,
                                          ),
                                          Text(
                                            state.productDetailData.rating
                                                .toString(),
                                            style: bodyMediumSemiBold.copyWith(
                                              color: AppColor.neutral900,
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(width: 8),
                                      Text(
                                        "•",
                                        style: bodyMediumSemiBold.copyWith(
                                          color: AppColor.neutral900,
                                        ),
                                      ),
                                      const SizedBox(width: 8),
                                      Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Text(
                                            state.productDetailData.totalProduct
                                                .toString(),
                                            style: bodyMediumSemiBold.copyWith(
                                              color: AppColor.neutral900,
                                            ),
                                          ),
                                          Text(
                                            " Products",
                                            style: bodyMediumRegular.copyWith(
                                              color: AppColor.neutral600,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              );
                            }
                            return const Column(
                              spacing: 8,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                RectangleShimmer(height: 10, width: 200),
                                RectangleShimmer(height: 10, width: 250),
                              ],
                            );
                          },
                        ),
                      ],
                    ),
                    BlocBuilder<ProductDetailBloc, ProductDetailState>(
                      builder: (context, state) {
                        return IconButton(
                          onPressed:
                              state is ProductDetailLoadComplete ? () {} : null,
                          icon: const Icon(UniconsLine.angle_right, size: 24),
                        );
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              ColoredBox(
                color: AppColor.neutral0,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 24),
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: Text(
                        "Recommendation from Supplier",
                        style: bodyLargeSemiBold.copyWith(
                          color: AppColor.neutral900,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    SizedBox(
                      height: 266.0,
                      child: ListView.separated(
                        separatorBuilder:
                            (_, index) => const SizedBox(width: 16.0),
                        scrollDirection: Axis.horizontal,
                        padding: const EdgeInsets.only(
                          left: 20.0,
                          right: 20.0,
                          bottom: 10,
                        ),
                        itemCount: 10,
                        itemBuilder: (BuildContext context, int index) {
                          return ProductCard(
                            productName: LoremIpsumGenerator.generate(),
                            productPrice: Random().nextInt(500),
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              BlocBuilder<ProductDetailBloc, ProductDetailState>(
                builder: (context, state) {
                  if (state is ProductDetailLoadComplete) {
                    final attributes = state.productDetailData.attribute ?? [];
                    return ColoredBox(
                      color: AppColor.neutral0,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 16),
                            AppClickableWidget(
                              onTap: () {
                                if (attributes.isEmpty) return;
                                _showCommodityAttributesBottomSheet(
                                  context,
                                  attributes,
                                );
                              },
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Commodity Attributes",
                                    style: bodyLargeSemiBold.copyWith(
                                      color: AppColor.neutral900,
                                    ),
                                  ),
                                  const Icon(Icons.chevron_right),
                                ],
                              ),
                            ),
                            const SizedBox(height: 16),
                            const Divider(
                              height: 0,
                              color: AppColor.neutral100,
                            ),
                            const SizedBox(height: 16),
                            Text(
                              "Product Descriptions",
                              style: bodyLargeSemiBold.copyWith(
                                color: AppColor.neutral900,
                              ),
                            ),
                            const SizedBox(height: 16),
                          ],
                        ),
                      ),
                    );
                  }
                  return const SizedBox.shrink();
                },
              ),
            ]),
          ),
          BlocBuilder<ProductDetailBloc, ProductDetailState>(
            builder: (context, state) {
              if (state is ProductDetailLoadComplete) {
                final productDescriptions =
                    state.productDetailData.descImage ?? [];
                if (productDescriptions.isEmpty) {
                  return DecoratedSliver(
                    decoration: const BoxDecoration(color: AppColor.neutral0),
                    sliver: SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.only(
                          top: 4,
                          left: 20,
                          right: 20,
                          bottom: 20,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Image.asset(AppAssets.emptyBox, fit: BoxFit.fill),
                            Text(
                              "Aw, snap!",
                              style: bodyLargeSemiBold.copyWith(
                                color: AppColor.neutral900,
                              ),
                            ),
                            Text(
                              "No description for this product",
                              style: bodyLargeRegular.copyWith(
                                color: AppColor.neutral700,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }
                return ListenableBuilder(
                  listenable: _expandNotifier,
                  builder: (context, child) {
                    return AnimatedSliverExpandable(
                      expanded: _expandNotifier._expanded,
                      headerBuilder:
                          (_, _) => AppClickableWidget(
                            key: const ValueKey("expandNotifier"),
                            onTap: () {
                              _expandNotifier.changeState();
                            },
                            child: ColoredBox(
                              color: AppColor.neutral0,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 20,
                                ),
                                child: Column(
                                  children: [
                                    Image.network(
                                      productDescriptions.first.url!,
                                      fit: BoxFit.fitHeight,
                                    ),
                                    if (!_expandNotifier._expanded) ...[
                                      const SizedBox(height: 16),
                                      const Divider(
                                        height: 0,
                                        color: AppColor.neutral100,
                                      ),
                                      const SizedBox(height: 16),
                                      Text(
                                        "See more",
                                        style: bodySmallSemiBold.copyWith(
                                          color: AppColor.brandPrimary400,
                                        ),
                                      ),
                                      const SizedBox(height: 16),
                                    ],
                                  ],
                                ),
                              ),
                            ),
                          ),
                      sliver: SliverList(
                        delegate: SliverChildBuilderDelegate(
                          (context, index) => ColoredBox(
                            color: AppColor.neutral0,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 20,
                              ),
                              child: Image.network(
                                productDescriptions[index].url!,
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                          childCount: productDescriptions.length,
                        ),
                      ),
                    );
                  },
                );
              }
              return const SliverToBoxAdapter();
            },
          ),
          ListenableBuilder(
            listenable: _expandNotifier,
            builder: (context, child) {
              if (_expandNotifier._expanded) {
                return SliverToBoxAdapter(
                  child: ColoredBox(
                    color: AppColor.neutral0,
                    child: Column(
                      children: [
                        const SizedBox(height: 16),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20.0),
                          child: Divider(height: 0, color: AppColor.neutral100),
                        ),
                        const SizedBox(height: 16),
                        AppClickableWidget(
                          onTap: () {
                            _expandNotifier.changeState();
                          },
                          child: Text(
                            "View less",
                            style: bodySmallSemiBold.copyWith(
                              color: AppColor.brandPrimary400,
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                      ],
                    ),
                  ),
                );
              }
              return const SliverToBoxAdapter();
            },
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 8)),
          DecoratedSliver(
            decoration: const BoxDecoration(color: AppColor.neutral0),
            sliver: SliverPadding(
              padding: const EdgeInsets.only(left: 20, right: 20, bottom: 16),
              sliver: SliverMainAxisGroup(
                slivers: [
                  SliverPadding(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    sliver: SliverToBoxAdapter(
                      child: Text(
                        "Similar Product",
                        style: bodyLargeSemiBold.copyWith(
                          color: AppColor.neutral900,
                        ),
                      ),
                    ),
                  ),
                  SliverLayoutBuilder(
                    builder: (context, constraint) {
                      if (constraint.crossAxisExtent > 600) {
                        return const ProductsGridTablet();
                      }
                      return const ProductsGridMobile();
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showProductVariantsBottomSheet(
    BuildContext context,
    List<ProductVariantModel> variants,
    bool isContainsSubVariants,
  ) {
    AppBottomSheet.show(
      context,
      title: "List Variants",
      stickyActionBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Divider(height: 0),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Text(
                    "Customize This Product with Your Logo or Brand (Min. order ฿19.893)",
                    style: AppTypography.bodySmallSemiBold.copyWith(
                      color: AppColors.neutral[900],
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                SecondaryButton(
                  label: "Customize ->",
                  appButtonSize: AppButtonSize.xsmall,
                  onTap: () {
                    print("Customize order");
                  },
                ),
              ],
            ),
          ),
          const Divider(height: 0),
          Padding(
            padding: const EdgeInsets.only(
              left: 20,
              right: 20,
              top: 12,
              bottom: 8,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Text(
                    "Total Order",
                    style: AppTypography.bodyMediumRegular.copyWith(
                      color: AppColors.neutral[600],
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  "Total Order",
                  style: AppTypography.bodyLargeSemiBold.copyWith(
                    color: AppColors.neutral[900],
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.only(
              left: 20,
              right: 20,
              top: 8,
              bottom: 16,
            ),
            child: PrimaryButton(
              label: "Calculate",
              onTap: () {
                AppDialog.showAppOkDialog(
                  context,
                  subtitle: "This is dialog",
                  content: "This is the dialog content",
                  okCaption: "OK",
                );
              },
            ),
          ),
        ],
      ),
      slivers:
          (context) => [
            PinnedHeaderSliver(
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.only(
                  left: 20,
                  right: 20,
                  top: 16,
                  bottom: 12,
                ),
                decoration: BoxDecoration(color: AppColors.neutral[0]),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: AppColors.neutral[50],
                    border: Border.all(color: AppColors.neutral[200]!),
                  ),
                  child: Row(
                    spacing: 4,
                    children: [
                      const Icon(UniconsLine.info_circle),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        spacing: 2,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Minimum order 1 Pcs",
                            style: AppTypography.bodySmallMedium.copyWith(
                              color: AppColors.neutral[700],
                            ),
                          ),
                          Text(
                            "Minimum order \$200",
                            style: AppTypography.bodySmallMedium.copyWith(
                              color: AppColors.neutral[700],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Container(
                padding: const EdgeInsets.only(left: 20, right: 20, bottom: 8),
                child: Column(
                  spacing: 4,
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Variant",
                      style: AppTypography.bodyMediumSemiBold.copyWith(
                        color: AppColors.neutral[900],
                      ),
                    ),
                    if (!isContainsSubVariants) ...[
                      Text(
                        "Only quoted variants are ready to add to cart. Unquoted variants will be reviewed first to calculate the best price.",
                        style: AppTypography.captionRegular.copyWith(
                          color: AppColors.neutral[600],
                        ),
                      ),
                    ] else ...[
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children:
                            variants
                                .map(
                                  (e) => Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 8,
                                      vertical: 4,
                                    ),
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: AppColors.neutral[200]!,
                                      ),
                                      borderRadius: BorderRadius.circular(6),
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        if (e.url != null) ...[
                                          SizedBox(
                                            width: 24,
                                            height: 24,
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(4),
                                              child: Image.network(e.url!),
                                            ),
                                          ),
                                          const SizedBox(width: 4),
                                        ] else ...[
                                          const Icon(
                                            Icons.broken_image,
                                            size: 24,
                                          ),
                                          const SizedBox(width: 4),
                                        ],
                                        Flexible(
                                          child: Text(
                                            "${e.valueidn}",
                                            overflow: TextOverflow.ellipsis,
                                            style: AppTypography
                                                .bodySmallSemiBold
                                                .copyWith(
                                                  color: AppColors.neutral[700],
                                                ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                                .toList(),
                      ),
                      const SizedBox(height: 4),
                      const Divider(height: 0),
                      const SizedBox(height: 4),
                      Text(
                        "Subvariants",
                        style: AppTypography.bodyMediumSemiBold.copyWith(
                          color: AppColors.neutral[900],
                        ),
                      ),
                      Text(
                        "Only quoted variants are ready to add to cart. Unquoted variants will be reviewed first to calculate the best price.",
                        style: AppTypography.captionRegular.copyWith(
                          color: AppColors.neutral[600],
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              sliver: SliverList.separated(
                separatorBuilder:
                    (context, index) => Divider(color: AppColors.neutral[100]!),
                itemBuilder: (_, index) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const ForestTag(label: "Quoted"),
                          const SizedBox(height: 4),
                          Text(
                            "XS",
                            style: AppTypography.bodyMediumRegular.copyWith(
                              color: AppColors.neutral[900],
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            "B94,28",
                            style: AppTypography.bodyMediumSemiBold.copyWith(
                              color: AppColors.neutral[900],
                            ),
                          ),
                        ],
                      ),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 5,
                            ),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: AppColors.neutral[100]!,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Row(
                              spacing: 8,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                AppClickableWidget(
                                  onTap: () {
                                    print("Minus");
                                  },
                                  child: const SizedBox(
                                    height: 12,
                                    width: 12,
                                    child: Icon(UniconsLine.minus, size: 12),
                                  ),
                                ),
                                const Text("1"),
                                AppClickableWidget(
                                  onTap: () {
                                    print("plus");
                                  },
                                  child: const SizedBox(
                                    height: 12,
                                    width: 12,
                                    child: Icon(UniconsLine.plus, size: 12),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: "Available: ",
                                  style: AppTypography.bodySmallRegular
                                      .copyWith(color: AppColors.neutral[600]),
                                ),
                                TextSpan(
                                  text: "158",
                                  style: AppTypography.bodySmallSemiBold
                                      .copyWith(color: AppColors.neutral[700]),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
    );
  }

  void _showCommodityAttributesBottomSheet(
    BuildContext context,
    List<ProductAttributeModel> attributes,
  ) {
    AppBottomSheet.show(
      context,
      title: "Commodity Attributes",
      slivers:
          (context) => [
            SliverPadding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20.0,
                vertical: 16,
              ),
              sliver: SliverMasonryGrid(
                mainAxisSpacing: 8,
                crossAxisSpacing: 8,
                gridDelegate:
                    const SliverSimpleGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                    ),
                delegate: SliverChildBuilderDelegate(
                  childCount: attributes.length,
                  (context, index) => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        attributes[index].attributeNameTrans ?? "-",
                        style: AppTypography.bodySmallRegular.copyWith(
                          color: AppColors.neutral[600],
                        ),
                      ),
                      Flexible(
                        child: Text(
                          attributes[index].valueTrans ?? "-",
                          style: AppTypography.bodyMediumSemiBold.copyWith(
                            color: AppColors.neutral[900],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
    );
  }
}

class ProductsGridMobile extends StatefulWidget {
  const ProductsGridMobile({super.key});

  @override
  State<ProductsGridMobile> createState() => _ProductsGridMobileState();
}

class _ProductsGridMobileState extends State<ProductsGridMobile> {
  Widget? _child;

  @override
  Widget build(BuildContext context) {
    _child ??= SliverGrid.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 16,
        crossAxisSpacing: 16,
        childAspectRatio: 167 / 266,
      ),
      itemCount: 10,
      itemBuilder:
          (_, index) => ProductCard(
            productName: LoremIpsumGenerator.generate(),
            productPrice: Random().nextInt(500),
          ),
    );
    return _child!;
  }
}

class ProductsGridTablet extends StatefulWidget {
  const ProductsGridTablet({super.key});

  @override
  State<ProductsGridTablet> createState() => _ProductsGridTabletState();
}

class _ProductsGridTabletState extends State<ProductsGridTablet> {
  Widget? _child;

  @override
  Widget build(BuildContext context) {
    _child ??= SliverGrid.builder(
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 167,
        mainAxisSpacing: 16,
        crossAxisSpacing: 16,
        childAspectRatio: 167 / 266,
      ),
      itemCount: 10,
      itemBuilder:
          (_, index) => ProductCard(
            productName: LoremIpsumGenerator.generate(),
            productPrice: Random().nextInt(500),
          ),
    );
    return _child!;
  }
}

class VideoProduct extends StatefulWidget {
  const VideoProduct({super.key, required this.videoUrl});

  final String videoUrl;

  @override
  State<VideoProduct> createState() => _VideoProductState();
}

class _VideoProductState extends State<VideoProduct> {
  late VideoPlayerController _videoPlayerController;
  ChewieController? _chewieController;

  @override
  void initState() {
    super.initState();
    initializePlayer();
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    _chewieController?.dispose();
    super.dispose();
  }

  Future<void> initializePlayer() async {
    _videoPlayerController = VideoPlayerController.networkUrl(
      Uri.parse(widget.videoUrl),
    );

    await _videoPlayerController.initialize();
    _createChewieController();
    setState(() {});
  }

  void _createChewieController() {
    _chewieController = ChewieController(
      videoPlayerController: _videoPlayerController,
      autoPlay: false,
      zoomAndPan: false,
      looping: false,
      showSubtitles: false,
      hideControlsTimer: const Duration(seconds: 1),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child:
          _chewieController != null &&
                  _chewieController!.videoPlayerController.value.isInitialized
              ? AspectRatio(
                aspectRatio: 1,
                child: Chewie(controller: _chewieController!),
              )
              : const AspectRatio(aspectRatio: 1, child: RectangleShimmer()),
    );
  }
}

class ProductThumbnail extends StatelessWidget {
  const ProductThumbnail({
    super.key,
    required this.url,
    required this.notifier,
    required this.index,
    required this.imageBuilder,
    required this.carouselSliderController,
  });

  final IndicatorModel notifier;
  final String url;
  final int index;
  final Widget imageBuilder;
  final CarouselSliderController carouselSliderController;

  static Future<Uint8List?> fetchVideoThumbnail(String url) async {
    final memoryImage = await VideoThumbnail.thumbnailData(
      video: url,
      imageFormat: ImageFormat.WEBP,
      maxWidth: 40,
      quality: 90,
    );
    return memoryImage;
  }

  ProductThumbnail.video({
    super.key,
    required this.url,
    required this.notifier,
    required this.index,
    required this.carouselSliderController,
  }) : imageBuilder = FutureBuilder<Uint8List?>(
         future: fetchVideoThumbnail(url),
         builder: (context, snapshot) {
           if (snapshot.hasData) {
             return Image.memory(snapshot.data!, width: 40, fit: BoxFit.fill);
           } else if (snapshot.hasError) {
             return const Icon(Icons.error_outline, color: Colors.red);
           } else {
             return ColoredBox(color: AppColors.neutral[200]!);
           }
         },
       );

  ProductThumbnail.pic({
    super.key,
    required this.url,
    required this.notifier,
    required this.index,
    required this.carouselSliderController,
  }) : imageBuilder = Image.network(url, width: 40, fit: BoxFit.fill);

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: notifier,
      builder: (context, child) {
        return AppClickableWidget(
          onTap: () {
            if (notifier.currentIndex == index) return;
            notifier.setCurrentIndex(index);
            carouselSliderController.jumpToPage(index);
          },
          child: Container(
            width: 40,
            padding: const EdgeInsets.all(2),
            decoration: BoxDecoration(
              border:
                  (notifier.currentIndex == index)
                      ? Border.all(color: Colors.black, width: 2)
                      : null,
            ),
            child: imageBuilder,
          ),
        );
      },
    );
  }
}
