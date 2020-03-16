THRESHOLD = 63

INVADER_1 = {
  form: %w(
    --o-----o--
    ---o---o---
    --ooooooo--
    -oo-ooo-oo-
    ooooooooooo
    o-ooooooo-o
    o-o-----o-o
    ---oo-oo---
  ).map { |s| s.split('') },
  color: 31
  }

INVADER_2 = {
  form: %w(
    ---oo---
    --oooo--
    -oooooo-
    oo-oo-oo
    oooooooo
    --o--o--
    -o-oo-o-
    o-o--o-o
  ).map { |s| s.split('') },
  color: 34
}
