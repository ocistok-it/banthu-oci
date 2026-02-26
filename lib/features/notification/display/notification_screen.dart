import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:unicons/unicons.dart';

import '../../../app/themes/app_colors.dart';
import '../../../app/themes/app_typography.dart';
import '../../../app/widgets/app_clickable_widget.dart';
import '../../../app/widgets/app_icon_with_badge.dart';
import '../../../core/dependencies/injector.dart';
import '../domain/usecases/notification_usecase.dart';
import 'blocs/notification_bloc/notification_bloc.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:
          (context) =>
              NotificationBloc(usecase: sl<NotificationUsecase>())
                ..add(InitialNotificationRequested()),
      child: const NotificationView(),
    );
  }
}

class NotificationView extends StatefulWidget {
  const NotificationView({super.key});

  @override
  State<NotificationView> createState() => _NotificationViewState();
}

class _NotificationViewState extends State<NotificationView> {
  final ItemScrollController itemScrollController = ItemScrollController();
  final ItemPositionsListener itemPositionsListener =
      ItemPositionsListener.create();
  static const int _scrollThresold = 20;

  @override
  void initState() {
    super.initState();
    itemPositionsListener.itemPositions.addListener(_scrollListener);
  }

  @override
  void dispose() {
    itemPositionsListener.itemPositions.removeListener(_scrollListener);
    super.dispose();
  }

  void _scrollListener() {
    final positions = itemPositionsListener.itemPositions.value;
    if (positions.isEmpty) return;

    final bloc = context.read<NotificationBloc>();
    if (bloc.state is! NotificationLoadComplete) return;

    final readyState = bloc.state as NotificationLoadComplete;

    if (!readyState.isPagingForward &&
        positions.last.index >=
            readyState.notifications.length - _scrollThresold) {
      bloc.add(NextNotificationRequested());
    }

    if (!readyState.isPagingBackward &&
        positions.first.index <= _scrollThresold &&
        readyState.globalStartIndex > 0) {
      bloc.add(PrevNotificationRequested());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Notifications"),
        actionsPadding: const EdgeInsets.only(right: 12),
        actions: [
          IconButton(
            onPressed: () {},
            icon: AppIconWithBadge.empty(
              icon: const Icon(UniconsLine.shopping_cart),
            ),
          ),
        ],
      ),
      body: BlocBuilder<NotificationBloc, NotificationState>(
        builder: (context, state) {
          if (state is NotificationLoadInProgress) {
            return const Center(child: Text("Loading.."));
          } else if (state is NotificationLoadComplete) {
            if (state.notifications.isEmpty) {
              return const Center(child: Text("Notification is empty"));
            }
            return ScrollablePositionedList.separated(
              itemPositionsListener: itemPositionsListener,
              itemScrollController: itemScrollController,
              itemCount: state.notifications.length,
              separatorBuilder:
                  (_, _) => const Divider(height: 0, color: Color(0xffE7E7E7)),
              itemBuilder: (_, index) {
                final notification = state.notifications[index];
                return NotificationBody(
                  iconUrl: notification.message!.imageUrl!,
                  title: notification.message!.title!,
                  content: notification.message!.content!,
                  date: notification.date!,
                  isNew: notification.isNew!,
                );
              },
            );
          } else if (state is NotificationLoadFailure) {
            return Center(child: Text(state.errorMessage));
          } else {
            return const SizedBox.shrink();
          }
        },
      ),
      bottomNavigationBar: BlocBuilder<NotificationBloc, NotificationState>(
        builder: (context, state) {
          if (state is NotificationLoadComplete) {
            if (state.notifications.any((e) => e.isNew!)) {
              return BottomAppBar(
                height: 60,
                color: AppColor.neutral0,
                child: TextButton(
                  onPressed: () {
                    context.read<NotificationBloc>().add(
                      MarkAllAsReadRequested(),
                    );
                  },
                  child: Text(
                    "Mark all as read",
                    style: bodySmallSemiBold.copyWith(
                      color: AppColor.neutral600,
                    ),
                  ),
                ),
              );
            }
            return const SizedBox.shrink();
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}

class NotificationBody extends StatelessWidget {
  const NotificationBody({
    super.key,
    required this.iconUrl,
    required this.title,
    required this.content,
    required this.date,
    required this.isNew,
  });

  final String iconUrl;
  final String title;
  final String content;
  final String date;
  final bool isNew;

  @override
  Widget build(BuildContext context) {
    return AppClickableWidget(
      onTap: () {
        print("OK");
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        decoration: BoxDecoration(
          color: isNew ? AppColor.brandPrimary25 : AppColor.neutral0,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 16,
          children: [
            iconUrl.isEmpty
                ? const Icon(
                  Icons.image_not_supported,
                  size: 24,
                  color: AppColor.brandPrimary400,
                )
                : Image.network(
                  iconUrl,
                  filterQuality: FilterQuality.high,
                  width: 24,
                  height: 24,
                  fit: BoxFit.fill,
                ),
            Expanded(
              child: Column(
                spacing: 4,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: bodyMediumSemiBold.copyWith(
                      color: AppColor.neutral900,
                    ),
                  ),
                  Text(content, style: bodyMediumRegular),
                  Text(
                    date,
                    style: bodySmallRegular.copyWith(
                      color: AppColor.neutral600,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
