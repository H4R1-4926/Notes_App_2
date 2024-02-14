// ignore_for_file: no_leading_underscores_for_local_identifiers, must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:get/get.dart';
import 'package:yt_dupe/Application/Home_Bloc/home_bloc.dart';

import 'package:yt_dupe/Core/colors.dart';
import 'package:yt_dupe/Domain/Home/model/home_model.dart';
import 'package:yt_dupe/Infrastructre/Home/home_repository.dart';

enum Actiontype {
  addnote,
  editnote,
}

class CreateOrEditPage extends StatelessWidget {
  final Actiontype type;
  String? id;
  final int idd;
  CreateOrEditPage({super.key, required this.type, required this.idd, this.id});

  final _titlecontroller = TextEditingController();
  final _contentcontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        if (type == Actiontype.editnote) {
          final note = state.getAlldata;
          final n = note[idd];
          _titlecontroller.text = n.title ?? '';
          _contentcontroller.text = n.content ?? '';
        }
        return Scaffold(
            backgroundColor: kblackcolor,
            appBar: AppBar(
              actions: [
                IconButton(
                    onPressed: () {
                      switch (type) {
                        case Actiontype.addnote:
                          savenote();
                          context.read<HomeBloc>().add(const Saved());
                          break;
                        case Actiontype.editnote:
                          saveeditednote();
                          context.read<HomeBloc>().add(const Updated());
                          break;
                        default:
                      }
                      Get.back();
                    },
                    icon: const Icon(
                      Icons.save_outlined,
                      size: 30,
                    ))
              ],
              title: Text(
                type.name.toUpperCase(),
                style: const TextStyle(color: kblackcolor, fontSize: 25),
              ),
              backgroundColor: kbluecolor,
              foregroundColor: kblackcolor,
            ),
            body: ListView(
              children: [
                Column(
                  children: [
                    TextFormField(
                      controller: _titlecontroller,
                      cursorColor: kbluecolor,
                      cursorHeight: 25,
                      style: const TextStyle(color: kwhitecolor, fontSize: 25),
                      decoration: const InputDecoration(
                          hintText: 'Title',
                          hintStyle: TextStyle(color: kgreycolor, fontSize: 25),
                          border:
                              OutlineInputBorder(borderSide: BorderSide.none)),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    TextFormField(
                      controller: _contentcontroller,
                      maxLines: null,
                      cursorColor: kbluecolor,
                      style: const TextStyle(color: kwhitecolor),
                      decoration: const InputDecoration(
                          hintText: 'Note',
                          hintStyle: TextStyle(color: kgreycolor),
                          border:
                              OutlineInputBorder(borderSide: BorderSide.none)),
                    )
                  ],
                ),
              ],
            ));
      },
    );
  }

  Future<void> savenote() async {
    final text = _titlecontroller.text;
    final content = _contentcontroller.text;

    final _newnote = NoteModel(
      id: DateTime.now().microsecondsSinceEpoch.toString(),
      title: text,
      content: content,
    );
    if (text.isNotEmpty || content.isNotEmpty) {
      return Notes().createNote(_newnote);
    } else {
      Get.back();
    }
  }

  Future<void> saveeditednote() async {
    final text = _titlecontroller.text;
    final content = _contentcontroller.text;

    final _newnote = NoteModel(
      id: id ?? '',
      title: text,
      content: content,
    );

    Notes().updateNote(_newnote);
  }
}
