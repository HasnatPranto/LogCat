class Student {
  int id;
  String name;
  String roll,grp,sec,year;
  String cls;
  String gp;
  String pp;
  String image;
  Student(this.id, this.name,this.image,this.roll,this.cls,this.year,this.sec,this.grp,this.gp,this.pp);

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'id': id,
      'name': name,
      'image': image,
      'roll': roll,
      'cls': cls,
      'year': year,
      'sec':sec,
      'grp': grp,
      'gp': gp,
      'pp':pp
    };
    return map;
  }

  Student.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    name = map['name'];
    image=map['image'];
    roll = map['roll'];
    cls = map['cls'];
    year=map['year'];
    sec=map['sec'];
    grp = map['grp'];
    gp = map['gp'];
    pp= map['pp'];
  }
}