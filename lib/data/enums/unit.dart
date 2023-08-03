enum Unit {
  kg,
  g,
  l,
  ml,
  piece,
  bag,
  box,
  bottle,
  can,
  jar,
  pack,
  roll,
  tube,
  bunch,
  each,
}

// fromName to Unit
Unit unitFromName(String name) {
  switch (name) {
    case 'kg':
      return Unit.kg;
    case 'g':
      return Unit.g;
    case 'l':
      return Unit.l;
    case 'ml':
      return Unit.ml;
    case 'piece':
      return Unit.piece;
    case 'bag':
      return Unit.bag;
    case 'box':
      return Unit.box;
    case 'bottle':
      return Unit.bottle;
    case 'can':
      return Unit.can;
    case 'jar':
      return Unit.jar;
    case 'pack':
      return Unit.pack;
    case 'roll':
      return Unit.roll;
    case 'tube':
      return Unit.tube;
    case 'bunch':
      return Unit.bunch;
    case 'each':
      return Unit.each;
    default:
      return Unit.kg;
  }
}
