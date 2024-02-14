import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:yt_dupe/Application/Home_Bloc/home_bloc.dart';
import 'package:yt_dupe/Core/colors.dart';
import 'package:yt_dupe/Domain/Home/model/home_model.dart';
import 'package:yt_dupe/Infrastructre/Home/home_repository.dart';
import 'package:yt_dupe/Presentation/CreatePage/add_create.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<HomeBloc>().add(const HomeEvent.started());
    });
    return Scaffold(
      backgroundColor: kblackcolor,
      appBar: AppBar(
        title: const Text(
          'Notes',
          style: TextStyle(fontSize: 25, color: kblackcolor),
        ),
        centerTitle: true,
        backgroundColor: kbluecolor,
      ),
      body: BlocConsumer<HomeBloc, HomeState>(
        listener: (context, state) {
          if (state.getAlldata.isNotEmpty) {
            state.getAlldata;
          }
        },
        builder: (context, state) {
          if (state.getAlldata.isEmpty) {
            return const Center(
              child: Text(
                'Click + to Add Note',
                style: TextStyle(color: kgreycolor),
              ),
            );
          }
          final data = state.getAlldata;
          return GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 2,
              crossAxisSpacing: 2,
            ),
            itemCount: data.length,
            itemBuilder: (BuildContext context, int index) {
              final d = data[index];

              return Padding(
                padding: const EdgeInsets.only(left: 5, right: 5, top: 5),
                child: GestureDetector(
                  onTap: () => Get.to(() => CreateOrEditPage(
                        type: Actiontype.editnote,
                        idd: index,
                        id: d.id,
                      )),
                  child: ContainerWidget(d: d),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(() => CreateOrEditPage(
                type: Actiontype.addnote,
                idd: 0,
              ));
        },
        tooltip: 'New',
        backgroundColor: kbluecolor,
        child: const Icon(
          Icons.add,
          color: kblackcolor,
          size: 40,
        ),
      ),
    );
  }
}

class ContainerWidget extends StatelessWidget {
  const ContainerWidget({
    super.key,
    required this.d,
  });

  final NoteModel d;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 20,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: kgreycolor)),
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Text(
                    d.title ?? "No Title",
                    style: const TextStyle(
                        overflow: TextOverflow.ellipsis,
                        color: kgreycolor,
                        fontSize: 25),
                  ),
                ),
                Flexible(
                  child: IconButton(
                    tooltip: 'Delete',
                    onPressed: () {
                      Notes().deleteNote(d.id);
                      context.read<HomeBloc>().add(const Deleted());
                    },
                    icon: const Icon(
                      Icons.delete_outline,
                      color: kgreycolor,
                      size: 25,
                    ),
                  ),
                )
              ],
            ),
            Flexible(
              child: Text(
                d.content ?? "",
                maxLines: 6,
                style: const TextStyle(
                    color: kgreycolor, overflow: TextOverflow.ellipsis),
              ),
            )
          ],
        ),
      ),
    );
  }
}
