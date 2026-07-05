let
  inherit (import <nixpkgs/lib>) stringToCharacters;
  inherit (builtins) head tail;
  pairs = {
    ")" = "(";
    "]" = "[";
    "}" = "{";
  };
  isOpen =
    c:
    builtins.elem c [
      "("
      "["
      "{"
    ];
  isClose =
    c:
    builtins.elem c [
      ")"
      "]"
      "}"
    ];
  go =
    stack: chars:
    if chars == [ ] then
      stack == [ ]
    else
      let
        c = head chars;
        rest = tail chars;
      in
      if isOpen c then
        go ([ c ] ++ stack) rest
      else if isClose c then
        stack != [ ] && head stack == pairs.${c} && go (tail stack) rest
      else
        go stack rest;
in
{
  isPaired = value: go [ ] (stringToCharacters value);
}
