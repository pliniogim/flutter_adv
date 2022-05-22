abstract class BaseViewModel extends BaseViewModelInputs with BaseViewModelOutputs{
  // data/functions that are shared through the app
}

abstract class BaseViewModelInputs {
  void start(); //init function of thw view
  void dispose(); //dispose the view

}

abstract class BaseViewModelOutputs {

}