enum Unit {
  kg,
  g,
  l,
  ml,
  piece,
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
    default:
      return Unit.kg;
  }
}
