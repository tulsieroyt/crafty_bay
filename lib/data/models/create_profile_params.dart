class CreateProfileParams {
  String cusName;
  String cusAdd;
  String cusCity;
  String cusState;
  String cusPostcode;
  String cusCountry;
  String cusPhone;
  String cusFax;
  String shipName;
  String shipAdd;
  String shipCity;
  String shipState;
  String shipPostcode;
  String shipCountry;
  String shipPhone;

  CreateProfileParams({
    required this.cusName,
    required this.cusAdd,
    required this.cusCity,
    required this.cusState,
    required this.cusPostcode,
    required this.cusCountry,
    required this.cusPhone,
    required this.cusFax,
    required this.shipName,
    required this.shipAdd,
    required this.shipCity,
    required this.shipState,
    required this.shipPostcode,
    required this.shipCountry,
    required this.shipPhone,
  });

  Map<String, dynamic> toJson() => {
        "cus_name": cusName,
        "cus_add": cusAdd,
        "cus_city": cusCity,
        "cus_state": cusState,
        "cus_postcode": cusPostcode,
        "cus_country": cusCountry,
        "cus_phone": cusPhone,
        "cus_fax": cusFax,
        "ship_name": shipName,
        "ship_add": shipAdd,
        "ship_city": shipCity,
        "ship_state": shipState,
        "ship_postcode": shipPostcode,
        "ship_country": shipCountry,
        "ship_phone": shipPhone,
      };
}
