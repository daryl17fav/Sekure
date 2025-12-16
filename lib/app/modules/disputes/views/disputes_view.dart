import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/disputes_controller.dart';
import '../../../../widgets/core_widgets.dart';
import '../../../../utils/colors.dart';
import '../../../../composants/list_composants.dart';

class DisputesView extends GetView<DisputesController> {
  const DisputesView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const SekureAppBar(title: "Litiges"),
      body: Column(
        children: [
          const SizedBox(height: 20),
          // Tabs
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Obx(() => Row(
              children: List.generate(3, (index) {
                return TabWidget(
                  text: controller.getTabLabel(index),
                  isSelected: controller.selectedTab.value == index,
                  onTap: () => controller.selectTab(index),
                );
              }),
            )),
          ),
          const SizedBox(height: 20),

          // Grid
          Expanded(
            child: Obx(() {
              if (controller.isLoading.value) {
                return const GridShimmerLoader(itemCount: 6, childAspectRatio: 0.75);
              }
              
              return GridView.count(
                crossAxisCount: 2,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                mainAxisSpacing: 15,
                crossAxisSpacing: 15,
                childAspectRatio: 0.75,
                children: List.generate(6, (index) => const DisputeCard(
                  image: 'https://i.pravatar.cc/150?img=33',
                  productName: "Nom de l'article",
                  clientName: "M. Martins AZEMIN",
                  price: "12.000 Fcfa",
                )),
              );
            }),
          ),
        ],
      ),
    );
  }
}