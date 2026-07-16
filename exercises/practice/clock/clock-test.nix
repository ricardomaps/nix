let
  inherit (import ./clock.nix)
    create
    add
    subtract
    equal
    format
    ;
in
{
  "test on the hour" = {
    expr = format (create 8 0);
    expected = "08:00";
  };

  "test past the hour" = {
    expr = format (create 11 9);
    expected = "11:09";
  };

  "test midnight is zero hours" = {
    expr = format (create 24 0);
    expected = "00:00";
  };

  "test hour rolls over" = {
    expr = format (create 25 0);
    expected = "01:00";
  };

  "test hour rolls over continuously" = {
    expr = format (create 100 0);
    expected = "04:00";
  };

  "test sixty minutes is next hour" = {
    expr = format (create 1 60);
    expected = "02:00";
  };

  "test minutes roll over" = {
    expr = format (create 0 160);
    expected = "02:40";
  };

  "test minutes roll over continuously" = {
    expr = format (create 0 1723);
    expected = "04:43";
  };

  "test hour and minutes roll over" = {
    expr = format (create 25 160);
    expected = "03:40";
  };

  "test hour and minutes roll over continuously" = {
    expr = format (create 201 3001);
    expected = "11:01";
  };

  "test hour and minutes roll over to exactly midnight" = {
    expr = format (create 72 8640);
    expected = "00:00";
  };

  "test negative hour" = {
    expr = format (create (-1) 15);
    expected = "23:15";
  };

  "test negative hour rolls over" = {
    expr = format (create (-25) 0);
    expected = "23:00";
  };

  "test negative hour rolls over continuously" = {
    expr = format (create (-91) 0);
    expected = "05:00";
  };

  "test negative minutes" = {
    expr = format (create 1 (-40));
    expected = "00:20";
  };

  "test negative minutes roll over" = {
    expr = format (create 1 (-160));
    expected = "22:20";
  };

  "test negative minutes roll over continuously" = {
    expr = format (create 1 (-4820));
    expected = "16:40";
  };

  "test negative sixty minutes is previous hour" = {
    expr = format (create 2 (-60));
    expected = "01:00";
  };

  "test negative hour and minutes both roll over" = {
    expr = format (create (-25) (-160));
    expected = "20:20";
  };

  "test negative hour and minutes both roll over continuously" = {
    expr = format (create (-121) (-5810));
    expected = "22:10";
  };

  "test add minutes" = {
    expr = format (add (create 10 0) 3);
    expected = "10:03";
  };

  "test add no minutes" = {
    expr = format (add (create 6 41) 0);
    expected = "06:41";
  };

  "test add to next hour" = {
    expr = format (add (create 0 45) 40);
    expected = "01:25";
  };

  "test add more than one hour" = {
    expr = format (add (create 10 0) 61);
    expected = "11:01";
  };

  "test add more than two hours with carry" = {
    expr = format (add (create 0 45) 160);
    expected = "03:25";
  };

  "test add across midnight" = {
    expr = format (add (create 23 59) 2);
    expected = "00:01";
  };

  "test add more than one day (1500 min = 25 hrs)" = {
    expr = format (add (create 5 32) 1500);
    expected = "06:32";
  };

  "test add more than two days" = {
    expr = format (add (create 1 1) 3500);
    expected = "11:21";
  };

  "test subtract minutes" = {
    expr = format (subtract (create 10 3) 3);
    expected = "10:00";
  };

  "test subtract to previous hour" = {
    expr = format (subtract (create 10 3) 30);
    expected = "09:33";
  };

  "test subtract more than an hour" = {
    expr = format (subtract (create 10 3) 70);
    expected = "08:53";
  };

  "test subtract across midnight" = {
    expr = format (subtract (create 0 3) 4);
    expected = "23:59";
  };

  "test subtract more than two hours" = {
    expr = format (subtract (create 0 0) 160);
    expected = "21:20";
  };

  "test subtract more than two hours with borrow" = {
    expr = format (subtract (create 6 15) 160);
    expected = "03:35";
  };

  "test subtract more than one day (1500 min = 25 hrs)" = {
    expr = format (subtract (create 5 32) 1500);
    expected = "04:32";
  };

  "test subtract more than two days" = {
    expr = format (subtract (create 2 20) 3000);
    expected = "00:20";
  };

  "test clocks with same time" = {
    expr = equal (create 15 37) (create 15 37);
    expected = true;
  };

  "test clocks a minute apart" = {
    expr = equal (create 15 36) (create 15 37);
    expected = false;
  };

  "test clocks an hour apart" = {
    expr = equal (create 14 37) (create 15 37);
    expected = false;
  };

  "test clocks with hour overflow" = {
    expr = equal (create 10 37) (create 34 37);
    expected = true;
  };

  "test clocks with hour overflow by several days" = {
    expr = equal (create 3 11) (create 99 11);
    expected = true;
  };

  "test clocks with negative hour" = {
    expr = equal (create 22 40) (create (-2) 40);
    expected = true;
  };

  "test clocks with negative hour that wraps" = {
    expr = equal (create 17 3) (create (-31) 3);
    expected = true;
  };

  "test clocks with negative hour that wraps multiple times" = {
    expr = equal (create 13 49) (create (-83) 49);
    expected = true;
  };

  "test clocks with minute overflow" = {
    expr = equal (create 0 1) (create 0 1441);
    expected = true;
  };

  "test clocks with minute overflow by several days" = {
    expr = equal (create 2 2) (create 2 4322);
    expected = true;
  };

  "test clocks with negative minute" = {
    expr = equal (create 2 40) (create 3 (-20));
    expected = true;
  };

  "test clocks with negative minute that wraps" = {
    expr = equal (create 4 10) (create 5 (-1490));
    expected = true;
  };

  "test clocks with negative minute that wraps multiple times" = {
    expr = equal (create 6 15) (create 6 (-4305));
    expected = true;
  };

  "test clocks with negative hours and minutes" = {
    expr = equal (create 7 32) (create (-12) (-268));
    expected = true;
  };

  "test clocks with negative hours and minutes that wrap" = {
    expr = equal (create 18 7) (create (-54) (-11513));
    expected = true;
  };

  "test full clock and zeroed clock" = {
    expr = equal (create 24 0) (create 0 0);
    expected = true;
  };
}
