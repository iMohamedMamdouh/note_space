import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:note_space/cubits/add_note_cubit/add_note_cubit.dart';
import 'package:note_space/models/note_model.dart';
import 'package:note_space/views/widgets/colors_list_view.dart';
import 'package:note_space/views/widgets/custom_button.dart';
import 'package:note_space/views/widgets/custom_textfield.dart';
import 'package:uuid/uuid.dart'; // Import uuid package

class AddNoteForm extends StatefulWidget {
  const AddNoteForm({
    super.key,
  });

  @override
  State<AddNoteForm> createState() => _AddNoteFormState();
}

class _AddNoteFormState extends State<AddNoteForm> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;

  String? title, subtitle;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      autovalidateMode: autovalidateMode,
      child: Column(
        children: [
          CustomTextfield(
            onSaved: (value) {
              title = value;
            },
            hintText: 'Title',
          ),
          CustomTextfield(
            onSaved: (value) {
              subtitle = value;
            },
            hintText: 'Content',
            maxlines: 7,
            isRequired: false, // Content field is optional
          ),
          const ColorsListView(),
          BlocBuilder<AddNoteCubit, AddNoteState>(
            builder: (context, state) {
              return CustomButton(
                isloading: state is AddNoteLoading ? true : false,
                onTap: () {
                  if (formKey.currentState!.validate()) {
                    formKey.currentState!.save();

                    DateTime now = DateTime.now();
                    DateFormat formatter = DateFormat.yMd();
                    String formattedDate = formatter.format(now);

                    var noteModel = NoteModel(
                      id: const Uuid().v4(), // Generate a unique ID
                      title: title!,
                      content: subtitle!,
                      date: formattedDate,
                      color: Colors.blue.value,
                    );

                    BlocProvider.of<AddNoteCubit>(context).addNote(noteModel);
                  } else {
                    setState(() {
                      autovalidateMode = AutovalidateMode.always;
                    });
                  }
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
