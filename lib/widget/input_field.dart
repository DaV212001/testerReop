import 'package:flutter/material.dart';
import 'package:flutterflow_ui/flutterflow_ui.dart';
class InputFieldWidget extends StatefulWidget {

  final TextEditingController textEditingController;
  final FocusNode? focusNode;
  final String? Function(String? val) validator;
  final String? Function(String? val)? onChanged;
  bool obscureText;
  final Widget? prefixIcon;
  final String label;
  final bool passwordinput;
  final String? hint;
  final int? maxlength;

  InputFieldWidget(
      {super.key,
        required this.textEditingController,
        required this.focusNode,
        required this.obscureText,
        required this.validator,
        required this.passwordinput,
        required this.label, this.prefixIcon, this.onChanged, this.hint, this.maxlength});

  @override
  State<InputFieldWidget> createState() => _InputFieldWidgetState();
}

class _InputFieldWidgetState extends State<InputFieldWidget> {
  @override
  Widget build(BuildContext context) {
    if (widget.passwordinput) {
      return Padding(
        padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 16),
        child: Container(
          width: double.infinity,
          child: TextFormField(
              controller: widget.textEditingController,
              focusNode: widget.focusNode,
              autofocus: false,
              maxLength: widget.maxlength,
              onChanged: widget.onChanged,
              autofillHints: [AutofillHints.password],
              obscureText: !widget.obscureText??false,
              decoration: InputDecoration(
                labelText: widget.label,
                hintText: widget.hint,
                labelStyle: FlutterFlowTheme.of(context).labelLarge,
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: FlutterFlowTheme.of(context).primaryBackground,
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Color(0xFFFF2C20),
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                errorBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: FlutterFlowTheme.of(context).error,
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: FlutterFlowTheme.of(context).error,
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                filled: true,
                fillColor: FlutterFlowTheme.of(context).primaryBackground,
                suffixIcon: InkWell(
                  onTap: () => setState(
                        () => widget.obscureText = !widget.obscureText,
                  ),
                  focusNode: FocusNode(skipTraversal: true),
                  child: Icon(
                    widget.obscureText!
                        ? Icons.visibility_outlined
                        : Icons.visibility_off_outlined,
                    color: FlutterFlowTheme.of(context).secondaryText,
                    size: 24,
                  ),
                ),
              ),
              style: FlutterFlowTheme.of(context).bodyLarge,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: widget.validator
          ),
        ),
      );
    } else {
      return Padding(
        padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 16),
        child: Container(
          width: double.infinity,
          child: TextFormField(
            controller: widget.textEditingController,
            focusNode: widget.focusNode,
            autofocus: false,
            maxLength: widget.maxlength,
            onChanged: widget.onChanged,
            autofillHints: [AutofillHints.password],
            obscureText: widget.obscureText!,
            decoration: InputDecoration(
              icon: widget.prefixIcon,
              labelText: widget.label,
              hintText: widget.hint,
              labelStyle: FlutterFlowTheme.of(context).labelLarge,
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: FlutterFlowTheme.of(context).primaryBackground,
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Color(0xFFFF2C20),
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              errorBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: FlutterFlowTheme.of(context).error,
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: FlutterFlowTheme.of(context).error,
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              filled: true,
              fillColor: FlutterFlowTheme.of(context).primaryBackground,
            ),
            style: FlutterFlowTheme.of(context).bodyLarge,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: widget.validator,
          ),
        ),
      );
    }
  }
}
