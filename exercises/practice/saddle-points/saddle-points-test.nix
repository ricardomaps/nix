let
  inherit (import ./saddle-points.nix) saddlePoints;
in
{
  "test can identify single saddle point" = {
    expr = saddlePoints [
      [
        9
        8
        7
      ]
      [
        5
        3
        2
      ]
      [
        6
        6
        7
      ]
    ];
    expected = [
      {
        row = 2;
        column = 1;
      }
    ];
  };
  "test can identify that empty matrix has no saddle points" = {
    expr = saddlePoints [
      [ ]
    ];
    expected = [ ];
  };
  "test can identify lack of saddle points when there are none" = {
    expr = saddlePoints [
      [
        1
        2
        3
      ]
      [
        3
        1
        2
      ]
      [
        2
        3
        1
      ]
    ];
    expected = [ ];
  };
  "test can identify multiple saddle points in a column" = {
    expr = saddlePoints [
      [
        4
        5
        4
      ]
      [
        3
        5
        5
      ]
      [
        1
        5
        4
      ]
    ];
    expected = [
      {
        row = 1;
        column = 2;
      }
      {
        row = 2;
        column = 2;
      }
      {
        row = 3;
        column = 2;
      }
    ];
  };
  "test can identify multiple saddle points in a row" = {
    expr = saddlePoints [
      [
        6
        7
        8
      ]
      [
        5
        5
        5
      ]
      [
        7
        5
        6
      ]
    ];
    expected = [
      {
        row = 2;
        column = 1;
      }
      {
        row = 2;
        column = 2;
      }
      {
        row = 2;
        column = 3;
      }
    ];
  };
  "test can identify saddle point in bottom right corner" = {
    expr = saddlePoints [
      [
        8
        7
        9
      ]
      [
        6
        7
        6
      ]
      [
        3
        2
        5
      ]
    ];
    expected = [
      {
        row = 3;
        column = 3;
      }
    ];
  };
  "test can identify saddle points in a non square matrix" = {
    expr = saddlePoints [
      [
        3
        1
        3
      ]
      [
        3
        2
        4
      ]
    ];
    expected = [
      {
        row = 1;
        column = 1;
      }
      {
        row = 1;
        column = 3;
      }
    ];
  };
  "test can identify that saddle points in a single column matrix are those with the minimum value" =
    {
      expr = saddlePoints [
        [ 2 ]
        [ 1 ]
        [ 4 ]
        [ 1 ]
      ];
      expected = [
        {
          row = 2;
          column = 1;
        }
        {
          row = 4;
          column = 1;
        }
      ];
    };
  "test can identify that saddle points in a single row matrix are those with the maximum value" = {
    expr = saddlePoints [
      [
        2
        5
        3
        5
      ]
    ];
    expected = [
      {
        row = 1;
        column = 2;
      }
      {
        row = 1;
        column = 4;
      }
    ];
  };
}
