let
  inherit (import <nixpkgs/lib>)
    cartesianProduct
    min
    max
    range
    ;
  transpose =
    matrix:
    let
      colTotal = builtins.length (builtins.head matrix);
    in
    builtins.genList (i: map (row: builtins.elemAt row i) matrix) colTotal;
  minimum = xs: builtins.foldl' min (builtins.head xs) xs;
  maximum = xs: builtins.foldl' max (builtins.head xs) xs;
in
{
  saddlePoints =
    matrix:
    let
      maxPerRow = map maximum matrix;
      minPerCol = map minimum (transpose matrix);
      indices = cartesianProduct {
        row = range 1 (builtins.length matrix);
        column = range 1 (builtins.length (builtins.head matrix));
      };
    in
    builtins.filter (
      { row, column }:
      let
        maxInRow = builtins.elemAt maxPerRow (row - 1);
        minInCol = builtins.elemAt minPerCol (column - 1);
        element = builtins.elemAt (builtins.elemAt matrix (row - 1)) (column - 1);
      in
      element == maxInRow && element == minInCol
    ) indices;
}
