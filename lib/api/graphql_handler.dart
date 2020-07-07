import 'dart:async';
import 'dart:convert';
import "package:graphql/client.dart";
import "package:shared_preferences/shared_preferences.dart";

const API_URL = "https://app.glue.is/easein";
getGraphqlClient() async {
  final GraphQLClient _client = GraphQLClient(
    cache: InMemoryCache(),
    link: await makeHttpLink() as Link,
  );
  return _client;
}

makeHttpLink() async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  String token = pref.getString("x-token");
  HttpLink _httpLink;
  if (token != null) {
    _httpLink =
        HttpLink(uri: API_URL, headers: {"x-token": token});
  } else {
    _httpLink = HttpLink(uri: API_URL);
  }
  return _httpLink;
}


const String mutation_signInWithPhoneNumber = r'''
  mutation($phoneNumber: String!){
  signInWithPhoneNumber(phoneNumber: $phoneNumber){
  status
  message

  }
}
''';


Future signInEnterPhoneNumber(dynamic phoneNumber) async {
  final MutationOptions query =
  MutationOptions(document: mutation_signInWithPhoneNumber, variables: <String, dynamic>{
    'phoneNumber': phoneNumber.toString(),
  });
  final client = await getGraphqlClient();
  final QueryResult result = await client.mutate(query);
  if (result.hasErrors) {
    return result.errors[0].toString();
  }

    Map<String, dynamic> resp = result.data != null && result.data["signInWithPhoneNumber"] != null ? result.data["signInWithPhoneNumber"] : null;
    return resp;
}


const String mutation_signInVerifyOTP = r'''
  mutation($phoneNumber:String!,$otp:String!){
    verifyOTP(phoneNumber: $phoneNumber,otp:$otp){
    status
    message
    token
  }
}
''';


Future signInVerifyOTP(dynamic phoneNumber,dynamic otp) async {
  final MutationOptions query =
  MutationOptions(document: mutation_signInVerifyOTP, variables: <String, dynamic>{
    'phoneNumber': phoneNumber.toString(),
    'otp':otp.toString()
  });
  print(phoneNumber);print(otp);
  final client = await getGraphqlClient();
  final QueryResult result = await client.mutate(query);
  if (result.hasErrors) {
    return result.errors[0].toString();
  }
  Map<String, dynamic> resp = result.data != null && result.data["verifyOTP"] != null ? result.data["verifyOTP"] : null;
  return resp;

}

const String mutation_updateProfile = r'''
  mutation($name:String!,$phone2:String,$email1:String,$email2:String,$address:String!,$aadharNo:String){
  updateProfile(name: $name,phone2:$phone2,email1:$email1,email2:$email2,address:$address,aadharNo:$aadharNo){
  status
  message

  }
}
''';

Future updateProfile(String name,String phone2,String email1,String email2,String address,String aadharNo) async {
  final MutationOptions query =
  MutationOptions(document: mutation_updateProfile, variables: <String, dynamic>{
    'name': name.toString(),
    'phone2':phone2.toString(),
    'email1':email1,
    'email2': email2,
    'address': address,
    'aadharNo': aadharNo
  });
  final client = await getGraphqlClient();
  final QueryResult result = await client.mutate(query);
  if (result.hasErrors) {
    return result.errors[0].toString();
  }
  return result.data;
}