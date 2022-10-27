part of 'generate_pdf_cubit.dart';

@immutable
abstract class GeneratePdfState {}

class GeneratePdfInitial extends GeneratePdfState {}

class GeneratePdfMessage extends GeneratePdfState{
  final String? message;

  GeneratePdfMessage({this.message});
}
