String baseurl = 'https://api2.sipatex.co.id:2096';

class MyApi {
  static token() {
    return "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyIjp7ImlkIjoxLCJuYW1hIjoicm9vdCIsImVtYWlsIjoicm9vdEBsb2NhbGhvc3QifSwiaWF0IjoxNTkyMjM1MzE2fQ.KHYQ0M1vcLGSjJZF-zvTM5V44hM0B8TqlTD0Uwdh9rY";
  }

  static cekKoin(cardID) {
    return "$baseurl/CoinChange/Cek?CardID=$cardID";
  }

  static tukar(cardID, shopID, shiftID) {
    return "$baseurl/CoinChange/Tukar?CardID=$cardID&ShopID=$shopID&ShiftID=$shiftID";
  }
  static tukarKantin(cardID, shiftID) {
    return "$baseurl/CoinChange/TukarKantin?CardID=$cardID&ShiftID=$shiftID";
  }
  static login(userName, userPass){
    return "$baseurl/CoinChange/CekLogin?UserName=$userName&UserPass=$userPass";
  }
  static getReport(outletID, tglAwal, tglAkhir){
    return "$baseurl/CoinChange/GetReport?OutletID=$outletID&AwalPeriode=$tglAwal&AkhirPeriode=$tglAkhir";
  }
  static getShift(barcode){
    return "$baseurl/CoinChange/GetShift?Barcode=$barcode";
  }
  static changePassOutlet(outletID, oldPassword, newPassword){
    return "$baseurl/CoinChange/ChangePass1?OutletID=$outletID&OldPassword=$oldPassword&NewPassword=$newPassword";
  }
}
