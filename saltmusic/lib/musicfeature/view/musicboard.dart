import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:saltmusic/musicfeature/view/notifier.dart';
import 'package:saltmusic/musicfeature/view/searchtextfield.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: context.read<MusicNotifier>().getMusicList(),
        builder: (_, s) {
          if (s.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else {
            return Consumer<MusicNotifier>(
              builder: (__, mvalue, _) {
                return Scaffold(
                  body: SafeArea(
                    child: Column(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 16,
                            ),
                            child: Column(
                              children: [
                                POTextField(
                                  keyboardType: TextInputType.text,
                                  onSaved: (v) => null,
                                  onChanged: (v) {},
                                  title: "Search",
                                  hintText: 'What bank are you searching for ?',
                                ),
                                const SizedBox(height: 16),
                                Expanded(
                                  child: GridView.builder(
                                    gridDelegate:
                                        SliverGridDelegateWithFixedCrossAxisCount(
                                      childAspectRatio: MediaQuery.of(context)
                                              .size
                                              .width /
                                          (MediaQuery.of(context).size.height /
                                              1.35),
                                      crossAxisCount: 2,
                                    ),
                                    itemCount: 5,
                                    itemBuilder: (context, i) {
                                      // var entry = mvalue.results[i];

                                      return InkWell(
                                        onTap: () {},
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              right: 16, bottom: 16),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Expanded(
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            3),
                                                    image: DecorationImage(
                                                      image: NetworkImage(
                                                          "https://is1-ssl.mzstatic.com/image/thumb/Music126/v4/3d/ad/4c/3dad4c9b-421e-0052-0b25-1a7e09dd7c4e/23UMGIM50920.rgb.jpg/55x55bb.png"),
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                height: 2,
                                              ),
                                              Text(
                                                'USD 5000',
                                              ),
                                              Text(
                                                'USD 5000',
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }
        });
  }
}
