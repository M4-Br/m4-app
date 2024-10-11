import 'package:app_flutter_miban4/ui/colors/app_colors.dart';
import 'package:app_flutter_miban4/ui/components/appBar/appBar_components.dart';
import 'package:app_flutter_miban4/ui/controllers/notifications/notifications_controller.dart';
import 'package:app_flutter_miban4/ui/screens/home/credit/credit_mutual_available.dart';
import 'package:app_flutter_miban4/ui/screens/home/credit/credit_mutual_vote.dart';
import 'package:app_flutter_miban4/ui/screens/home/credit/credit_screen.dart';
import 'package:app_flutter_miban4/ui/screens/home/groups/create_group/group_invite_screen.dart';
import 'package:app_flutter_miban4/ui/screens/home/groups/group_contribution_id.dart';
import 'package:app_flutter_miban4/ui/screens/home/home_view_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Notifications extends StatefulWidget {
  const Notifications({Key? key}) : super(key: key);

  @override
  State<Notifications> createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  final NotificationsController _notificationsController =
      Get.put(NotificationsController());

  @override
  void initState() {
    super.initState();
    _notificationsController.fetchNotifications();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _notificationsController.fetchNotifications();
  }

  @override
  void dispose() {
    super.dispose();
    _notificationsController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBarDefault(
        title: AppLocalizations.of(context)!.notifications,
        backPage: () =>
            Get.off(() => HomeViewPage(), transition: Transition.leftToRight),
      ),
      body: Obx(
        () => _notificationsController.isLoading.value
            ? const Center(
                child: CircularProgressIndicator(color: secondaryColor),
              )
            : ListView.builder(
                itemCount: _notificationsController
                    .notificationsData.value['data'].length,
                itemBuilder: (context, index) {
                  final notification = _notificationsController
                      .notificationsData.value['data'][index];
                  return Column(
                    children: [
                      ListTile(
                        tileColor: notification['read'] == false
                            ? grey120
                            : Colors.white,
                        title: notification['notification_type_id'] == 12
                            ? Text(
                                AppLocalizations.of(context)!.credit_approved,
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              )
                            : Text(
                                notification['title'] ?? '',
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                        subtitle: Text(notification['description'] ?? ''),
                        onTap: () async {
                          switch (notification['notification_type_id']) {
                            case 1:
                              final String notificationData =
                                  notification['notification_data'];
                              final List<String> parts =
                                  notificationData.split(':');
                              final String id = parts[0];
                              final String invite = parts[1];
                              await _notificationsController
                                  .makeRead(notification['id'].toString());
                              Get.to(() => GroupInvite(id: id, invite: invite),
                                  transition: Transition.rightToLeft);
                              break;
                            case 7:
                              final String notificationData =
                              notification['notification_data'];
                              final List<String> parts =
                              notificationData.split(':');
                              final String id = parts[0];
                              final String payment = parts[1];
                              Get.to(() => Contribution(
                                  id: payment,
                                  pay: 0,
                                  groupID: '',
                                  type: 'notifications_pay'));
                              break;
                            case 11:
                              final String notificationData =
                                  notification['notification_data'];
                              final List<String> parts =
                                  notificationData.split(':');
                              final String groupId = parts[0];
                              final String vote = parts[1];
                              await _notificationsController
                                  .makeRead(notification['id'].toString());
                              Get.to(
                                  () => CreditMutualVote(
                                      groupId: groupId, vote: vote),
                                  transition: Transition.rightToLeft);
                              break;
                            case 12:
                              _notificationsController
                                  .makeRead(notification['id'].toString());
                              Get.to(() => const CreditScreen(),
                                  transition: Transition.rightToLeft);
                              break;
                            case 18:
                              final String notificationData =
                                  notification['notification_data'];
                              Get.to(
                                  () => CreditMutualAvailable(
                                        id: notificationData,
                                        page: 1,
                                      ),
                                  transition: Transition.rightToLeft);
                              break;
                            default:
                              await _notificationsController
                                  .makeRead(notification['id'].toString());
                              break;
                          }
                        },
                      ),
                    ],
                  );
                },
              ),
      ),
    );
  }
}
