import 'package:get/get.dart';

class EpsNominationController extends GetxController{
  RxString birthDateStr="".obs;
  List selectedPayMethod=new List();
  RxBool check1=false.obs;
  RxBool check2=false.obs;
  RxBool check3=false.obs;
  RxBool yes=false.obs;
  RxBool readAgreement=false.obs;
  RxBool no=false.obs;
  RxBool pay=false.obs;
  RxBool nonPayment=false.obs;
  RxBool payOrNot=false.obs;
  RxString mBirthDate="".obs;
  RxBool visibleAlert = true.obs;
  var selectedDate = DateTime.now().obs;
  List<String> months = [
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'May',
    'Jun',
    'Jul',
    'Aug',
    'Sep',
    'Oct',
    'Nov',
    'Dec'
  ];
  setDate(DateTime dateTime){
    selectedDate.value = dateTime;
    DateTime now = DateTime.now();
    int days = now.difference(dateTime).inDays;
    double age = days/365;
    if(16<=age && age<=59)
      payOrNot.value = true;
    else {
      payOrNot.value = false;
      no.value = false;
    }
    onBirthDateConfirm(dateTime);
  }
  onBirthDateConfirm(DateTime birthDate){
    // birthDateStr.value= DateFormat.yMMMd().format(birthDate);
    birthDateStr.value= birthDate.day.toString()+" "+months[birthDate.month-1]+" "+birthDate.year.toString();
    mBirthDate.value =  birthDate.toString().substring(0,10);
  }
  onPayCheck(){
    pay.value = !pay.value;
  }
  onReadAgreementCheck(){
    readAgreement.value = !readAgreement.value;
  }
  onYesCheck(){
    yes.value = true;
    if(no.value == true)
      no.value = false;
    selectedPayMethod.clear();

  }
  onNoCheck(){
    no.value = true;
    if(yes.value == true)
      yes.value = false;
  }
  onCheckPress1(){
    check1.value = !check1.value;
  }
  onCheckPress2(){
    check2.value = !check2.value;
  }
  onCheckPress3(){
    check3.value = !check3.value;
  }
  payMethod(List method){
    selectedPayMethod = method;
  }



}