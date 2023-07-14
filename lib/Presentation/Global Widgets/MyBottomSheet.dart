// the widget in the bottom sheet
import 'package:flutter/material.dart';
import 'package:mymoviesapp/Core/Theme/Theme.dart';

class ModalSheetWidget extends StatefulWidget {
  ModalSheetWidget(this.images, this.selectedImage, this.changeSelectedImage,
      {super.key});
  // ScrollController scrollController ;
  List<String> images;
  String selectedImage;
  Function changeSelectedImage;

  @override
  State<ModalSheetWidget> createState() => _ModalSheetWidgetState();
}

class _ModalSheetWidgetState extends State<ModalSheetWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(15),
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20), color: MyTheme.blackTwo),
      child: Column(
        children: [
          Text(
            "Pick Avatar",
            style: Theme.of(context).textTheme.displayMedium,
          ),
          GridView.builder(
            physics: const NeverScrollableScrollPhysics(),
            padding: EdgeInsets.symmetric(vertical: 20),
            // controller: widget.scrollController,
            shrinkWrap: true,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4, childAspectRatio: 1),
            itemBuilder: (context, index) => GestureDetector(
              onTap: () {
                setState(() {
                  widget.selectedImage = widget.images[index];
                });
              },
              child: Container(
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color: widget.selectedImage == widget.images[index]
                        ? MyTheme.gray
                        : MyTheme.blackTwo,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Image.asset(widget.images[index], width: 100)),
            ),
            itemCount: widget.images.length,
          ),
          Container(
            width: double.infinity,
            child: ElevatedButton(
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(MyTheme.gold),
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ))),
              onPressed: () {
                widget.changeSelectedImage(widget.selectedImage);
              },
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  "Confirm",
                  style: Theme.of(context)
                      .textTheme
                      .displaySmall!
                      .copyWith(fontWeight: FontWeight.bold),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
