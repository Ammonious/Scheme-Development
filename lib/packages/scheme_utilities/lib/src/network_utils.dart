import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

class NetworkUtil {
	// next three lines makes this class a Singleton
	static NetworkUtil instance = new NetworkUtil.internal();
	NetworkUtil.internal();
	factory NetworkUtil() => instance;
	Map<String, String> headers = { };
	final JsonDecoder _decoder = new JsonDecoder();

	Future<dynamic> get(String url,{Map<String,String> headers}) {
		return http.get(Uri.encodeFull(url),).then((http.Response response) {
			final String res = response.body;
			final int statusCode = response.statusCode;

			if (statusCode < 200 || statusCode > 400 || json == null) {
				throw new Exception("Error while fetching data");
			}
			return _decoder.convert(res);
		});
	}

	Future<dynamic> post(String url, {body, encoding,contentType}) {

		return http
				.post(url,headers: {"Content-Type": contentType ?? "application/json"}, body: json.encode(body), )
				.then((http.Response response) {
			final String res = response.body;
			final int statusCode = response.statusCode;

			if (statusCode < 200 || statusCode > 400 || json == null) {
				throw new Exception("Error while fetching data");
			}
			return _decoder.convert(res);
		}).timeout(Duration(seconds: 30),onTimeout: (){
			throw new TimeoutException('Unable to communicate with the server, please try again later.');
		}).catchError((error){
			throw new TimeoutException('Unable to communicate with the server, please try again later.');
		});
	}


}