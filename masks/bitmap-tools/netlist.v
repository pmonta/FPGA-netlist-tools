module hp35_rom_control1(input clk, input sync, output x0,x1,y0,y1,z0,z1,z2,z3,z4);

  wire n_433,n_432,n_416,n_378,n_353,n_435,n_414,n_438;
  wire n_371,n_359,n_415,y0,y1,n_341,n_389,n_362;
  wire n_361,n_367,n_340,n_407,n_401,n_424,n_440,n_427;
  wire n_420,n_422,n_409,z4,x0,x1,z0,z1;
  wire z2,z3,n_392,n_393,n_391,n_396,n_395,n_399;

  reg n_430,n_428,n_429,n_426,n_377,n_421,n_408,n_348;

  assign n_371 = ~n_401;
  assign n_340 = ~(n_435 | n_430 | n_393);
  assign n_396 = ~(n_430 | n_367);
  assign n_440 = ~n_435;
  assign n_435 = ~(n_428 | n_426 | n_433 | n_420);
  assign n_416 = ~n_430;
  assign n_367 = ~(y0 | n_440 | n_430);
  assign n_353 = ~(n_438 | n_420);
  assign n_432 = ~(n_416 | n_440 | n_393);
  assign n_415 = ~n_426;
  assign n_409 = ~(n_359 | n_389);
  assign z0 = ~n_432;
  assign n_395 = ~(n_426 | n_422);
  assign n_389 = ~(n_416 | n_420 | n_414);
  assign n_420 = ~n_348;
  assign n_427 = ~(n_428 | n_433 | n_429);
  assign n_414 = ~n_427;
  assign z2 = ~(n_428 | n_416 | n_420 | n_429 | n_424 | n_426);
  assign z4 = ~(n_392 | n_407 | n_424 | n_393 | n_416 | n_426);
  assign x1 = ~x0;
  assign n_341 = ~(n_340 | n_362);
  assign z3 = ~(n_429 | n_430 | n_415 | n_407 | n_392 | n_424);
  assign y0 = ~n_378;
  assign n_422 = ~(n_440 | n_378 | n_430);
  assign n_399 = ~(n_433 | n_426 | n_407 | n_430 | n_392 | n_393);
  assign n_438 = ~(n_440 | n_378 | n_416);
  assign n_433 = ~n_377;
  assign n_401 = ~(n_428 | n_422);
  assign z1 = ~(n_440 | n_393 | n_430);
  assign n_424 = ~n_433;
  assign n_362 = ~(n_416 | n_429);
  assign n_392 = ~n_420;
  assign n_361 = ~n_408;
  assign x0 = ~n_421;
  assign n_391 = ~(n_430 | n_392 | n_414);
  assign n_359 = ~(n_391 | n_361);
  assign y1 = ~n_399;
  assign n_393 = ~n_429;
  assign n_407 = ~n_428;
  assign n_378 = ~sync;

  always @(posedge clk) begin
    n_430 <= n_353;
    n_421 <= n_361;
    n_408 <= n_409;
    n_348 <= n_433;
    n_426 <= n_341;
    n_377 <= n_371;
    n_428 <= n_395;
    n_429 <= n_396;
  end
endmodule
