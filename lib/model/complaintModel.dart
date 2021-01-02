class Complaints{
  String id;
  String title;
  DateTime date;
  int priority;
  double latitude;
  double longitude;
  String UID;
  String description;

  Complaints({this.id,this.title,this.date,this.latitude,this.longitude,this.UID,this.description});

  Complaints.fromData(Map<String,dynamic> data)
  : id = data['id'],
  title = data['title'],
  date = data['date'],
  priority = data['priority'],
  latitude = data['latitude'],
  longitude = data['longitude'],
  UID = data['UID'],
  description = data['description'];

  Map <String,dynamic> toJson()  {
    return {
      "id": id,
      "title": title,
      "date": date,
      "priority" : priority,
      "latitude": latitude,
      "longitude": longitude,
      "UID": UID,
      "Description": description,
    };
  }
}