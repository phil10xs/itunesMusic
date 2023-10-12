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
  List<dynamic> listed = [];
  @override
  void initState() {
    // TODO: implement initState
    getData();
    super.initState();
  }

  getData() async {
    var res = await context.read<MusicNotifier>().getMusicList();
    listed = res.data;
  }

  @override
  Widget build(BuildContext context) {
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
                          onTap: () {},
                          keyboardType: TextInputType.text,
                          onSaved: (v) => null,
                          onChanged: (v) {
                            mvalue.setfilteredMusicX = mvalue.filteredMusicX(v);
                          },
                          title: "Search",
                          hintText: 'What music are you searching for ?',
                        ),
                        const SizedBox(height: 16),
                        Expanded(
                          child: GridView.builder(
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              childAspectRatio: MediaQuery.of(context)
                                      .size
                                      .width /
                                  (MediaQuery.of(context).size.height / 1.35),
                              crossAxisCount: 2,
                            ),
                            itemCount: mvalue.filteredMusic.length,
                            itemBuilder: (context, i) {
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
                                                BorderRadius.circular(3),
                                            image: DecorationImage(
                                              image: NetworkImage(
                                                  mvalue.filteredMusic[i]
                                                      ["im:image"][0]["label"]),
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 2,
                                      ),
                                      Text(mvalue.filteredMusic[i]["im:name"]
                                              ["label"]
                                          .toString()),
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
}
