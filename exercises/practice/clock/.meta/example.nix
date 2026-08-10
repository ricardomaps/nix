let
  inherit (import <nixpkgs/lib>) mod;
  minutesPerDay = 1440;
  rollover =
    n:
    let
      m = mod n minutesPerDay;
    in
    if m < 0 then m + minutesPerDay else m;
in
{
  create = hour: minute: rollover (hour * 60 + minute);

  add = clock: minutes: rollover (clock + minutes);

  subtract = clock: minutes: rollover (clock - minutes);

  equal = a: b: a == b;

  format =
    clock:
    let
      hour = clock / 60;
      minute = mod clock 60;
      pad = n: if n < 10 then "0${toString n}" else toString n;
    in
    "${pad hour}:${pad minute}";
}
