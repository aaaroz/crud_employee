class EmployeeModels {
  String? message;
  List<ResponseDataEmployee>? response;

  EmployeeModels({
    this.message,
    this.response,
  });

  factory EmployeeModels.fromJson(Map<String, dynamic> json) => EmployeeModels(
        message: json["message"],
        response: json["data"] == null
            ? []
            : List<ResponseDataEmployee>.from(
                json["data"]!.map((x) => ResponseDataEmployee.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "response": response == null
            ? []
            : List<dynamic>.from(response!.map((x) => x.toJson())),
      };
}

class ResponseDataEmployee {
  String id;
  String name;
  String province;
  String city;
  String position;
  String religion;
  String imageUrl;

  ResponseDataEmployee(
      {required this.id,
      required this.name,
      required this.province,
      required this.city,
      required this.position,
      required this.religion,
      required this.imageUrl});

  factory ResponseDataEmployee.fromJson(Map<String, dynamic> json) =>
      ResponseDataEmployee(
        id: json["id"],
        name: json["name"],
        province: json["province"],
        city: json["city"],
        position: json["position"],
        religion: json["religion"],
        imageUrl: json["image_url"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "province": province,
        "city": city,
        "position": position,
        "rel": religion,
        "image_url": imageUrl,
      };
}
