import 'package:face_graph_task/app/data/models/chair.dart';
import 'package:face_graph_task/app/modules/home/components/chair_card.dart';
import 'package:face_graph_task/app/routes/app_pages.dart';
import 'package:face_graph_task/app/services/cache_service.dart';
import 'package:face_graph_task/app/utilities/app_util.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('FaceQraph Task (Abdelrahuman Fikry)'),
        centerTitle: false,
      ),
      body: StreamBuilder<Iterable<Chair>?>(
        stream: CacheService.to.chairRepo.valuesStream,
        builder: (context, snapShot) {
          if (snapShot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else {
            if (snapShot.data == null || snapShot.data!.isEmpty) {
              return const Center(child: Text('There is no data added yet'));
            } else {
              final allChairs = snapShot.data!.toList();
              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    child: Text(
                      'Press card to edit or swipe left to delete it',
                      style: AppUtil.textStyle(
                        color: Theme.of(context).errorColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 40.sp,
                      ),
                    ),
                  ),
                  Expanded(
                    child: ListView(
                      children: allChairs
                          .map(
                            (chair) => ChairCard(
                              chair: chair,
                            ),
                          )
                          .toList(),
                    ),
                  ),
                ],
              );
            }
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
        onPressed: () => Get.toNamed(Routes.ADD_EDIT_CHAIR),
      ),
    );
  }
}
