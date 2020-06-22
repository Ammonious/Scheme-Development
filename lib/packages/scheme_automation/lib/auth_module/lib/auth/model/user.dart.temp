import 'dart:convert';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
	final String fullName;
	final String userRole;
	final String firstName;
	final String lastName;
	final String email;
	final String uid;

	User({this.userRole,
		     this.fullName,
		     this.firstName,
		     this.lastName,
		     this.email,
		     this.uid,
	     });

	User copyWith({
		              String name,
		              String firstName,
		              String lastName,
		              String email,
		              String uid,
		String userRole,
	              }) =>
			User(
				fullName: name ?? this.fullName,
				firstName: firstName ?? this.firstName,
				lastName: lastName ?? this.lastName,
				email: email ?? this.email,
				uid: uid ?? this.uid,
				userRole: userRole ?? this.userRole
			);

	factory User.fromJson(Map<dynamic, dynamic> json) => User(
		fullName: json["name"] == null ? '' : json["name"],
		firstName: json["firstName"] == '' ? null : json["firstName"],
		lastName: json["lastName"] == '' ? null : json["lastName"],
		email: json["email"] == null ? '' : json["email"],
		uid: json["uid"] == null ? '' : json["uid"],
		userRole: json["userRole"] == null ? '' : json["userRole"],
	);

	Map<dynamic, dynamic> toJson() => {
		"name": fullName == null ? '' : fullName,
		"firstName": firstName == '' ? null : firstName,
		"lastName": lastName == null ? '' : lastName,
		"email": email == null ? '' : email,
		"uid": uid == null ? '' : uid,
	};
}