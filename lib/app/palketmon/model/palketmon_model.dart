/// Palketmon Model
///
/// This Object is used to Domain Layer.
class Palketmon {
  final String img;
  final String name;
  final String palnumber;
  final String palelement;
  final String palskill;
  final String palworksfor;
  final String paldrops;

  Palketmon(
      {required this.img,
      required this.name,
      required this.palnumber,
      required this.palelement,
      required this.palskill,
      required this.palworksfor,
      required this.paldrops});
}

// data = {
//     'img': img_url,
//     'name': section.find('h3', first=True).text,
//     'palnumber': getText(ps[0].text),
//     'palelement': getText(ps[1].text),
//     'palskill': getText(ps[2].text),
//     'palworksfor':  getText(ps[3].text),
//     'paldrops': getText(ps[4].text),
// }
