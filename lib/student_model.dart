class Student {
  int id;
  String name;
  String roll,grp,sec;
  String cls;
  String gp;
  String pp;
  Student(this.id, this.name,this.roll,this.cls,this.sec,this.grp,this.gp,this.pp);

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'id': id,
      'name': name,
      'roll': roll,
      'cls': cls,
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
    roll = map['roll'];
    cls = map['cls'];
    sec=map['sec'];
    grp = map['grp'];
    gp = map['gp'];
    pp= map['pp'];
  }
}