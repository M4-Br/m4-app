import 'package:app_flutter_miban4/data/api/terms.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:simple_html_css/simple_html_css.dart';

class TermsPage extends StatelessWidget {
  const TermsPage({super.key});

  @override
  Widget build(BuildContext context) {
    late var privacy;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
            onPressed: () => Get.back(),
            icon: const Icon(
              Icons.arrow_back_ios_outlined,
              color: Colors.black,
            )),
      ),
      backgroundColor: Colors.white,
      body: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          FutureBuilder<Map>(
              future: getTerms(),
              builder: (context, snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.none:
                  case ConnectionState.waiting:
                    return const Center(child: CircularProgressIndicator());
                  default:
                    if (snapshot.hasError) {
                      return const Center(
                        child: Text("Erro ao carregar.."),
                      );
                    } else {
                      privacy = HTML.toRichText(context, snapshot.data!['text'],
                          linksCallback: (link) {});

                      return SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Container(
                            child: privacy,
                          ),
                        ),
                      );
                    }
                }
              }),
        ],
      ),
    );
  }
}
