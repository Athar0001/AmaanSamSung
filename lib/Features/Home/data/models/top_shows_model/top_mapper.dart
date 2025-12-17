import '../home/reals_model.dart';
import '../home/show_details_model/data.dart';

extension MapperTopModel on ReelModel? {
  Details toDomain() {
    return Details(
      id: this?.id ?? '',
      presignedUrl: this?.presignedUrl ?? '',
      title: this?.title ?? '',
      thumbnailImage: this?.thumbnailImage,
      description: this?.description ?? '',
      childTakedExam: true,
      isFree: true,
      isGuest: true,
    );
  }
}
