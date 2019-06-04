class Model {
  String id;
  final String date;
  final String time;
  final String description;
  final String client;
  final String job;
  final String notes;
  final int millis;
  final int millisUtc;

  Model(
      {this.id,
      this.date,
      this.time,
      this.description,
      this.client,
      this.job,
      this.notes,
      this.millis,
      this.millisUtc});

  factory Model.fromData(
      date, time, description, client, job, notes, millis, millisUtc) {
    return Model(
        date: date,
        time: time,
        client: client,
        description: description,
        job: job,
        notes: notes,
        millis: millis,
        millisUtc: millisUtc);
  }

  factory Model.fromJson(Map json) {
    return Model(
        id: json['id'],
        date: json['date'],
        time: json['time'],
        client: json['client'],
        description: json['description'],
        job: json['job'],
        notes: json['notes'],
        millis: json['millis'],
        millisUtc: json['millisUtc']);
  }

  toJson() {
    return {
      'id': this.id,
      'date': this.date,
      'time': this.time,
      'client': this.client,
      'description': this.description,
      'job': this.job,
      'notes': this.notes,
      'millis': this.millis,
      'millisUtc': this.millisUtc
    };
  }
}
