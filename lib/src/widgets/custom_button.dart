import 'package:flutter/material.dart';

class CustomButton extends StatefulWidget {
  const CustomButton({super.key, this.color, this.borderColor, this.callback, this.height, this.width, this.elevation, this.borderRadius, this.marginTop, this.marginBottom, this.child, this.alignmentChild});

  final Color? color;  //LA INTERROGACIÓN EN LAS VARIABLES LAS HACE OPCIONALES, POR TANTO NO SON OBLIGATORIAS Y SE PUEDEN ASUMIR//
  final Color? borderColor;
  final VoidCallback? callback;
  final double? height;
  final double? width;
  final double? elevation;
  final double? borderRadius;
  final double? marginTop;
  final double? marginBottom;
  final Widget? child;
  final Alignment? alignmentChild;

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  get marginBottom => null;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: (widget.height ?? 48),
      width: widget.width,
      margin: EdgeInsets.only(top: widget.marginTop ?? 0, bottom: widget.marginBottom ?? 0),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0), // aqui hay una verificacion: "widget.borderRadius == null ? Constants.radius : widget.borderRadius!" pero no se usa porque no disponemos del archivo constants
          color: widget.color,
          boxShadow: [
            BoxShadow(
              color: const Color.fromARGB(0, 0, 0, 0),
              offset: Offset(1, (widget.elevation == null ? 1 : widget.elevation!)), //(x,y)
              blurRadius: (widget.elevation == null ? 1 : widget.elevation!),
            ),
          ],
          border: Border.all(color: widget.borderColor == null ? widget.color! : widget.borderColor!)),
      child: MaterialButton(
          padding: const EdgeInsets.all(0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0), //aqui hay una verificacion: "widget.borderRadius == null ? Constants.radius : widget.borderRadius!" pero no se usa porque no disponemos del archivo constants
          ),
          onPressed: widget.callback,
          child: Align(alignment: (widget.alignmentChild == null ? Alignment.center : widget.alignmentChild!), child: widget.child)),
    );
  }
}