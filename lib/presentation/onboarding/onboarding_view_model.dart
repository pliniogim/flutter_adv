import 'dart:async';

import 'package:complete_advanced_flutter/presentation/base/base_view_model.dart';
import '../../domain/model.dart';
import '../resources/assets_manager.dart';
import '../resources/strings_manager.dart';

class OnBoardingViewModel extends BaseViewModel
    with OnBoardingViewInputs, OnBoardingViewOutputs {
  //stream controllers
  final StreamController _streamController =
      StreamController<SliderViewObject>();

  late final List<SliderObject> _list;
  int _currentIndex = 0;

  @override
  void dispose() {
    _streamController.close();
  }

  @override
  void start() {
    _list = _getSliderData();
    //send this data to our view
    _postDataToView();
  }

  @override
  int goNext() {
    int nextIndex = _currentIndex++;
    if (nextIndex >= _list.length) {
      _currentIndex = 0;
    }
   return _currentIndex;
  }

  @override
  int goPrevious() {
    int previousIndex = _currentIndex--;
    if (previousIndex == -1) {
      _currentIndex = _list.length - 1;
    }
    return _currentIndex;
  }

  @override
  void onPageChanged(int index) {
    _currentIndex = index;
    _postDataToView();
  }

  //input
  @override
  Sink get inputSliderViewObject => _streamController.sink;

  //output
  @override
  Stream<SliderViewObject> get outputSliderViewObject =>
      _streamController.stream.map((sliderViewObject) => sliderViewObject);

  List<SliderObject> _getSliderData() => [
        SliderObject(
          title: AppStrings.onBoardingTitle1,
          subTitle: AppStrings.onBoardingSubtitle1,
          image: ImageAssets.onBoardingImage1,
        ),
        SliderObject(
          title: AppStrings.onBoardingTitle2,
          subTitle: AppStrings.onBoardingSubtitle2,
          image: ImageAssets.onBoardingImage2,
        ),
        SliderObject(
          title: AppStrings.onBoardingTitle3,
          subTitle: AppStrings.onBoardingSubtitle3,
          image: ImageAssets.onBoardingImage3,
        ),
        SliderObject(
          title: AppStrings.onBoardingTitle4,
          subTitle: AppStrings.onBoardingSubtitle4,
          image: ImageAssets.onBoardingImage4,
        ),
      ];

  _postDataToView() {
    inputSliderViewObject.add(SliderViewObject(
      _list[_currentIndex],
      _list.length,
      _currentIndex,
    ));
  }
}

abstract class OnBoardingViewInputs {
  //orders received by the view
  void goNext(); //next screen
  void goPrevious(); //previous screen
  void onPageChanged(int index);

  Sink get inputSliderViewObject; //this is the way to add data to the stream
}

abstract class OnBoardingViewOutputs {
  //data/results for view
  Stream<SliderViewObject> get outputSliderViewObject;
}

class SliderViewObject {
  SliderObject sliderObject;
  int numbOfSlides;
  int currentIndex;

  SliderViewObject(
    this.sliderObject,
    this.numbOfSlides,
    this.currentIndex,
  );
}
