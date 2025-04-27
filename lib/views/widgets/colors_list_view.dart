import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_space/cubits/add_note_cubit/add_note_cubit.dart';

class ColorItem extends StatelessWidget {
  const ColorItem({super.key, required this.isActive, required this.color});

  final bool isActive;

  final Color color;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0, right: 8.0),
      child: isActive
          ? Container(
              padding:
                  const EdgeInsets.all(2), // Adjust the thickness of the border
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white, // Border color
              ),
              child: CircleAvatar(
                radius: 20,
                backgroundColor: color,
              ),
            )
          : CircleAvatar(
              backgroundColor: color,
            ),
    );
  }
}

class ColorsListView extends StatefulWidget {
  const ColorsListView({super.key});

  @override
  State<ColorsListView> createState() => _ColorsListViewState();
}

class _ColorsListViewState extends State<ColorsListView> {
  int currentIndex = 0;

  List<Color> colors = const [
    Color(0xFF4B6858),
    Color(0xFF498C8A),
    Color(0xFF46ACC2),
    Color(0xFF6DAEDB),
    Color(0xFF4D4730),
    Color(0xFFC1AE7C),
    Color(0xFFF1D6B8),
    Color(0xFFE9EBF8),
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 56,
      child: ListView.builder(
        itemCount: colors.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              currentIndex = index;
              BlocProvider.of<AddNoteCubit>(context).color = colors[index];

              setState(() {});
            },
            child: ColorItem(
              color: colors[index],
              isActive: currentIndex == index,
            ),
          );
        },
      ),
    );
  }
}
