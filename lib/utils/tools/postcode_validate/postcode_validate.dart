class PostCodeModel {
  String? countryName;
  String? countryCode;
  List<String>? countryCodeFormat;
  List<int>? countryCodeLength;
  bool? isRequied;

  PostCodeModel(
      {this.countryName,
      this.countryCode,
      this.countryCodeFormat,
      this.countryCodeLength,
      this.isRequied});

  PostCodeModel.fromJson(Map<String, dynamic> json) {
    countryName = json['countryName'];
    countryCode = json['countryCode'];
    countryCodeFormat = json['countryCodeFormat'].cast<String>();
    countryCodeLength = json['countryCodeLength'].cast<int>();
    isRequied = json['isRequied'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['countryName'] = countryName;
    data['countryCode'] = countryCode;
    data['countryCodeFormat'] = countryCodeFormat;
    data['countryCodeLength'] = countryCodeLength;
    data['isRequied'] = isRequied;
    return data;
  }
}

class PostcodeValidate {
  checkPostCode(countryCode, postCode) {
    var valid = '';
    var bMatch = false;

    var postCodeList =
        countiresPostCode.map((e) => PostCodeModel.fromJson(e)).toList();

    var findCountryList = postCodeList
        .where((element) => element.countryCode == countryCode)
        .toList();
    if (findCountryList.isNotEmpty) {
      var findCountry = findCountryList[0];
      if (findCountry.isRequied == true) {
        if (postCode.length == 0) {
          valid = "Enter a ZIP / postal code";
        } else if (!findCountry.countryCodeLength!.contains(postCode.length)) {
          valid =
              "Enter a valid ZIP / postal code for ${findCountry.countryName!}";
        }

        if (valid == '' && findCountry.countryCodeFormat!.isNotEmpty) {
          for (var j = 0; j < findCountry.countryCodeFormat!.length; j++) {
            var regx = "";
            var format = findCountry.countryCodeFormat?[j];
            var curCount = 0;
            for (var i = 0; i < format!.length; i++) {
              var curStr = format.substring(i, i + 1);
              var nextStr = '';
              if (i < format.length - 1) {
                nextStr = format.substring(i + 1, i + 1 + 1);
              }

              if (curStr == "A") {
                if (nextStr.isNotEmpty && nextStr == "A") {
                  curCount++;
                  continue;
                } else {
                  regx += '[a-zA-Z]{${curCount + 1}}';
                  curCount = 0;
                }
              } else if (curStr == "9") {
                if (nextStr.isNotEmpty && nextStr == "9") {
                  curCount++;
                  continue;
                } else {
                  regx += '[0-9]{${curCount + 1}}';
                  curCount = 0;
                }
              } else if (curStr == "-") {
                regx += '[-]';
              } else if (curStr == " ") {
                regx += '\\s?';
              }
            }

            if (regx.isNotEmpty && format.length == postCode.length) {
              var match = RegExp('$regx\$').hasMatch(postCode);
              if (match) {
                bMatch = true;
                break;
              }
            }
          }

          if (!bMatch) {
            valid =
                "Enter a valid ZIP / postal code for ${findCountry.countryName!}";
          }
        }
      }
    }

    return valid;
  }

  static const countiresPostCode = [
    {
      "countryName": 'United States',
      "countryCode": 'US',
      "countryCodeFormat": ['99999', '99999-9999', '999999999', '99999 9999'],
      "countryCodeLength": [5, 9, 10],
      "isRequied": true,
    },
    {
      "countryName": 'United Kingdom',
      "countryCode": 'GB',
      "countryCodeFormat": [
        'AA9A 9AA',
        'A99 9AA',
        'A9A 9AA',
        'A9 9AA',
        'AA99 9AA',
        'AA9 9AA',
        'AA9A 9',
        'AA9A9AA',
        'A999AA',
        'A9A9AA',
        'A99AA',
        'AA999AA',
        'AA99AA',
        'AA9A9'
      ],
      "countryCodeLength": [5, 6, 7, 8],
      "isRequied": true,
    },
    {
      "countryName": 'Australia',
      "countryCode": 'AU',
      "countryCodeFormat": ['9999'],
      "countryCodeLength": [4],
      "isRequied": true,
    },
    {
      "countryName": "Afghanistan",
      "countryCode": "AF",
      "countryCodeFormat": [],
      "countryCodeLength": [],
      "isRequied": false
    },
    {
      "countryName": "Aland Islands",
      "countryCode": "AX",
      "countryCodeFormat": [],
      "countryCodeLength": [],
      "isRequied": false
    },
    {
      "countryName": "Albania",
      "countryCode": "AL",
      "countryCodeFormat": [],
      "countryCodeLength": [],
      "isRequied": false
    },
    {
      "countryName": "Algeria",
      "countryCode": "DZ",
      "countryCodeFormat": ["99999"],
      "countryCodeLength": [5],
      "isRequied": true
    },
    {
      "countryName": "Andorra",
      "countryCode": "AD",
      "countryCodeFormat": ["99999", "AA999"],
      "countryCodeLength": [5],
      "isRequied": true
    },
    {
      "countryName": "Anguilla",
      "countryCode": "AI",
      "countryCodeFormat": [],
      "countryCodeLength": [],
      "isRequied": false
    },
    {
      "countryName": "Antigua And Barbuda",
      "countryCode": "AG",
      "countryCodeFormat": [],
      "countryCodeLength": [],
      "isRequied": false
    },
    {
      "countryName": "Argentina",
      "countryCode": "AR",
      "countryCodeFormat": ["9999"],
      "countryCodeLength": [4],
      "isRequied": true
    },
    {
      "countryName": "Armenia",
      "countryCode": "AM",
      "countryCodeFormat": ["9999"],
      "countryCodeLength": [4],
      "isRequied": true
    },
    {
      "countryName": "Aruba",
      "countryCode": "AW",
      "countryCodeFormat": [],
      "countryCodeLength": [],
      "isRequied": false
    },
    {
      "countryName": "Austria",
      "countryCode": "AT",
      "countryCodeFormat": ["9999"],
      "countryCodeLength": [4],
      "isRequied": true
    },
    {
      "countryName": "Azerbaijan",
      "countryCode": "AZ",
      "countryCodeFormat": ["9999", "999999"],
      "countryCodeLength": [4, 6],
      "isRequied": true
    },
    {
      "countryName": "Angola",
      "countryCode": "AO",
      "countryCodeFormat": [],
      "countryCodeLength": [],
      "isRequied": false
    },
    {
      "countryName": "Bahamas",
      "countryCode": "BS",
      "countryCodeFormat": [],
      "countryCodeLength": [],
      "isRequied": false
    },
    {
      "countryName": "Bahrain",
      "countryCode": "BH",
      "countryCodeFormat": [],
      "countryCodeLength": [],
      "isRequied": false
    },
    {
      "countryName": "Bangladesh",
      "countryCode": "BD",
      "countryCodeFormat": ["9999"],
      "countryCodeLength": [4],
      "isRequied": true
    },
    {
      "countryName": "Barbados",
      "countryCode": "BB",
      "countryCodeFormat": [],
      "countryCodeLength": [],
      "isRequied": false
    },
    {
      "countryName": "Taiwan Region",
      "countryCode": "TW",
      "countryCodeFormat": ["999", "99999"],
      "countryCodeLength": [3, 5],
      "isRequied": true
    },
    {
      "countryName": "Belarus",
      "countryCode": "BY",
      "countryCodeFormat": ["999999"],
      "countryCodeLength": [6],
      "isRequied": true
    },
    {
      "countryName": "Belgium",
      "countryCode": "BE",
      "countryCodeFormat": ["9999"],
      "countryCodeLength": [4],
      "isRequied": true
    },
    {
      "countryName": "Belize",
      "countryCode": "BZ",
      "countryCodeFormat": [],
      "countryCodeLength": [],
      "isRequied": false
    },
    {
      "countryName": "Benin",
      "countryCode": "BJ",
      "countryCodeFormat": [],
      "countryCodeLength": [],
      "isRequied": false
    },
    {
      "countryName": "Bermuda",
      "countryCode": "BM",
      "countryCodeFormat": [],
      "countryCodeLength": [],
      "isRequied": false
    },
    {
      "countryName": "Bhutan",
      "countryCode": "BT",
      "countryCodeFormat": [],
      "countryCodeLength": [],
      "isRequied": false
    },
    {
      "countryName": "Bolivia",
      "countryCode": "BO",
      "countryCodeFormat": [],
      "countryCodeLength": [],
      "isRequied": false
    },
    {
      "countryName": "Bosnia And Herzegovina",
      "countryCode": "BA",
      "countryCodeFormat": ["99999"],
      "countryCodeLength": [5],
      "isRequied": true
    },
    {
      "countryName": "Bonaire, Sint Eustatius and Saba",
      "countryCode": "BQ",
      "countryCodeFormat": [],
      "countryCodeLength": [],
      "isRequied": false
    },
    {
      "countryName": "Botswana",
      "countryCode": "BW",
      "countryCodeFormat": [],
      "countryCodeLength": [],
      "isRequied": false
    },
    {
      "countryName": "Brazil",
      "countryCode": "BR",
      "countryCodeFormat": ["99999", "99999-999", "99999999", "99999 999"],
      "countryCodeLength": [5, 8, 9],
      "isRequied": true
    },
    {
      "countryName": "British Indian Ocean Territory",
      "countryCode": "IO",
      "countryCodeFormat": [],
      "countryCodeLength": [],
      "isRequied": false
    },
    {
      "countryName": "Brunei",
      "countryCode": "BN",
      "countryCodeFormat": ["AA9999"],
      "countryCodeLength": [6],
      "isRequied": true
    },
    {
      "countryName": "Bouvet Island",
      "countryCode": "BV",
      "countryCodeFormat": [""],
      "countryCodeLength": [],
      "isRequied": false
    },
    {
      "countryName": "Bulgaria",
      "countryCode": "BG",
      "countryCodeFormat": ["9999"],
      "countryCodeLength": [4],
      "isRequied": true
    },
    {
      "countryName": "Burkina Faso",
      "countryCode": "BF",
      "countryCodeFormat": [],
      "countryCodeLength": [],
      "isRequied": false
    },
    {
      "countryName": "Burundi",
      "countryCode": "BI",
      "countryCodeFormat": [],
      "countryCodeLength": [],
      "isRequied": false
    },
    {
      "countryName": "Cambodia",
      "countryCode": "KH",
      "countryCodeFormat": ["999999"],
      "countryCodeLength": [6],
      "isRequied": true
    },
    {
      "countryName": "Cape Verde",
      "countryCode": "CV",
      "countryCodeFormat": [],
      "countryCodeLength": [],
      "isRequied": false
    },
    {
      "countryName": "Canada",
      "countryCode": "CA",
      "countryCodeFormat": ["A9A 9A", "A9A 9A9", "A9A9A", "A9A9A9"],
      "countryCodeLength": [5, 6, 7],
      "isRequied": true
    },
    {
      "countryName": "Cayman Islands",
      "countryCode": "KY",
      "countryCodeFormat": [],
      "countryCodeLength": [],
      "isRequied": false
    },
    {
      "countryName": "Central African Republic",
      "countryCode": "CF",
      "countryCodeFormat": [],
      "countryCodeLength": [],
      "isRequied": false
    },
    {
      "countryName": "Chad",
      "countryCode": "TD",
      "countryCodeFormat": [],
      "countryCodeLength": [],
      "isRequied": false
    },
    {
      "countryName": "Chile",
      "countryCode": "CL",
      "countryCodeFormat": [],
      "countryCodeLength": [],
      "isRequied": false
    },
    {
      "countryName": "China",
      "countryCode": "CN",
      "countryCodeFormat": ["999999"],
      "countryCodeLength": [6],
      "isRequied": true
    },
    {
      "countryName": "Christmas Island",
      "countryCode": "CX",
      "countryCodeFormat": [],
      "countryCodeLength": [],
      "isRequied": false
    },
    {
      "countryName": "Cocos (Keeling) Islands",
      "countryCode": "CC",
      "countryCodeFormat": [],
      "countryCodeLength": [],
      "isRequied": false
    },
    {
      "countryName": "Colombia",
      "countryCode": "CO",
      "countryCodeFormat": ["999999"],
      "countryCodeLength": [6],
      "isRequied": true
    },
    {
      "countryName": "Comoros",
      "countryCode": "KM",
      "countryCodeFormat": [],
      "countryCodeLength": [],
      "isRequied": false
    },
    {
      "countryName": "Congo",
      "countryCode": "CG",
      "countryCodeFormat": [],
      "countryCodeLength": [],
      "isRequied": false
    },
    {
      "countryName": "Congo, The Democratic Republic Of The",
      "countryCode": "CD",
      "countryCodeFormat": [],
      "countryCodeLength": [],
      "isRequied": false
    },
    {
      "countryName": "Cook Islands",
      "countryCode": "CK",
      "countryCodeFormat": [],
      "countryCodeLength": [],
      "isRequied": false
    },
    {
      "countryName": "Costa Rica",
      "countryCode": "CR",
      "countryCodeFormat": [],
      "countryCodeLength": [],
      "isRequied": false
    },
    {
      "countryName": "Croatia",
      "countryCode": "HR",
      "countryCodeFormat": ["99999"],
      "countryCodeLength": [5],
      "isRequied": true
    },
    {
      "countryName": "Cuba",
      "countryCode": "CU",
      "countryCodeFormat": ["99999"],
      "countryCodeLength": [5],
      "isRequied": true
    },
    {
      "countryName": "Curaçao",
      "countryCode": "CW",
      "countryCodeFormat": ["9999"],
      "countryCodeLength": [4],
      "isRequied": true
    },
    {
      "countryName": "Cyprus",
      "countryCode": "CY",
      "countryCodeFormat": ["9999"],
      "countryCodeLength": [4],
      "isRequied": true
    },
    {
      "countryName": "Czech Republic",
      "countryCode": "CZ",
      "countryCodeFormat": ["999 99", "99999"],
      "countryCodeLength": [5, 6],
      "isRequied": true
    },
    {
      "countryName": "Côte d'Ivoire",
      "countryCode": "CI",
      "countryCodeFormat": [],
      "countryCodeLength": [],
      "isRequied": false
    },
    {
      "countryName": "Denmark",
      "countryCode": "DK",
      "countryCodeFormat": ["9999"],
      "countryCodeLength": [4],
      "isRequied": true
    },
    {
      "countryName": "Djibouti",
      "countryCode": "DJ",
      "countryCodeFormat": [],
      "countryCodeLength": [],
      "isRequied": false
    },
    {
      "countryName": "Dominica",
      "countryCode": "DM",
      "countryCodeFormat": [],
      "countryCodeLength": [],
      "isRequied": false
    },
    {
      "countryName": "Dominican Republic",
      "countryCode": "DO",
      "countryCodeFormat": [],
      "countryCodeLength": [],
      "isRequied": false
    },
    {
      "countryName": "Ecuador",
      "countryCode": "EC",
      "countryCodeFormat": ["999999"],
      "countryCodeLength": [6],
      "isRequied": true
    },
    {
      "countryName": "Egypt",
      "countryCode": "EG",
      "countryCodeFormat": [],
      "countryCodeLength": [],
      "isRequied": false
    },
    {
      "countryName": "El Salvador",
      "countryCode": "SV",
      "countryCodeFormat": [],
      "countryCodeLength": [],
      "isRequied": false
    },
    {
      "countryName": "Eritrea",
      "countryCode": "ER",
      "countryCodeFormat": [],
      "countryCodeLength": [],
      "isRequied": false
    },
    {
      "countryName": "Estonia",
      "countryCode": "EE",
      "countryCodeFormat": ["99999"],
      "countryCodeLength": [5],
      "isRequied": true
    },
    {
      "countryName": "Ethiopia",
      "countryCode": "ET",
      "countryCodeFormat": [],
      "countryCodeLength": [],
      "isRequied": false
    },
    {
      "countryName": "Falkland Islands (Malvinas)",
      "countryCode": "FK",
      "countryCodeFormat": [],
      "countryCodeLength": [],
      "isRequied": false
    },
    {
      "countryName": "Equatorial Guinea",
      "countryCode": "GQ",
      "countryCodeFormat": [],
      "countryCodeLength": [],
      "isRequied": false
    },
    {
      "countryName": "Faroe Islands",
      "countryCode": "FO",
      "countryCodeFormat": ["9999"],
      "countryCodeLength": [4],
      "isRequied": true
    },
    {
      "countryName": "Fiji",
      "countryCode": "FJ",
      "countryCodeFormat": ["999"],
      "countryCodeLength": [3],
      "isRequied": true
    },
    {
      "countryName": "Finland",
      "countryCode": "FI",
      "countryCodeFormat": ["99999"],
      "countryCodeLength": [5],
      "isRequied": true
    },
    {
      "countryName": "France",
      "countryCode": "FR",
      "countryCodeFormat": ["99999"],
      "countryCodeLength": [5],
      "isRequied": true
    },
    {
      "countryName": "French Guiana",
      "countryCode": "GF",
      "countryCodeFormat": ["99999"],
      "countryCodeLength": [5],
      "isRequied": true
    },
    {
      "countryName": "French Polynesia",
      "countryCode": "PF",
      "countryCodeFormat": [],
      "countryCodeLength": [],
      "isRequied": false
    },
    {
      "countryName": "French Southern Territories",
      "countryCode": "TF",
      "countryCodeFormat": [],
      "countryCodeLength": [],
      "isRequied": false
    },
    {
      "countryName": "Gabon",
      "countryCode": "GA",
      "countryCodeFormat": [],
      "countryCodeLength": [],
      "isRequied": false
    },
    {
      "countryName": "Gambia",
      "countryCode": "GM",
      "countryCodeFormat": [],
      "countryCodeLength": [],
      "isRequied": false
    },
    {
      "countryName": "Georgia",
      "countryCode": "GE",
      "countryCodeFormat": ["9999"],
      "countryCodeLength": [4],
      "isRequied": true
    },
    {
      "countryName": "Germany",
      "countryCode": "DE",
      "countryCodeFormat": ["99999"],
      "countryCodeLength": [5],
      "isRequied": true
    },
    {
      "countryName": "Ghana",
      "countryCode": "GH",
      "countryCodeFormat": [],
      "countryCodeLength": [],
      "isRequied": false
    },
    {
      "countryName": "Gibraltar",
      "countryCode": "GI",
      "countryCodeFormat": [],
      "countryCodeLength": [],
      "isRequied": false
    },
    {
      "countryName": "Greece",
      "countryCode": "GR",
      "countryCodeFormat": ["999 99", "99999"],
      "countryCodeLength": [5, 6],
      "isRequied": true
    },
    {
      "countryName": "Greenland",
      "countryCode": "GL",
      "countryCodeFormat": ["9999"],
      "countryCodeLength": [4],
      "isRequied": true
    },
    {
      "countryName": "Grenada",
      "countryCode": "GD",
      "countryCodeFormat": [],
      "countryCodeLength": [],
      "isRequied": false
    },
    {
      "countryName": "Guadeloupe",
      "countryCode": "GP",
      "countryCodeFormat": ["99999"],
      "countryCodeLength": [5],
      "isRequied": true
    },
    {
      "countryName": "Guatemala",
      "countryCode": "GT",
      "countryCodeFormat": [],
      "countryCodeLength": [],
      "isRequied": false
    },
    {
      "countryName": "Guernsey",
      "countryCode": "GG",
      "countryCodeFormat": ["AA99 9AA", "AA9 9AA", "AA999AA", "AA99AA"],
      "countryCodeLength": [6, 7, 8],
      "isRequied": true
    },
    {
      "countryName": "Guinea",
      "countryCode": "GN",
      "countryCodeFormat": [],
      "countryCodeLength": [],
      "isRequied": false
    },
    {
      "countryName": "Guinea Bissau",
      "countryCode": "GW",
      "countryCodeFormat": [],
      "countryCodeLength": [],
      "isRequied": false
    },
    {
      "countryName": "Guyana",
      "countryCode": "GY",
      "countryCodeFormat": [],
      "countryCodeLength": [],
      "isRequied": false
    },
    {
      "countryName": "Haiti",
      "countryCode": "HT",
      "countryCodeFormat": [],
      "countryCodeLength": [],
      "isRequied": false
    },
    {
      "countryName": "Heard Island And Mcdonald Islands",
      "countryCode": "HM",
      "countryCodeFormat": [],
      "countryCodeLength": [],
      "isRequied": false
    },
    {
      "countryName": "Honduras",
      "countryCode": "HN",
      "countryCodeFormat": [],
      "countryCodeLength": [],
      "isRequied": false
    },
    {
      "countryName": "Hong Kong",
      "countryCode": "HK",
      "countryCodeFormat": [],
      "countryCodeLength": [],
      "isRequied": false
    },
    {
      "countryName": "Hungary",
      "countryCode": "HU",
      "countryCodeFormat": ["9999"],
      "countryCodeLength": [4],
      "isRequied": true
    },
    {
      "countryName": "Iceland",
      "countryCode": "IS",
      "countryCodeFormat": ["999"],
      "countryCodeLength": [3],
      "isRequied": true
    },
    {
      "countryName": "India",
      "countryCode": "IN",
      "countryCodeFormat": ["999999"],
      "countryCodeLength": [6],
      "isRequied": true
    },
    {
      "countryName": "Indonesia",
      "countryCode": "ID",
      "countryCodeFormat": ["99999"],
      "countryCodeLength": [5],
      "isRequied": true
    },
    {
      "countryName": "Iran, Islamic Republic Of",
      "countryCode": "IR",
      "countryCodeFormat": [],
      "countryCodeLength": [],
      "isRequied": false
    },
    {
      "countryName": "Iraq",
      "countryCode": "IQ",
      "countryCodeFormat": [],
      "countryCodeLength": [],
      "isRequied": false
    },
    {
      "countryName": "Ireland",
      "countryCode": "IE",
      "countryCodeFormat": [],
      "countryCodeLength": [],
      "isRequied": false
    },
    {
      "countryName": "Isle Of Man",
      "countryCode": "IM",
      "countryCodeFormat": [],
      "countryCodeLength": [],
      "isRequied": false
    },
    {
      "countryName": "Israel",
      "countryCode": "IL",
      "countryCodeFormat": ["9999999"],
      "countryCodeLength": [7],
      "isRequied": true
    },
    {
      "countryName": "Italy",
      "countryCode": "IT",
      "countryCodeFormat": ["99999"],
      "countryCodeLength": [5],
      "isRequied": true
    },
    {
      "countryName": "Jamaica",
      "countryCode": "JM",
      "countryCodeFormat": [],
      "countryCodeLength": [],
      "isRequied": false
    },
    {
      "countryName": "Japan",
      "countryCode": "JP",
      "countryCodeFormat": ["999-9999", "9999999", "999 9999"],
      "countryCodeLength": [7, 8],
      "isRequied": true
    },
    {
      "countryName": "Jersey",
      "countryCode": "JE",
      "countryCodeFormat": ["AA9 9AA", "AA99AA"],
      "countryCodeLength": [6, 7],
      "isRequied": true
    },
    {
      "countryName": "Jordan",
      "countryCode": "JO",
      "countryCodeFormat": [],
      "countryCodeLength": [],
      "isRequied": false
    },
    {
      "countryName": "Kazakhstan",
      "countryCode": "KZ",
      "countryCodeFormat": ["999999"],
      "countryCodeLength": [6],
      "isRequied": true
    },
    {
      "countryName": "Kenya",
      "countryCode": "KE",
      "countryCodeFormat": [],
      "countryCodeLength": [],
      "isRequied": false
    },
    {
      "countryName": "Kiribati",
      "countryCode": "KI",
      "countryCodeFormat": [],
      "countryCodeLength": [],
      "isRequied": false
    },
    {
      "countryName": "Korea, Democratic People's Republic Of",
      "countryCode": "KP",
      "countryCodeFormat": [],
      "countryCodeLength": [],
      "isRequied": false
    },
    {
      "countryName": "Kosovo",
      "countryCode": "XK",
      "countryCodeFormat": [],
      "countryCodeLength": [],
      "isRequied": false
    },
    {
      "countryName": "Kuwait",
      "countryCode": "KW",
      "countryCodeFormat": [],
      "countryCodeLength": [],
      "isRequied": false
    },
    {
      "countryName": "Kyrgyzstan",
      "countryCode": "KG",
      "countryCodeFormat": ["999999"],
      "countryCodeLength": [6],
      "isRequied": true
    },
    {
      "countryName": "Lao People's Democratic Republic",
      "countryCode": "LA",
      "countryCodeFormat": [],
      "countryCodeLength": [],
      "isRequied": false
    },
    {
      "countryName": "Latvia",
      "countryCode": "LV",
      "countryCodeFormat": ["9999"],
      "countryCodeLength": [4],
      "isRequied": true
    },
    {
      "countryName": "Lebanon",
      "countryCode": "LB",
      "countryCodeFormat": [],
      "countryCodeLength": [],
      "isRequied": false
    },
    {
      "countryName": "Lesotho",
      "countryCode": "LS",
      "countryCodeFormat": [],
      "countryCodeLength": [],
      "isRequied": false
    },
    {
      "countryName": "Liberia",
      "countryCode": "LR",
      "countryCodeFormat": [],
      "countryCodeLength": [],
      "isRequied": false
    },
    {
      "countryName": "Libyan Arab Jamahiriya",
      "countryCode": "LY",
      "countryCodeFormat": [],
      "countryCodeLength": [],
      "isRequied": false
    },
    {
      "countryName": "Liechtenstein",
      "countryCode": "LI",
      "countryCodeFormat": ["9999"],
      "countryCodeLength": [4],
      "isRequied": true
    },
    {
      "countryName": "Lithuania",
      "countryCode": "LT",
      "countryCodeFormat": ["99999"],
      "countryCodeLength": [5],
      "isRequied": true
    },
    {
      "countryName": "Luxembourg",
      "countryCode": "LU",
      "countryCodeFormat": ["9999"],
      "countryCodeLength": [4],
      "isRequied": true
    },
    {
      "countryName": "Macao",
      "countryCode": "MO",
      "countryCodeFormat": [],
      "countryCodeLength": [],
      "isRequied": false
    },
    {
      "countryName": "Macedonia, Republic Of",
      "countryCode": "MK",
      "countryCodeFormat": ["9999"],
      "countryCodeLength": [4],
      "isRequied": true
    },
    {
      "countryName": "Madagascar",
      "countryCode": "MG",
      "countryCodeFormat": ["999"],
      "countryCodeLength": [3],
      "isRequied": true
    },
    {
      "countryName": "Malawi",
      "countryCode": "MW",
      "countryCodeFormat": [],
      "countryCodeLength": [],
      "isRequied": false
    },
    {
      "countryName": "Malaysia",
      "countryCode": "MY",
      "countryCodeFormat": ["99999"],
      "countryCodeLength": [5],
      "isRequied": true
    },
    {
      "countryName": "Maldives",
      "countryCode": "MV",
      "countryCodeFormat": ["99999", "9999"],
      "countryCodeLength": [4, 5],
      "isRequied": true
    },
    {
      "countryName": "Mali",
      "countryCode": "ML",
      "countryCodeFormat": [],
      "countryCodeLength": [],
      "isRequied": false
    },
    {
      "countryName": "Malta",
      "countryCode": "MT",
      "countryCodeFormat": [],
      "countryCodeLength": [],
      "isRequied": false
    },
    {
      "countryName": "Martinique",
      "countryCode": "MQ",
      "countryCodeFormat": ["99999"],
      "countryCodeLength": [5],
      "isRequied": true
    },
    {
      "countryName": "Mauritius",
      "countryCode": "MU",
      "countryCodeFormat": [],
      "countryCodeLength": [],
      "isRequied": false
    },
    {
      "countryName": "Mayotte",
      "countryCode": "YT",
      "countryCodeFormat": ["99999"],
      "countryCodeLength": [5],
      "isRequied": true
    },
    {
      "countryName": "Mauritania",
      "countryCode": "MR",
      "countryCodeFormat": [],
      "countryCodeLength": [],
      "isRequied": false
    },
    {
      "countryName": "Mexico",
      "countryCode": "MX",
      "countryCodeFormat": ["99999"],
      "countryCodeLength": [5],
      "isRequied": true
    },
    {
      "countryName": "Moldova, Republic of",
      "countryCode": "MD",
      "countryCodeFormat": ["9999"],
      "countryCodeLength": [4],
      "isRequied": true
    },
    {
      "countryName": "Monaco",
      "countryCode": "MC",
      "countryCodeFormat": ["99999"],
      "countryCodeLength": [5],
      "isRequied": true
    },
    {
      "countryName": "Mongolia",
      "countryCode": "MN",
      "countryCodeFormat": ["999999", "99999"],
      "countryCodeLength": [5, 6],
      "isRequied": true
    },
    {
      "countryName": "Montenegro",
      "countryCode": "ME",
      "countryCodeFormat": ["99999"],
      "countryCodeLength": [5],
      "isRequied": true
    },
    {
      "countryName": "Montserrat",
      "countryCode": "MS",
      "countryCodeFormat": [],
      "countryCodeLength": [],
      "isRequied": false
    },
    {
      "countryName": "Morocco",
      "countryCode": "MA",
      "countryCodeFormat": ["99999"],
      "countryCodeLength": [5],
      "isRequied": true
    },
    {
      "countryName": "Mozambique",
      "countryCode": "MZ",
      "countryCodeFormat": [],
      "countryCodeLength": [],
      "isRequied": false
    },
    {
      "countryName": "Myanmar",
      "countryCode": "MM",
      "countryCodeFormat": [],
      "countryCodeLength": [],
      "isRequied": false
    },
    {
      "countryName": "Namibia",
      "countryCode": "NA",
      "countryCodeFormat": [],
      "countryCodeLength": [],
      "isRequied": false
    },
    {
      "countryName": "Nauru",
      "countryCode": "NR",
      "countryCodeFormat": [],
      "countryCodeLength": [],
      "isRequied": false
    },
    {
      "countryName": "Nepal",
      "countryCode": "NP",
      "countryCodeFormat": [],
      "countryCodeLength": [],
      "isRequied": false
    },
    {
      "countryName": "Netherlands",
      "countryCode": "NL",
      "countryCodeFormat": ["9999", "9999AA", "9999 AA"],
      "countryCodeLength": [4, 6, 7],
      "isRequied": true
    },
    {
      "countryName": "New Caledonia",
      "countryCode": "NC",
      "countryCodeFormat": ["99999"],
      "countryCodeLength": [5],
      "isRequied": true
    },
    {
      "countryName": "New Zealand",
      "countryCode": "NZ",
      "countryCodeFormat": ["9999"],
      "countryCodeLength": [4],
      "isRequied": true
    },
    {
      "countryName": "Nicaragua",
      "countryCode": "NI",
      "countryCodeFormat": [],
      "countryCodeLength": [],
      "isRequied": false
    },
    {
      "countryName": "Niger",
      "countryCode": "NE",
      "countryCodeFormat": [],
      "countryCodeLength": [],
      "isRequied": false
    },
    {
      "countryName": "Nigeria",
      "countryCode": "NG",
      "countryCodeFormat": [],
      "countryCodeLength": [],
      "isRequied": false
    },
    {
      "countryName": "Niue",
      "countryCode": "NU",
      "countryCodeFormat": ["9999"],
      "countryCodeLength": [4],
      "isRequied": true
    },
    {
      "countryName": "Norfolk Island",
      "countryCode": "NF",
      "countryCodeFormat": [],
      "countryCodeLength": [],
      "isRequied": false
    },
    {
      "countryName": "Norway",
      "countryCode": "NO",
      "countryCodeFormat": ["9999"],
      "countryCodeLength": [4],
      "isRequied": true
    },
    {
      "countryName": "Oman",
      "countryCode": "OM",
      "countryCodeFormat": ["9999"],
      "countryCodeLength": [4],
      "isRequied": true
    },
    {
      "countryName": "Pakistan",
      "countryCode": "PK",
      "countryCodeFormat": ["99999"],
      "countryCodeLength": [5],
      "isRequied": true
    },
    {
      "countryName": "Palestinian Territory, Occupied",
      "countryCode": "PS",
      "countryCodeFormat": [],
      "countryCodeLength": [],
      "isRequied": false
    },
    {
      "countryName": "Panama",
      "countryCode": "PA",
      "countryCodeFormat": [],
      "countryCodeLength": [],
      "isRequied": false
    },
    {
      "countryName": "Papua New Guinea",
      "countryCode": "PG",
      "countryCodeFormat": ["999"],
      "countryCodeLength": [3],
      "isRequied": true
    },
    {
      "countryName": "Paraguay",
      "countryCode": "PY",
      "countryCodeFormat": [],
      "countryCodeLength": [],
      "isRequied": false
    },
    {
      "countryName": "Peru",
      "countryCode": "PE",
      "countryCodeFormat": [],
      "countryCodeLength": [],
      "isRequied": false
    },
    {
      "countryName": "Philippines",
      "countryCode": "PH",
      "countryCodeFormat": ["9999"],
      "countryCodeLength": [4],
      "isRequied": true
    },
    {
      "countryName": "Pitcairn",
      "countryCode": "PN",
      "countryCodeFormat": [],
      "countryCodeLength": [],
      "isRequied": false
    },
    {
      "countryName": "Poland",
      "countryCode": "PL",
      "countryCodeFormat": ["99-999", "99999", "99 999"],
      "countryCodeLength": [5, 6],
      "isRequied": true
    },
    {
      "countryName": "Portugal",
      "countryCode": "PT",
      "countryCodeFormat": ["9999-999", "9999999", "9999 999"],
      "countryCodeLength": [7, 8],
      "isRequied": true
    },
    {
      "countryName": "Qatar",
      "countryCode": "QA",
      "countryCodeFormat": [],
      "countryCodeLength": [],
      "isRequied": false
    },
    {
      "countryName": "Republic of Cameroon",
      "countryCode": "CM",
      "countryCodeFormat": [],
      "countryCodeLength": [],
      "isRequied": false
    },
    {
      "countryName": "Reunion",
      "countryCode": "RE",
      "countryCodeFormat": ["99999"],
      "countryCodeLength": [5],
      "isRequied": true
    },
    {
      "countryName": "Romania",
      "countryCode": "RO",
      "countryCodeFormat": ["999999"],
      "countryCodeLength": [6],
      "isRequied": true
    },
    {
      "countryName": "Russia",
      "countryCode": "RU",
      "countryCodeFormat": ["999999"],
      "countryCodeLength": [6],
      "isRequied": true
    },
    {
      "countryName": "Rwanda",
      "countryCode": "RW",
      "countryCodeFormat": [],
      "countryCodeLength": [],
      "isRequied": false
    },
    {
      "countryName": "Saint Barthélemy",
      "countryCode": "BL",
      "countryCodeFormat": [],
      "countryCodeLength": [],
      "isRequied": false
    },
    {
      "countryName": "Saint Helena",
      "countryCode": "SH",
      "countryCodeFormat": ["AAAA 9AA", "AAAA9AA"],
      "countryCodeLength": [7, 8],
      "isRequied": true
    },
    {
      "countryName": "Saint Kitts And Nevis",
      "countryCode": "KN",
      "countryCodeFormat": [],
      "countryCodeLength": [],
      "isRequied": false
    },
    {
      "countryName": "Saint Lucia",
      "countryCode": "LC",
      "countryCodeFormat": [],
      "countryCodeLength": [],
      "isRequied": false
    },
    {
      "countryName": "Saint Martin",
      "countryCode": "MF",
      "countryCodeFormat": [],
      "countryCodeLength": [],
      "isRequied": false
    },
    {
      "countryName": "Saint Pierre And Miquelon",
      "countryCode": "PM",
      "countryCodeFormat": [],
      "countryCodeLength": [],
      "isRequied": false
    },
    {
      "countryName": "Samoa",
      "countryCode": "WS",
      "countryCodeFormat": [],
      "countryCodeLength": [],
      "isRequied": false
    },
    {
      "countryName": "San Marino",
      "countryCode": "SM",
      "countryCodeFormat": ["99999"],
      "countryCodeLength": [5],
      "isRequied": true
    },
    {
      "countryName": "Sao Tome And Principe",
      "countryCode": "ST",
      "countryCodeFormat": [],
      "countryCodeLength": [],
      "isRequied": false
    },
    {
      "countryName": "Saudi Arabia",
      "countryCode": "SA",
      "countryCodeFormat": ["99999"],
      "countryCodeLength": [5],
      "isRequied": true
    },
    {
      "countryName": "Senegal",
      "countryCode": "SN",
      "countryCodeFormat": [],
      "countryCodeLength": [],
      "isRequied": false
    },
    {
      "countryName": "Serbia",
      "countryCode": "RS",
      "countryCodeFormat": ["99999"],
      "countryCodeLength": [5],
      "isRequied": true
    },
    {
      "countryName": "Seychelles",
      "countryCode": "SC",
      "countryCodeFormat": [],
      "countryCodeLength": [],
      "isRequied": false
    },
    {
      "countryName": "Sierra Leone",
      "countryCode": "SL",
      "countryCodeFormat": [],
      "countryCodeLength": [],
      "isRequied": false
    },
    {
      "countryName": "Singapore",
      "countryCode": "SG",
      "countryCodeFormat": ["999999"],
      "countryCodeLength": [6],
      "isRequied": true
    },
    {
      "countryName": "Sint Maarten",
      "countryCode": "SX",
      "countryCodeFormat": [],
      "countryCodeLength": [],
      "isRequied": false
    },
    {
      "countryName": "Slovakia",
      "countryCode": "SK",
      "countryCodeFormat": ["999 99", "99999"],
      "countryCodeLength": [5, 6],
      "isRequied": true
    },
    {
      "countryName": "Slovenia",
      "countryCode": "SI",
      "countryCodeFormat": ["9999"],
      "countryCodeLength": [4],
      "isRequied": true
    },
    {
      "countryName": "Solomon Islands",
      "countryCode": "SB",
      "countryCodeFormat": [],
      "countryCodeLength": [],
      "isRequied": false
    },
    {
      "countryName": "Somalia",
      "countryCode": "SO",
      "countryCodeFormat": [],
      "countryCodeLength": [],
      "isRequied": false
    },
    {
      "countryName": "South Africa",
      "countryCode": "ZA",
      "countryCodeFormat": ["9999"],
      "countryCodeLength": [4],
      "isRequied": true
    },
    {
      "countryName": "South Georgia And The South Sandwich Islands",
      "countryCode": "GS",
      "countryCodeFormat": [],
      "countryCodeLength": [],
      "isRequied": false
    },
    {
      "countryName": "South Korea",
      "countryCode": "KR",
      "countryCodeFormat": ["99999"],
      "countryCodeLength": [5],
      "isRequied": true
    },
    {
      "countryName": "South Sudan",
      "countryCode": "SS",
      "countryCodeFormat": [],
      "countryCodeLength": [],
      "isRequied": false
    },
    {
      "countryName": "Spain",
      "countryCode": "ES",
      "countryCodeFormat": ["99999"],
      "countryCodeLength": [5],
      "isRequied": true
    },
    {
      "countryName": "Sri Lanka",
      "countryCode": "LK",
      "countryCodeFormat": [],
      "countryCodeLength": [],
      "isRequied": false
    },
    {
      "countryName": "St. Vincent",
      "countryCode": "VC",
      "countryCodeFormat": [],
      "countryCodeLength": [],
      "isRequied": false
    },
    {
      "countryName": "Sudan",
      "countryCode": "SD",
      "countryCodeFormat": [],
      "countryCodeLength": [],
      "isRequied": false
    },
    {
      "countryName": "Suriname",
      "countryCode": "SR",
      "countryCodeFormat": [],
      "countryCodeLength": [],
      "isRequied": false
    },
    {
      "countryName": "Sweden",
      "countryCode": "SE",
      "countryCodeFormat": ["999 99", "99999"],
      "countryCodeLength": [5, 6],
      "isRequied": true
    },
    {
      "countryName": "Svalbard And Jan Mayen",
      "countryCode": "SJ",
      "countryCodeFormat": ["999 99", "99999"],
      "countryCodeLength": [5, 6],
      "isRequied": true
    },
    {
      "countryName": "Switzerland",
      "countryCode": "CH",
      "countryCodeFormat": ["9999"],
      "countryCodeLength": [4],
      "isRequied": true
    },
    {
      "countryName": "Syria",
      "countryCode": "SY",
      "countryCodeFormat": [],
      "countryCodeLength": [],
      "isRequied": false
    },
    {
      "countryName": "Tajikistan",
      "countryCode": "TJ",
      "countryCodeFormat": [],
      "countryCodeLength": [],
      "isRequied": false
    },
    {
      "countryName": "Tanzania, United Republic Of",
      "countryCode": "TZ",
      "countryCodeFormat": [],
      "countryCodeLength": [],
      "isRequied": false
    },
    {
      "countryName": "Thailand",
      "countryCode": "TH",
      "countryCodeFormat": ["99999"],
      "countryCodeLength": [5],
      "isRequied": true
    },
    {
      "countryName": "Timor Leste",
      "countryCode": "TL",
      "countryCodeFormat": [],
      "countryCodeLength": [],
      "isRequied": false
    },
    {
      "countryName": "Togo",
      "countryCode": "TG",
      "countryCodeFormat": [],
      "countryCodeLength": [],
      "isRequied": false
    },
    {
      "countryName": "Tokelau",
      "countryCode": "TK",
      "countryCodeFormat": [],
      "countryCodeLength": [],
      "isRequied": false
    },
    {
      "countryName": "Tonga",
      "countryCode": "TO",
      "countryCodeFormat": [],
      "countryCodeLength": [],
      "isRequied": false
    },
    {
      "countryName": "Trinidad and Tobago",
      "countryCode": "TT",
      "countryCodeFormat": [],
      "countryCodeLength": [],
      "isRequied": false
    },
    {
      "countryName": "Tunisia",
      "countryCode": "TN",
      "countryCodeFormat": ["9999"],
      "countryCodeLength": [4],
      "isRequied": true
    },
    {
      "countryName": "Turkey",
      "countryCode": "TR",
      "countryCodeFormat": ["99999"],
      "countryCodeLength": [5],
      "isRequied": true
    },
    {
      "countryName": "Turkmenistan",
      "countryCode": "TM",
      "countryCodeFormat": [],
      "countryCodeLength": [],
      "isRequied": false
    },
    {
      "countryName": "Turks and Caicos Islands",
      "countryCode": "TC",
      "countryCodeFormat": [],
      "countryCodeLength": [],
      "isRequied": false
    },
    {
      "countryName": "Tuvalu",
      "countryCode": "TV",
      "countryCodeFormat": [],
      "countryCodeLength": [],
      "isRequied": false
    },
    {
      "countryName": "Uganda",
      "countryCode": "UG",
      "countryCodeFormat": [],
      "countryCodeLength": [],
      "isRequied": false
    },
    {
      "countryName": "Ukraine",
      "countryCode": "UA",
      "countryCodeFormat": ["99999"],
      "countryCodeLength": [5],
      "isRequied": true
    },
    {
      "countryName": "United Arab Emirates",
      "countryCode": "AE",
      "countryCodeFormat": [],
      "countryCodeLength": [],
      "isRequied": false
    },
    {
      "countryName": "Uruguay",
      "countryCode": "UY",
      "countryCodeFormat": [],
      "countryCodeLength": [],
      "isRequied": false
    },
    {
      "countryName": "Uzbekistan",
      "countryCode": "UZ",
      "countryCodeFormat": ["999999"],
      "countryCodeLength": [6],
      "isRequied": true
    },
    {
      "countryName": "Vanuatu",
      "countryCode": "VU",
      "countryCodeFormat": [],
      "countryCodeLength": [],
      "isRequied": false
    },
    {
      "countryName": "Venezuela",
      "countryCode": "VE",
      "countryCodeFormat": [],
      "countryCodeLength": [],
      "isRequied": false
    },
    {
      "countryName": "Vietnam",
      "countryCode": "VN",
      "countryCodeFormat": [],
      "countryCodeLength": [],
      "isRequied": false
    },
    {
      "countryName": "Virgin Islands, British",
      "countryCode": "VG",
      "countryCodeFormat": [],
      "countryCodeLength": [],
      "isRequied": false
    },
    {
      "countryName": "Wallis And Futuna",
      "countryCode": "WF",
      "countryCodeFormat": [],
      "countryCodeLength": [],
      "isRequied": false
    },
    {
      "countryName": "Western Sahara",
      "countryCode": "EH",
      "countryCodeFormat": [],
      "countryCodeLength": [],
      "isRequied": false
    },
    {
      "countryName": "Yemen",
      "countryCode": "YE",
      "countryCodeFormat": [],
      "countryCodeLength": [],
      "isRequied": false
    },
    {
      "countryName": "Zambia",
      "countryCode": "ZM",
      "countryCodeFormat": [],
      "countryCodeLength": [],
      "isRequied": false
    },
    {
      "countryName": "Zimbabwe",
      "countryCode": "ZW",
      "countryCodeFormat": [],
      "countryCodeLength": [],
      "isRequied": false
    }
  ];
}
