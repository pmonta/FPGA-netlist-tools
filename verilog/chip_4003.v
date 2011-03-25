`include "common.h"

module chip_4003(
  input eclk, ereset,
  input cp,
  input data_in,
  input e,
  output q0,
  output q1,
  output q2,
  output q3,
  output q4,
  output q5,
  output q6,
  output q7,
  output q8,
  output q9,
  output serial_out
);

  function v;   // convert an analog node value to 2-level
  input [`W-1:0] x;
  begin
    v = ~x[`W-1];
  end
  endfunction

  function [`W-1:0] a;   // convert a 2-level node value to analog
  input x;
  begin
    a = x ? `HI2 : `LO2;
  end
  endfunction

  wire signed [`W-1:0] diff_1466610_629970#_port_2, diff_1466610_629970#_port_3, diff_1466610_629970#_port_0, diff_1466610_629970#_v;
  wire signed [`W-1:0] diff_816720_427450#_port_2, diff_816720_427450#_port_3, diff_816720_427450#_port_0, diff_816720_427450#_port_1, diff_816720_427450#_port_4, diff_816720_427450#_port_5, diff_816720_427450#_v;
  wire signed [`W-1:0] diff_390930_685580#_port_1, diff_390930_685580#_v;
  wire signed [`W-1:0] diff_630800_686410#_port_1, diff_630800_686410#_v;
  wire signed [`W-1:0] diff_1276540_312080#_port_2, diff_1276540_312080#_port_3, diff_1276540_312080#_port_4, diff_1276540_312080#_v;
  wire signed [`W-1:0] serial_out_port_0, serial_out_port_1, serial_out_v;
  wire signed [`W-1:0] diff_1236700_234890#_port_0, diff_1236700_234890#_port_1, diff_1236700_234890#_v;
  wire signed [`W-1:0] diff_684750_321210#_port_0, diff_684750_321210#_v;
  wire signed [`W-1:0] diff_1137100_433260#_port_1, diff_1137100_433260#_v;
  wire signed [`W-1:0] diff_773560_682260#_port_0, diff_773560_682260#_v;
  wire signed [`W-1:0] diff_634950_673960#_port_0, diff_634950_673960#_port_1, diff_634950_673960#_v;
  wire signed [`W-1:0] diff_1352070_704670#_port_1, diff_1352070_704670#_v;
  wire signed [`W-1:0] diff_275560_234060#_port_0, diff_275560_234060#_port_1, diff_275560_234060#_v;
  wire signed [`W-1:0] diff_510450_712970#_port_2, diff_510450_712970#_port_3, diff_510450_712970#_port_0, diff_510450_712970#_port_1, diff_510450_712970#_port_4, diff_510450_712970#_port_5, diff_510450_712970#_v;
  wire signed [`W-1:0] diff_1013430_682260#_port_0, diff_1013430_682260#_v;
  wire signed [`W-1:0] diff_510450_738700#_port_2, diff_510450_738700#_port_3, diff_510450_738700#_port_0, diff_510450_738700#_port_4, diff_510450_738700#_port_5, diff_510450_738700#_v;
  wire signed [`W-1:0] diff_341130_652380#_port_9, diff_341130_652380#_port_10, diff_341130_652380#_v;
  wire signed [`W-1:0] diff_1466610_1008450#_port_2, diff_1466610_1008450#_port_1, diff_1466610_1008450#_v;
  wire signed [`W-1:0] data_in_port_2, data_in_port_0, data_in_v;
  wire signed [`W-1:0] diff_395080_711310#_port_0, diff_395080_711310#_port_1, diff_395080_711310#_v;
  wire signed [`W-1:0] diff_751150_712970#_port_2, diff_751150_712970#_port_3, diff_751150_712970#_port_0, diff_751150_712970#_port_1, diff_751150_712970#_port_4, diff_751150_712970#_port_5, diff_751150_712970#_v;
  wire signed [`W-1:0] diff_576020_427450#_port_2, diff_576020_427450#_port_3, diff_576020_427450#_port_0, diff_576020_427450#_port_1, diff_576020_427450#_port_4, diff_576020_427450#_port_5, diff_576020_427450#_v;
  wire signed [`W-1:0] diff_1509770_516260#_port_2, diff_1509770_516260#_port_3, diff_1509770_516260#_port_0, diff_1509770_516260#_v;
  wire signed [`W-1:0] diff_296310_846600#_port_2, diff_296310_846600#_port_0, diff_296310_846600#_port_1, diff_296310_846600#_v;
  wire signed [`W-1:0] diff_1111370_685580#_port_1, diff_1111370_685580#_v;
  wire signed [`W-1:0] diff_1231720_712970#_port_2, diff_1231720_712970#_port_3, diff_1231720_712970#_port_0, diff_1231720_712970#_port_1, diff_1231720_712970#_port_4, diff_1231720_712970#_port_5, diff_1231720_712970#_v;
  wire signed [`W-1:0] diff_1254960_682260#_port_0, diff_1254960_682260#_v;
  wire signed [`W-1:0] diff_1472420_424130#_port_2, diff_1472420_424130#_port_3, diff_1472420_424130#_port_0, diff_1472420_424130#_v;
  wire signed [`W-1:0] diff_754470_429110#_port_1, diff_754470_429110#_v;
  wire signed [`W-1:0] diff_336150_519580#_port_2, diff_336150_519580#_port_3, diff_336150_519580#_port_0, diff_336150_519580#_port_1, diff_336150_519580#_port_5, diff_336150_519580#_v;
  wire signed [`W-1:0] diff_994340_234060#_port_0, diff_994340_234060#_port_1, diff_994340_234060#_v;
  wire signed [`W-1:0] diff_314570_311250#_port_2, diff_314570_311250#_port_3, diff_314570_311250#_port_4, diff_314570_311250#_v;
  wire signed [`W-1:0] diff_816720_520410#_port_2, diff_816720_520410#_port_3, diff_816720_520410#_port_0, diff_816720_520410#_port_1, diff_816720_520410#_port_5, diff_816720_520410#_v;
  wire signed [`W-1:0] diff_544480_499660#_port_0, diff_544480_499660#_port_1, diff_544480_499660#_v;
  wire signed [`W-1:0] diff_871500_685580#_port_1, diff_871500_685580#_v;
  wire signed [`W-1:0] diff_1552100_502150#_port_0, diff_1552100_502150#_port_1, diff_1552100_502150#_v;
  wire signed [`W-1:0] diff_1273220_771900#_port_1, diff_1273220_771900#_v;
  wire signed [`W-1:0] diff_1231720_738700#_port_2, diff_1231720_738700#_port_3, diff_1231720_738700#_port_0, diff_1231720_738700#_port_4, diff_1231720_738700#_port_5, diff_1231720_738700#_v;
  wire signed [`W-1:0] diff_1376970_433260#_port_1, diff_1376970_433260#_v;
  wire signed [`W-1:0] diff_322040_502150#_port_0, diff_322040_502150#_port_1, diff_322040_502150#_v;
  wire signed [`W-1:0] diff_517090_234060#_port_0, diff_517090_234060#_port_1, diff_517090_234060#_v;
  wire signed [`W-1:0] diff_896400_434090#_port_1, diff_896400_434090#_v;
  wire signed [`W-1:0] diff_1621820_879800#_port_2, diff_1621820_879800#_port_1, diff_1621820_879800#_v;
  wire signed [`W-1:0] diff_924620_321210#_port_0, diff_924620_321210#_v;
  wire signed [`W-1:0] diff_512940_454840#_port_1, diff_512940_454840#_v;
  wire signed [`W-1:0] diff_563570_456500#_port_0, diff_563570_456500#_port_1, diff_563570_456500#_v;
  wire signed [`W-1:0] diff_551950_771900#_port_1, diff_551950_771900#_v;
  wire signed [`W-1:0] diff_512940_429940#_port_1, diff_512940_429940#_v;
  wire signed [`W-1:0] diff_1352070_685580#_port_1, diff_1352070_685580#_v;
  wire signed [`W-1:0] diff_258130_451520#_port_0, diff_258130_451520#_port_1, diff_258130_451520#_v;
  wire signed [`W-1:0] diff_1534670_282200#_port_2, diff_1534670_282200#_port_0, diff_1534670_282200#_v;
  wire signed [`W-1:0] diff_1505620_931260#_port_2, diff_1505620_931260#_port_3, diff_1505620_931260#_v;
  wire signed [`W-1:0] diff_1284840_456500#_port_0, diff_1284840_456500#_port_1, diff_1284840_456500#_v;
  wire signed [`W-1:0] diff_1365350_939560#_port_2, diff_1365350_939560#_port_1, diff_1365350_939560#_v;
  wire signed [`W-1:0] diff_993510_429110#_port_1, diff_993510_429110#_v;
  wire signed [`W-1:0] diff_993510_454010#_port_1, diff_993510_454010#_v;
  wire signed [`W-1:0] diff_232400_451520#_port_8, diff_232400_451520#_port_9, diff_232400_451520#_port_1, diff_232400_451520#_v;
  wire signed [`W-1:0] diff_1566210_789330#_port_2, diff_1566210_789330#_port_1, diff_1566210_789330#_v;
  wire signed [`W-1:0] diff_1405190_321210#_port_0, diff_1405190_321210#_v;
  wire signed [`W-1:0] diff_336150_427450#_port_2, diff_336150_427450#_port_3, diff_336150_427450#_port_0, diff_336150_427450#_port_1, diff_336150_427450#_port_4, diff_336150_427450#_port_5, diff_336150_427450#_v;
  wire signed [`W-1:0] diff_1016750_846600#_port_2, diff_1016750_846600#_port_0, diff_1016750_846600#_port_1, diff_1016750_846600#_v;
  wire signed [`W-1:0] diff_292990_681430#_port_0, diff_292990_681430#_v;
  wire signed [`W-1:0] diff_1235040_454010#_port_1, diff_1235040_454010#_v;
  wire signed [`W-1:0] diff_795140_312080#_port_2, diff_795140_312080#_port_3, diff_795140_312080#_port_4, diff_795140_312080#_v;
  wire signed [`W-1:0] q1_port_0, q1_port_1, q1_v;
  wire signed [`W-1:0] q0_port_0, q0_port_1, q0_v;
  wire signed [`W-1:0] q3_port_0, q3_port_1, q3_v;
  wire signed [`W-1:0] q2_port_0, q2_port_1, q2_v;
  wire signed [`W-1:0] q5_port_0, q5_port_1, q5_v;
  wire signed [`W-1:0] q4_port_0, q4_port_1, q4_v;
  wire signed [`W-1:0] q7_port_0, q7_port_1, q7_v;
  wire signed [`W-1:0] q6_port_0, q6_port_1, q6_v;
  wire signed [`W-1:0] q9_port_0, q9_port_1, q9_v;
  wire signed [`W-1:0] q8_port_0, q8_port_1, q8_v;
  wire signed [`W-1:0] diff_871500_704670#_port_0, diff_871500_704670#_v;
  wire signed [`W-1:0] diff_1588620_812570#_port_2, diff_1588620_812570#_port_1, diff_1588620_812570#_v;
  wire signed [`W-1:0] diff_1297290_428280#_port_2, diff_1297290_428280#_port_3, diff_1297290_428280#_port_0, diff_1297290_428280#_port_1, diff_1297290_428280#_port_5, diff_1297290_428280#_v;
  wire signed [`W-1:0] diff_634950_712140#_port_0, diff_634950_712140#_port_1, diff_634950_712140#_v;
  wire signed [`W-1:0] diff_278050_567720#_port_2, diff_278050_567720#_port_3, diff_278050_567720#_port_0, diff_278050_567720#_port_1, diff_278050_567720#_port_4, diff_278050_567720#_port_5, diff_278050_567720#_v;
  wire signed [`W-1:0] diff_1466610_655700#_port_2, diff_1466610_655700#_port_0, diff_1466610_655700#_port_1, diff_1466610_655700#_v;
  wire signed [`W-1:0] diff_1540480_996000#_port_0, diff_1540480_996000#_port_1, diff_1540480_996000#_v;
  wire signed [`W-1:0] diff_312080_771900#_port_1, diff_312080_771900#_v;
  wire signed [`W-1:0] diff_1477400_740360#_port_2, diff_1477400_740360#_port_0, diff_1477400_740360#_v;
  wire signed [`W-1:0] diff_576020_519580#_port_2, diff_576020_519580#_port_3, diff_576020_519580#_port_0, diff_576020_519580#_port_1, diff_576020_519580#_port_5, diff_576020_519580#_v;
  wire signed [`W-1:0] diff_804270_456500#_port_0, diff_804270_456500#_port_1, diff_804270_456500#_v;
  wire signed [`W-1:0] diff_1056590_427450#_port_2, diff_1056590_427450#_port_3, diff_1056590_427450#_port_0, diff_1056590_427450#_port_1, diff_1056590_427450#_port_4, diff_1056590_427450#_port_5, diff_1056590_427450#_v;
  wire signed [`W-1:0] cp_port_2, cp_port_0, cp_v;
  wire signed [`W-1:0] diff_273900_560250#_port_8, diff_273900_560250#_port_9, diff_273900_560250#_port_1, diff_273900_560250#_v;
  wire signed [`W-1:0] diff_1297290_520410#_port_2, diff_1297290_520410#_port_3, diff_1297290_520410#_port_0, diff_1297290_520410#_port_1, diff_1297290_520410#_v;
  wire signed [`W-1:0] diff_776880_846600#_port_2, diff_776880_846600#_port_0, diff_776880_846600#_port_1, diff_776880_846600#_v;
  wire signed [`W-1:0] diff_751150_738700#_port_2, diff_751150_738700#_port_3, diff_751150_738700#_port_0, diff_751150_738700#_port_4, diff_751150_738700#_port_5, diff_751150_738700#_v;
  wire signed [`W-1:0] diff_786010_499660#_port_0, diff_786010_499660#_port_1, diff_786010_499660#_v;
  wire signed [`W-1:0] diff_1235040_429110#_port_1, diff_1235040_429110#_v;
  wire signed [`W-1:0] diff_991020_712970#_port_2, diff_991020_712970#_port_3, diff_991020_712970#_port_0, diff_991020_712970#_port_1, diff_991020_712970#_port_4, diff_991020_712970#_port_5, diff_991020_712970#_v;
  wire signed [`W-1:0] diff_415830_432430#_port_1, diff_415830_432430#_v;
  wire signed [`W-1:0] diff_630800_705500#_port_0, diff_630800_705500#_v;
  wire signed [`W-1:0] diff_395080_673960#_port_0, diff_395080_673960#_port_1, diff_395080_673960#_v;
  wire signed [`W-1:0] diff_278050_543650#_port_0, diff_278050_543650#_v;
  wire signed [`W-1:0] diff_644910_939560#_port_2, diff_644910_939560#_port_1, diff_644910_939560#_v;
  wire signed [`W-1:0] diff_1111370_704670#_port_0, diff_1111370_704670#_v;
  wire signed [`W-1:0] diff_289670_464800#_port_0, diff_289670_464800#_v;
  wire signed [`W-1:0] diff_532860_681430#_port_0, diff_532860_681430#_v;
  wire signed [`W-1:0] diff_536180_846600#_port_2, diff_536180_846600#_port_0, diff_536180_846600#_port_1, diff_536180_846600#_v;
  wire signed [`W-1:0] diff_1483210_498830#_port_2, diff_1483210_498830#_port_1, diff_1483210_498830#_v;
  wire signed [`W-1:0] diff_1355390_674790#_port_0, diff_1355390_674790#_port_1, diff_1355390_674790#_v;
  wire signed [`W-1:0] diff_1505620_352750#_port_2, diff_1505620_352750#_port_3, diff_1505620_352750#_port_1, diff_1505620_352750#_v;
  wire signed [`W-1:0] diff_1548780_494680#_port_1, diff_1548780_494680#_v;
  wire signed [`W-1:0] diff_305440_456500#_port_0, diff_305440_456500#_port_1, diff_305440_456500#_v;
  wire signed [`W-1:0] diff_656530_432430#_port_1, diff_656530_432430#_v;
  wire signed [`W-1:0] diff_207500_451520#_port_9, diff_207500_451520#_port_10, diff_207500_451520#_v;
  wire signed [`W-1:0] diff_1355390_712140#_port_0, diff_1355390_712140#_port_1, diff_1355390_712140#_v;
  wire signed [`W-1:0] diff_991020_738700#_port_2, diff_991020_738700#_port_3, diff_991020_738700#_port_0, diff_991020_738700#_port_4, diff_991020_738700#_port_5, diff_991020_738700#_v;
  wire signed [`W-1:0] diff_1115520_712140#_port_0, diff_1115520_712140#_port_1, diff_1115520_712140#_v;
  wire signed [`W-1:0] diff_754470_454010#_port_1, diff_754470_454010#_v;
  wire signed [`W-1:0] diff_404210_938730#_port_2, diff_404210_938730#_port_1, diff_404210_938730#_v;
  wire signed [`W-1:0] diff_1125480_939560#_port_2, diff_1125480_939560#_port_1, diff_1125480_939560#_v;
  wire signed [`W-1:0] diff_1033350_312080#_port_2, diff_1033350_312080#_port_3, diff_1033350_312080#_port_4, diff_1033350_312080#_v;
  wire signed [`W-1:0] diff_792650_771900#_port_1, diff_792650_771900#_v;
  wire signed [`W-1:0] diff_273900_607560#_port_2, diff_273900_607560#_port_3, diff_273900_607560#_port_1, diff_273900_607560#_port_4, diff_273900_607560#_port_5, diff_273900_607560#_v;
  wire signed [`W-1:0] diff_1115520_674790#_port_0, diff_1115520_674790#_port_1, diff_1115520_674790#_v;
  wire signed [`W-1:0] diff_1043310_456500#_port_0, diff_1043310_456500#_port_1, diff_1043310_456500#_v;
  wire signed [`W-1:0] diff_1266580_499660#_port_0, diff_1266580_499660#_port_1, diff_1266580_499660#_v;
  wire signed [`W-1:0] diff_1257450_846600#_port_2, diff_1257450_846600#_port_0, diff_1257450_846600#_port_1, diff_1257450_846600#_v;
  wire signed [`W-1:0] diff_875650_712140#_port_0, diff_875650_712140#_port_1, diff_875650_712140#_v;
  wire signed [`W-1:0] diff_1025050_499660#_port_0, diff_1025050_499660#_port_1, diff_1025050_499660#_v;
  wire signed [`W-1:0] diff_444050_322040#_port_0, diff_444050_322040#_v;
  wire signed [`W-1:0] diff_875650_674790#_port_0, diff_875650_674790#_port_1, diff_875650_674790#_v;
  wire signed [`W-1:0] diff_556100_312080#_port_2, diff_556100_312080#_port_3, diff_556100_312080#_port_4, diff_556100_312080#_v;
  wire signed [`W-1:0] diff_1472420_449860#_port_2, diff_1472420_449860#_port_0, diff_1472420_449860#_port_1, diff_1472420_449860#_v;
  wire signed [`W-1:0] diff_1165320_321210#_port_0, diff_1165320_321210#_v;
  wire signed [`W-1:0] e_port_2, e_port_1, e_v;
  wire signed [`W-1:0] diff_390930_703840#_port_0, diff_390930_703840#_v;
  wire signed [`W-1:0] diff_756130_234890#_port_0, diff_756130_234890#_port_1, diff_756130_234890#_v;
  wire signed [`W-1:0] diff_1056590_520410#_port_2, diff_1056590_520410#_port_3, diff_1056590_520410#_port_0, diff_1056590_520410#_port_1, diff_1056590_520410#_port_5, diff_1056590_520410#_v;
  wire signed [`W-1:0] diff_1032520_771900#_port_1, diff_1032520_771900#_v;
  wire signed [`W-1:0] diff_884780_939560#_port_2, diff_884780_939560#_port_1, diff_884780_939560#_v;


  spice_pin_input pin_252(data_in, data_in_v, data_in_port_2);
  spice_pin_input pin_253(e, e_v, e_port_2);
  spice_pin_input pin_251(cp, cp_v, cp_port_2);

  spice_pin_output pin_256(q2, q2_v);
  spice_pin_output pin_258(q4, q4_v);
  spice_pin_output pin_259(q5, q5_v);
  spice_pin_output pin_257(q3, q3_v);
  spice_pin_output pin_254(q0, q0_v);
  spice_pin_output pin_255(q1, q1_v);
  spice_pin_output pin_264(serial_out, serial_out_v);
  spice_pin_output pin_263(q9, q9_v);
  spice_pin_output pin_261(q7, q7_v);
  spice_pin_output pin_260(q6, q6_v);
  spice_pin_output pin_262(q8, q8_v);


  spice_transistor_nmos_gnd M1422(v(diff_1297290_520410#_v), diff_1297290_428280#_v, diff_1297290_428280#_port_2);
  spice_transistor_nmos_gnd M1153(v(diff_773560_682260#_v), diff_751150_738700#_v, diff_751150_738700#_port_2);
  spice_transistor_nmos_gnd M1010(v(diff_404210_938730#_v), q4_v, q4_port_0);
  spice_transistor_nmos_gnd M1011(v(diff_312080_771900#_v), diff_296310_846600#_v, diff_296310_846600#_port_0);
  spice_transistor_nmos_gnd M1012(v(diff_207500_451520#_v), diff_296310_846600#_v, diff_296310_846600#_port_1);
  spice_transistor_nmos M1398(v(diff_273900_560250#_v), diff_1235040_429110#_v, diff_1056590_520410#_v, diff_1235040_429110#_port_1, diff_1056590_520410#_port_5);
  spice_transistor_nmos_gnd M1393(v(diff_1376970_433260#_v), diff_1297290_520410#_v, diff_1297290_520410#_port_3);
  spice_transistor_nmos_gnd M1392(v(diff_1235040_429110#_v), diff_1284840_456500#_v, diff_1284840_456500#_port_0);
  spice_transistor_nmos M1394(v(diff_232400_451520#_v), diff_1297290_428280#_v, diff_1284840_456500#_v, diff_1297290_428280#_port_0, diff_1284840_456500#_port_1);
  spice_transistor_nmos_gnd M1124(v(diff_341130_652380#_v), diff_510450_738700#_v, diff_510450_738700#_port_4);
  spice_transistor_nmos_gnd M1127(v(diff_1365350_939560#_v), q0_v, q0_port_0);
  spice_transistor_nmos_gnd M1122(v(diff_751150_738700#_v), diff_751150_712970#_v, diff_751150_712970#_port_3);
  spice_transistor_nmos M1123(v(diff_232400_451520#_v), diff_634950_673960#_v, diff_510450_738700#_v, diff_634950_673960#_port_1, diff_510450_738700#_port_3);
  spice_transistor_nmos_gnd M1087(v(diff_776880_846600#_v), diff_884780_939560#_v, diff_884780_939560#_port_1);
  spice_transistor_nmos_gnd M1084(v(diff_207500_451520#_v), diff_1016750_846600#_v, diff_1016750_846600#_port_1);
  spice_transistor_nmos_gnd M1083(v(diff_1032520_771900#_v), diff_1016750_846600#_v, diff_1016750_846600#_port_0);
  spice_transistor_nmos_gnd M1082(v(diff_1125480_939560#_v), q1_v, q1_port_0);
  spice_transistor_nmos_gnd M1080(v(diff_510450_738700#_v), diff_510450_712970#_v, diff_510450_712970#_port_3);
  spice_transistor_nmos M1265(v(diff_232400_451520#_v), diff_336150_427450#_v, diff_305440_456500#_v, diff_336150_427450#_port_0, diff_305440_456500#_port_1);
  spice_transistor_nmos_gnd M1264(v(diff_415830_432430#_v), diff_336150_519580#_v, diff_336150_519580#_port_3);
  spice_transistor_nmos_gnd M1263(v(diff_289670_464800#_v), diff_305440_456500#_v, diff_305440_456500#_port_0);
  spice_transistor_nmos_gnd M1262(v(diff_278050_543650#_v), diff_322040_502150#_v, diff_322040_502150#_port_1);
  spice_transistor_nmos_gnd M1261(v(diff_341130_652380#_v), diff_336150_519580#_v, diff_336150_519580#_port_2);
  spice_transistor_nmos M1260(v(diff_232400_451520#_v), diff_336150_519580#_v, diff_322040_502150#_v, diff_336150_519580#_port_1, diff_322040_502150#_port_0);
  spice_transistor_nmos M1064(v(diff_258130_451520#_v), diff_551950_771900#_v, diff_510450_712970#_v, diff_551950_771900#_port_1, diff_510450_712970#_port_0);
  spice_transistor_nmos M1067(v(diff_232400_451520#_v), diff_278050_567720#_v, diff_395080_711310#_v, diff_278050_567720#_port_4, diff_395080_711310#_port_0);
  spice_transistor_nmos_gnd M1308(v(diff_754470_429110#_v), diff_804270_456500#_v, diff_804270_456500#_port_0);
  spice_transistor_nmos_gnd M1309(v(diff_896400_434090#_v), diff_816720_520410#_v, diff_816720_520410#_port_3);
  spice_transistor_nmos M1305(v(diff_258130_451520#_v), diff_576020_427450#_v, diff_656530_432430#_v, diff_576020_427450#_port_3, diff_656530_432430#_port_1);
  spice_transistor_nmos M1306(v(diff_273900_560250#_v), diff_754470_454010#_v, diff_576020_427450#_v, diff_754470_454010#_port_1, diff_576020_427450#_port_4);
  spice_transistor_nmos_gnd M1300(v(diff_341130_652380#_v), diff_816720_520410#_v, diff_816720_520410#_port_2);
  spice_transistor_nmos M1068(v(diff_273900_560250#_v), diff_510450_738700#_v, diff_390930_703840#_v, diff_510450_738700#_port_0, diff_390930_703840#_port_0);
  spice_transistor_nmos_gnd M1302(v(diff_576020_519580#_v), diff_576020_427450#_v, diff_576020_427450#_port_2);
  spice_transistor_nmos_gnd M1162(v(diff_991020_738700#_v), diff_991020_712970#_v, diff_991020_712970#_port_3);
  spice_transistor_nmos M1436(v(diff_1297290_428280#_v), diff_1472420_449860#_v, diff_1505620_352750#_v, diff_1472420_449860#_port_2, diff_1505620_352750#_port_2);
  spice_transistor_nmos M1434(v(diff_258130_451520#_v), diff_1297290_428280#_v, diff_1376970_433260#_v, diff_1297290_428280#_port_3, diff_1376970_433260#_port_1);
  spice_transistor_nmos_gnd M1430(v(diff_1472420_424130#_v), diff_1505620_352750#_v, diff_1505620_352750#_port_1);
  spice_transistor_nmos M1119(v(diff_258130_451520#_v), diff_773560_682260#_v, diff_751150_712970#_v, diff_773560_682260#_port_0, diff_751150_712970#_port_2);
  spice_transistor_nmos M1118(v(diff_273900_560250#_v), diff_751150_712970#_v, diff_630800_686410#_v, diff_751150_712970#_port_1, diff_630800_686410#_port_1);
  spice_transistor_nmos_gnd M1115(v(diff_630800_686410#_v), diff_634950_673960#_v, diff_634950_673960#_port_0);
  spice_transistor_nmos_gnd M1114(v(diff_630800_705500#_v), diff_634950_712140#_v, diff_634950_712140#_port_1);
  spice_transistor_nmos_gnd M1113(v(diff_532860_681430#_v), diff_510450_738700#_v, diff_510450_738700#_port_2);
  spice_transistor_nmos_gnd M1184(v(diff_1566210_789330#_v), diff_1588620_812570#_v, diff_1588620_812570#_port_1);
  spice_transistor_nmos_gnd M1164(v(diff_1257450_846600#_v), diff_1365350_939560#_v, diff_1365350_939560#_port_1);
  spice_transistor_nmos_vdd M1167(v(diff_1257450_846600#_v), q0_v, q0_port_1);
  spice_transistor_nmos_gnd M1340(v(diff_341130_652380#_v), diff_1056590_520410#_v, diff_1056590_520410#_port_2);
  spice_transistor_nmos_gnd M1341(v(diff_993510_454010#_v), diff_1025050_499660#_v, diff_1025050_499660#_port_1);
  spice_transistor_nmos_gnd M1342(v(diff_816720_520410#_v), diff_816720_427450#_v, diff_816720_427450#_port_2);
  spice_transistor_nmos M1435(v(diff_1297290_520410#_v), diff_1472420_449860#_v, diff_1472420_424130#_v, diff_1472420_449860#_port_1, diff_1472420_424130#_port_2);
  spice_transistor_nmos M1345(v(diff_258130_451520#_v), diff_816720_427450#_v, diff_896400_434090#_v, diff_816720_427450#_port_3, diff_896400_434090#_port_1);
  spice_transistor_nmos M1346(v(diff_273900_560250#_v), diff_993510_454010#_v, diff_816720_427450#_v, diff_993510_454010#_port_1, diff_816720_427450#_port_4);
  spice_transistor_nmos_gnd M1348(v(diff_993510_429110#_v), diff_1043310_456500#_v, diff_1043310_456500#_port_0);
  spice_transistor_nmos_gnd M1349(v(diff_1137100_433260#_v), diff_1056590_520410#_v, diff_1056590_520410#_port_3);
  spice_transistor_nmos M1438(v(diff_258130_451520#_v), diff_1297290_428280#_v, diff_1405190_321210#_v, diff_1297290_428280#_port_5, diff_1405190_321210#_port_0);
  spice_transistor_nmos M1185(v(diff_258130_451520#_v), diff_1273220_771900#_v, diff_1231720_712970#_v, diff_1273220_771900#_port_1, diff_1231720_712970#_port_0);
  spice_transistor_nmos_gnd M1183(v(diff_1588620_812570#_v), diff_1505620_931260#_v, diff_1505620_931260#_port_2);
  spice_transistor_nmos_gnd M1180(v(diff_1505620_931260#_v), diff_1621820_879800#_v, diff_1621820_879800#_port_2);
  spice_transistor_nmos_gnd M1021(v(diff_551950_771900#_v), diff_536180_846600#_v, diff_536180_846600#_port_0);
  spice_transistor_nmos_gnd M1020(v(diff_644910_939560#_v), q3_v, q3_port_0);
  spice_transistor_nmos_gnd M1022(v(diff_207500_451520#_v), diff_536180_846600#_v, diff_536180_846600#_port_1);
  spice_transistor_nmos_gnd M1025(v(diff_296310_846600#_v), diff_404210_938730#_v, diff_404210_938730#_port_1);
  spice_transistor_nmos M1188(v(diff_232400_451520#_v), diff_991020_712970#_v, diff_1115520_712140#_v, diff_991020_712970#_port_5, diff_1115520_712140#_port_0);
  spice_transistor_nmos M1189(v(diff_273900_560250#_v), diff_1231720_738700#_v, diff_1111370_704670#_v, diff_1231720_738700#_port_0, diff_1111370_704670#_port_0);
  spice_transistor_nmos M1390(v(diff_273900_560250#_v), diff_1235040_454010#_v, diff_1056590_427450#_v, diff_1235040_454010#_port_1, diff_1056590_427450#_port_4);
  spice_transistor_nmos_gnd M1335(v(diff_444050_322040#_v), diff_314570_311250#_v, diff_314570_311250#_port_4);
  spice_transistor_nmos_gnd M1334(v(diff_207500_451520#_v), diff_314570_311250#_v, diff_314570_311250#_port_3);
  spice_transistor_nmos_gnd M1336(v(diff_517090_234060#_v), q6_v, q6_port_1);
  spice_transistor_nmos_gnd M1331(v(diff_556100_312080#_v), diff_517090_234060#_v, diff_517090_234060#_port_1);
  spice_transistor_nmos M1339(v(diff_232400_451520#_v), diff_1056590_520410#_v, diff_1025050_499660#_v, diff_1056590_520410#_port_1, diff_1025050_499660#_port_0);
  spice_transistor_nmos M1233(v(diff_273900_560250#_v), diff_1466610_629970#_v, diff_1352070_685580#_v, diff_1466610_629970#_port_2, diff_1352070_685580#_port_1);
  spice_transistor_nmos_gnd M1479(v(diff_207500_451520#_v), diff_1276540_312080#_v, diff_1276540_312080#_port_3);
  spice_transistor_nmos M1150(v(diff_273900_560250#_v), diff_991020_738700#_v, diff_871500_704670#_v, diff_991020_738700#_port_0, diff_871500_704670#_port_0);
  spice_transistor_nmos_gnd M1155(v(diff_871500_685580#_v), diff_875650_674790#_v, diff_875650_674790#_port_0);
  spice_transistor_nmos_gnd M1154(v(diff_871500_704670#_v), diff_875650_712140#_v, diff_875650_712140#_port_1);
  spice_transistor_nmos M1159(v(diff_258130_451520#_v), diff_1013430_682260#_v, diff_991020_712970#_v, diff_1013430_682260#_port_0, diff_991020_712970#_port_2);
  spice_transistor_nmos M1158(v(diff_273900_560250#_v), diff_991020_712970#_v, diff_871500_685580#_v, diff_991020_712970#_port_1, diff_871500_685580#_port_1);
  spice_transistor_nmos_vdd M1092(v(diff_776880_846600#_v), q2_v, q2_port_1);
  spice_transistor_nmos_gnd M1270(v(diff_512940_454840#_v), diff_544480_499660#_v, diff_544480_499660#_port_1);
  spice_transistor_nmos_gnd M1271(v(diff_336150_519580#_v), diff_336150_427450#_v, diff_336150_427450#_port_2);
  spice_transistor_nmos M1274(v(diff_258130_451520#_v), diff_336150_427450#_v, diff_415830_432430#_v, diff_336150_427450#_port_3, diff_415830_432430#_port_1);
  spice_transistor_nmos M1275(v(diff_273900_560250#_v), diff_512940_454840#_v, diff_336150_427450#_v, diff_512940_454840#_port_1, diff_336150_427450#_port_4);
  spice_transistor_nmos_gnd M1277(v(diff_512940_429940#_v), diff_563570_456500#_v, diff_563570_456500#_port_0);
  spice_transistor_nmos_gnd M1278(v(diff_656530_432430#_v), diff_576020_519580#_v, diff_576020_519580#_port_3);
  spice_transistor_nmos M1279(v(diff_232400_451520#_v), diff_576020_427450#_v, diff_563570_456500#_v, diff_576020_427450#_port_0, diff_563570_456500#_port_1);
  spice_transistor_nmos M1076(v(diff_273900_560250#_v), diff_510450_712970#_v, diff_390930_685580#_v, diff_510450_712970#_port_1, diff_390930_685580#_port_1);
  spice_transistor_nmos M1077(v(diff_258130_451520#_v), diff_532860_681430#_v, diff_510450_712970#_v, diff_532860_681430#_port_0, diff_510450_712970#_port_2);
  spice_transistor_nmos_gnd M1072(v(diff_390930_703840#_v), diff_395080_711310#_v, diff_395080_711310#_port_1);
  spice_transistor_nmos_gnd M1073(v(diff_390930_685580#_v), diff_395080_673960#_v, diff_395080_673960#_port_0);
  spice_transistor_nmos_gnd M1071(v(diff_292990_681430#_v), diff_273900_607560#_v, diff_273900_607560#_port_1);
  spice_transistor_nmos_gnd M1371(v(diff_795140_312080#_v), diff_756130_234890#_v, diff_756130_234890#_port_1);
  spice_transistor_nmos_gnd M1375(v(diff_684750_321210#_v), diff_556100_312080#_v, diff_556100_312080#_port_4);
  spice_transistor_nmos_gnd M1374(v(diff_207500_451520#_v), diff_556100_312080#_v, diff_556100_312080#_port_3);
  spice_transistor_nmos_gnd M1376(v(diff_756130_234890#_v), q7_v, q7_port_1);
  spice_transistor_nmos_gnd M1128(v(diff_1273220_771900#_v), diff_1257450_846600#_v, diff_1257450_846600#_port_0);
  spice_transistor_nmos_gnd M1129(v(diff_207500_451520#_v), diff_1257450_846600#_v, diff_1257450_846600#_port_1);
  spice_transistor_nmos_gnd M1384(v(diff_341130_652380#_v), diff_1297290_520410#_v, diff_1297290_520410#_port_2);
  spice_transistor_nmos_gnd M1385(v(diff_1235040_454010#_v), diff_1266580_499660#_v, diff_1266580_499660#_port_1);
  spice_transistor_nmos_gnd M1386(v(diff_1056590_520410#_v), diff_1056590_427450#_v, diff_1056590_427450#_port_2);
  spice_transistor_nmos_gnd M1380(v(diff_1483210_498830#_v), diff_341130_652380#_v, diff_341130_652380#_port_10);
  spice_transistor_nmos M1383(v(diff_232400_451520#_v), diff_1297290_520410#_v, diff_1266580_499660#_v, diff_1297290_520410#_port_1, diff_1266580_499660#_port_0);
  spice_transistor_nmos M1389(v(diff_258130_451520#_v), diff_1056590_427450#_v, diff_1137100_433260#_v, diff_1056590_427450#_port_3, diff_1137100_433260#_port_1);
  spice_transistor_nmos_gnd M1204(v(diff_1231720_738700#_v), diff_1231720_712970#_v, diff_1231720_712970#_port_3);
  spice_transistor_nmos M1201(v(diff_258130_451520#_v), diff_1254960_682260#_v, diff_1231720_712970#_v, diff_1254960_682260#_port_0, diff_1231720_712970#_port_2);
  spice_transistor_nmos M1200(v(diff_273900_560250#_v), diff_1231720_712970#_v, diff_1111370_685580#_v, diff_1231720_712970#_port_1, diff_1111370_685580#_port_1);
  spice_transistor_nmos_gnd M1269(v(diff_341130_652380#_v), diff_576020_519580#_v, diff_576020_519580#_port_2);
  spice_transistor_nmos M1268(v(diff_232400_451520#_v), diff_576020_519580#_v, diff_544480_499660#_v, diff_576020_519580#_port_1, diff_544480_499660#_port_0);
  spice_transistor_nmos_gnd M1425(v(diff_1505620_931260#_v), diff_1509770_516260#_v, diff_1509770_516260#_port_2);
  spice_transistor_nmos M1108(v(diff_232400_451520#_v), diff_395080_673960#_v, diff_273900_607560#_v, diff_395080_673960#_port_1, diff_273900_607560#_port_2);
  spice_transistor_nmos_gnd M1109(v(diff_341130_652380#_v), diff_273900_607560#_v, diff_273900_607560#_port_3);
  spice_transistor_nmos M1104(v(diff_232400_451520#_v), diff_510450_712970#_v, diff_634950_712140#_v, diff_510450_712970#_port_5, diff_634950_712140#_port_0);
  spice_transistor_nmos M1105(v(diff_273900_560250#_v), diff_751150_738700#_v, diff_630800_705500#_v, diff_751150_738700#_port_0, diff_630800_705500#_port_0);
  spice_transistor_nmos M1101(v(diff_258130_451520#_v), diff_792650_771900#_v, diff_751150_712970#_v, diff_792650_771900#_port_1, diff_751150_712970#_port_0);
  spice_transistor_nmos M1426(v(diff_1483210_498830#_v), diff_1509770_516260#_v, diff_1552100_502150#_v, diff_1509770_516260#_port_3, diff_1552100_502150#_port_0);
  spice_transistor_nmos_gnd M1423(v(diff_1509770_516260#_v), diff_1483210_498830#_v, diff_1483210_498830#_port_2);
  spice_transistor_nmos M1350(v(diff_232400_451520#_v), diff_1056590_427450#_v, diff_1043310_456500#_v, diff_1056590_427450#_port_0, diff_1043310_456500#_port_1);
  spice_transistor_nmos_gnd M1301(v(diff_754470_454010#_v), diff_786010_499660#_v, diff_786010_499660#_port_1);
  spice_transistor_nmos M1401(v(diff_258130_451520#_v), diff_1056590_427450#_v, diff_1165320_321210#_v, diff_1056590_427450#_port_5, diff_1165320_321210#_port_0);
  spice_transistor_nmos_gnd M1429(v(diff_273900_560250#_v), diff_1472420_449860#_v, diff_1472420_449860#_port_0);
  spice_transistor_nmos M1039(v(diff_258130_451520#_v), diff_312080_771900#_v, diff_278050_567720#_v, diff_312080_771900#_port_1, diff_278050_567720#_port_0);
  spice_transistor_nmos_vdd M1030(v(diff_296310_846600#_v), q4_v, q4_port_1);
  spice_transistor_nmos_vdd M1326(v(diff_556100_312080#_v), q6_v, q6_port_0);
  spice_transistor_nmos M1146(v(diff_258130_451520#_v), diff_1032520_771900#_v, diff_991020_712970#_v, diff_1032520_771900#_port_1, diff_991020_712970#_port_0);
  spice_transistor_nmos M1149(v(diff_232400_451520#_v), diff_751150_712970#_v, diff_875650_712140#_v, diff_751150_712970#_port_5, diff_875650_712140#_port_0);
  spice_transistor_nmos M1286(v(diff_258130_451520#_v), diff_336150_427450#_v, diff_444050_322040#_v, diff_336150_427450#_port_5, diff_444050_322040#_port_0);
  spice_transistor_nmos M1283(v(diff_273900_560250#_v), diff_512940_429940#_v, diff_336150_519580#_v, diff_512940_429940#_port_1, diff_336150_519580#_port_5);
  spice_transistor_nmos M1040(v(diff_258130_451520#_v), diff_292990_681430#_v, diff_278050_567720#_v, diff_292990_681430#_port_0, diff_278050_567720#_port_1);
  spice_transistor_nmos_gnd M1047(v(diff_207500_451520#_v), diff_776880_846600#_v, diff_776880_846600#_port_1);
  spice_transistor_nmos_gnd M1046(v(diff_792650_771900#_v), diff_776880_846600#_v, diff_776880_846600#_port_0);
  spice_transistor_nmos_gnd M1045(v(diff_884780_939560#_v), q2_v, q2_port_0);
  spice_transistor_nmos_vdd M1366(v(diff_795140_312080#_v), q7_v, q7_port_0);
  spice_transistor_nmos_vdd M1449(v(diff_1276540_312080#_v), q9_v, q9_port_0);
  spice_transistor_nmos_gnd M1217(v(diff_1254960_682260#_v), diff_1231720_738700#_v, diff_1231720_738700#_port_2);
  spice_transistor_nmos M1214(v(diff_232400_451520#_v), diff_1115520_674790#_v, diff_991020_738700#_v, diff_1115520_674790#_port_1, diff_991020_738700#_port_3);
  spice_transistor_nmos_gnd M1215(v(diff_341130_652380#_v), diff_991020_738700#_v, diff_991020_738700#_port_4);
  spice_transistor_nmos_gnd M1212(v(vss_v), cp_v, cp_port_0);
  spice_transistor_nmos M1213(v(diff_232400_451520#_v), diff_1231720_712970#_v, diff_1355390_712140#_v, diff_1231720_712970#_port_5, diff_1355390_712140#_port_0);
  spice_transistor_nmos_gnd M1211(v(vss_v), data_in_v, data_in_port_0);
  spice_transistor_nmos_gnd M1218(v(diff_1352070_704670#_v), diff_1355390_712140#_v, diff_1355390_712140#_port_1);
  spice_transistor_nmos_gnd M1219(v(diff_1477400_740360#_v), diff_1566210_789330#_v, diff_1566210_789330#_port_1);
  spice_transistor_nmos_gnd M1132(v(diff_1016750_846600#_v), diff_1125480_939560#_v, diff_1125480_939560#_port_1);
  spice_transistor_nmos_vdd M1137(v(diff_1016750_846600#_v), q1_v, q1_port_1);
  spice_transistor_nmos_gnd M1007(v(diff_1540480_996000#_v), diff_1466610_1008450#_v, diff_1466610_1008450#_port_2);
  spice_transistor_nmos_gnd M1005(v(diff_1466610_1008450#_v), diff_258130_451520#_v, diff_258130_451520#_port_1);
  spice_transistor_nmos_gnd M1004(v(diff_232400_451520#_v), diff_1540480_996000#_v, diff_1540480_996000#_port_1);
  spice_transistor_nmos_gnd M1418(v(diff_207500_451520#_v), diff_795140_312080#_v, diff_795140_312080#_port_3);
  spice_transistor_nmos_gnd M1419(v(diff_924620_321210#_v), diff_795140_312080#_v, diff_795140_312080#_port_4);
  spice_transistor_nmos_gnd M1415(v(diff_1033350_312080#_v), diff_994340_234060#_v, diff_994340_234060#_port_1);
  spice_transistor_nmos_vdd M1410(v(diff_1033350_312080#_v), q8_v, q8_port_0);
  spice_transistor_nmos_gnd M1009(v(diff_232400_451520#_v), diff_273900_560250#_v, diff_273900_560250#_port_1);
  spice_transistor_nmos_gnd M1008(v(diff_273900_560250#_v), diff_232400_451520#_v, diff_232400_451520#_port_1);
  spice_transistor_nmos_gnd M1488(v(vss_v), e_v, e_port_1);
  spice_transistor_nmos_gnd M1480(v(diff_1405190_321210#_v), diff_1276540_312080#_v, diff_1276540_312080#_port_4);
  spice_transistor_nmos_gnd M1487(v(diff_1505620_352750#_v), diff_1534670_282200#_v, diff_1534670_282200#_port_2);
  spice_transistor_nmos_gnd M1485(v(diff_1534670_282200#_v), serial_out_v, serial_out_port_1);
  spice_transistor_nmos M1310(v(diff_232400_451520#_v), diff_816720_427450#_v, diff_804270_456500#_v, diff_816720_427450#_port_0, diff_804270_456500#_port_1);
  spice_transistor_nmos M1317(v(diff_258130_451520#_v), diff_576020_427450#_v, diff_684750_321210#_v, diff_576020_427450#_port_5, diff_684750_321210#_port_0);
  spice_transistor_nmos M1314(v(diff_273900_560250#_v), diff_754470_429110#_v, diff_576020_519580#_v, diff_754470_429110#_port_1, diff_576020_519580#_port_5);
  spice_transistor_nmos M1256(v(diff_273900_560250#_v), diff_278050_567720#_v, diff_278050_543650#_v, diff_278050_567720#_port_5, diff_278050_543650#_port_0);
  spice_transistor_nmos M1257(v(diff_273900_560250#_v), diff_273900_607560#_v, diff_289670_464800#_v, diff_273900_607560#_port_5, diff_289670_464800#_port_0);
  spice_transistor_nmos_gnd M1043(v(diff_273900_607560#_v), diff_278050_567720#_v, diff_278050_567720#_port_2);
  spice_transistor_nmos_vdd M1473(v(diff_1505620_352750#_v), serial_out_v, serial_out_port_0);
  spice_transistor_nmos_gnd M1174(v(diff_1505620_931260#_v), diff_273900_560250#_v, diff_273900_560250#_port_8);
  spice_transistor_nmos_gnd M1173(v(diff_1621820_879800#_v), diff_232400_451520#_v, diff_232400_451520#_port_8);
  spice_transistor_nmos M1357(v(diff_258130_451520#_v), diff_816720_427450#_v, diff_924620_321210#_v, diff_816720_427450#_port_5, diff_924620_321210#_port_0);
  spice_transistor_nmos_gnd M1427(v(diff_1548780_494680#_v), diff_1552100_502150#_v, diff_1552100_502150#_port_1);
  spice_transistor_nmos M1354(v(diff_273900_560250#_v), diff_993510_429110#_v, diff_816720_520410#_v, diff_993510_429110#_port_1, diff_816720_520410#_port_5);
  spice_transistor_nmos_gnd M1420(v(diff_994340_234060#_v), q8_v, q8_port_1);
  spice_transistor_nmos M1299(v(diff_232400_451520#_v), diff_816720_520410#_v, diff_786010_499660#_v, diff_816720_520410#_port_1, diff_786010_499660#_port_0);
  spice_transistor_nmos_gnd M1296(v(diff_275560_234060#_v), q5_v, q5_port_1);
  spice_transistor_nmos_gnd M1476(v(e_v), diff_207500_451520#_v, diff_207500_451520#_port_10);
  spice_transistor_nmos_gnd M1295(v(diff_314570_311250#_v), diff_275560_234060#_v, diff_275560_234060#_port_1);
  spice_transistor_nmos_vdd M1292(v(diff_314570_311250#_v), q5_v, q5_port_0);
  spice_transistor_nmos_gnd M1428(v(diff_1505620_352750#_v), diff_1472420_424130#_v, diff_1472420_424130#_port_0);
  spice_transistor_nmos_gnd M1195(v(diff_1013430_682260#_v), diff_991020_738700#_v, diff_991020_738700#_port_2);
  spice_transistor_nmos_gnd M1197(v(diff_1111370_685580#_v), diff_1115520_674790#_v, diff_1115520_674790#_port_0);
  spice_transistor_nmos_gnd M1196(v(diff_1111370_704670#_v), diff_1115520_712140#_v, diff_1115520_712140#_port_1);
  spice_transistor_nmos_gnd M1193(v(diff_341130_652380#_v), diff_751150_738700#_v, diff_751150_738700#_port_4);
  spice_transistor_nmos M1192(v(diff_232400_451520#_v), diff_875650_674790#_v, diff_751150_738700#_v, diff_875650_674790#_port_1, diff_751150_738700#_port_3);
  spice_transistor_nmos_vdd M1055(v(diff_536180_846600#_v), q3_v, q3_port_1);
  spice_transistor_nmos_gnd M1050(v(diff_536180_846600#_v), diff_644910_939560#_v, diff_644910_939560#_port_1);
  spice_transistor_nmos_gnd M1454(v(diff_1276540_312080#_v), diff_1236700_234890#_v, diff_1236700_234890#_port_1);
  spice_transistor_nmos_gnd M1457(v(diff_207500_451520#_v), diff_1033350_312080#_v, diff_1033350_312080#_port_3);
  spice_transistor_nmos_gnd M1458(v(diff_1165320_321210#_v), diff_1033350_312080#_v, diff_1033350_312080#_port_4);
  spice_transistor_nmos_gnd M1459(v(diff_1236700_234890#_v), q9_v, q9_port_1);
  spice_transistor_nmos_gnd M1223(v(diff_341130_652380#_v), diff_1231720_738700#_v, diff_1231720_738700#_port_4);
  spice_transistor_nmos M1222(v(diff_232400_451520#_v), diff_1355390_674790#_v, diff_1231720_738700#_v, diff_1355390_674790#_port_1, diff_1231720_738700#_port_3);
  spice_transistor_nmos_gnd M1221(v(diff_1352070_685580#_v), diff_1355390_674790#_v, diff_1355390_674790#_port_0);
  spice_transistor_nmos_gnd M1220(v(cp_v), diff_1477400_740360#_v, diff_1477400_740360#_port_2);
  spice_transistor_nmos_gnd M1226(v(diff_1466610_629970#_v), diff_1466610_655700#_v, diff_1466610_655700#_port_1);
  spice_transistor_nmos_gnd M1225(v(data_in_v), diff_1466610_629970#_v, diff_1466610_629970#_port_0);
  spice_transistor_nmos M1229(v(diff_273900_560250#_v), diff_1466610_655700#_v, diff_1352070_704670#_v, diff_1466610_655700#_port_2, diff_1352070_704670#_port_1);

  spice_pullup pullup_52(diff_273900_607560#_v, diff_273900_607560#_port_4);
  spice_pullup pullup_174(diff_1056590_520410#_v, diff_1056590_520410#_port_0);
  spice_pullup pullup_173(diff_816720_427450#_v, diff_816720_427450#_port_1);
  spice_pullup pullup_17(diff_404210_938730#_v, diff_404210_938730#_port_2);
  spice_pullup pullup_18(diff_536180_846600#_v, diff_536180_846600#_port_2);
  spice_pullup pullup_85(diff_273900_560250#_v, diff_273900_560250#_port_9);
  spice_pullup pullup_86(diff_232400_451520#_v, diff_232400_451520#_port_9);
  spice_pullup pullup_87(diff_1621820_879800#_v, diff_1621820_879800#_port_1);
  spice_pullup pullup_82(diff_1365350_939560#_v, diff_1365350_939560#_port_2);
  spice_pullup pullup_104(diff_1477400_740360#_v, diff_1477400_740360#_port_0);
  spice_pullup pullup_105(diff_1505620_931260#_v, diff_1505620_931260#_port_3);
  spice_pullup pullup_106(diff_1588620_812570#_v, diff_1588620_812570#_port_2);
  spice_pullup pullup_1(diff_1540480_996000#_v, diff_1540480_996000#_port_0);
  spice_pullup pullup_0(diff_258130_451520#_v, diff_258130_451520#_port_0);
  spice_pullup pullup_210(diff_795140_312080#_v, diff_795140_312080#_port_2);
  spice_pullup pullup_211(diff_994340_234060#_v, diff_994340_234060#_port_0);
  spice_pullup pullup_217(diff_1297290_428280#_v, diff_1297290_428280#_port_1);
  spice_pullup pullup_193(diff_1056590_427450#_v, diff_1056590_427450#_port_1);
  spice_pullup pullup_197(diff_1509770_516260#_v, diff_1509770_516260#_port_0);
  spice_pullup pullup_195(diff_341130_652380#_v, diff_341130_652380#_port_9);
  spice_pullup pullup_194(diff_1297290_520410#_v, diff_1297290_520410#_port_0);
  spice_pullup pullup_198(diff_1483210_498830#_v, diff_1483210_498830#_port_1);
  spice_pullup pullup_45(diff_884780_939560#_v, diff_884780_939560#_port_2);
  spice_pullup pullup_46(diff_1016750_846600#_v, diff_1016750_846600#_port_2);
  spice_pullup pullup_103(diff_1231720_712970#_v, diff_1231720_712970#_port_4);
  spice_pullup pullup_4(diff_1466610_1008450#_v, diff_1466610_1008450#_port_1);
  spice_pullup pullup_149(diff_275560_234060#_v, diff_275560_234060#_port_0);
  spice_pullup pullup_241(diff_1276540_312080#_v, diff_1276540_312080#_port_2);
  spice_pullup pullup_240(diff_1548780_494680#_v, diff_1548780_494680#_port_1);
  spice_pullup pullup_247(diff_1534670_282200#_v, diff_1534670_282200#_port_0);
  spice_pullup pullup_79(diff_991020_712970#_v, diff_991020_712970#_port_4);
  spice_pullup pullup_242(diff_207500_451520#_v, diff_207500_451520#_port_9);
  spice_pullup pullup_112(diff_991020_738700#_v, diff_991020_738700#_port_5);
  spice_pullup pullup_39(diff_510450_712970#_v, diff_510450_712970#_port_4);
  spice_pullup pullup_120(diff_1466610_655700#_v, diff_1466610_655700#_port_0);
  spice_pullup pullup_126(diff_1466610_629970#_v, diff_1466610_629970#_port_3);
  spice_pullup pullup_127(diff_336150_519580#_v, diff_336150_519580#_port_0);
  spice_pullup pullup_124(diff_1231720_738700#_v, diff_1231720_738700#_port_5);
  spice_pullup pullup_154(diff_816720_520410#_v, diff_816720_520410#_port_0);
  spice_pullup pullup_153(diff_576020_427450#_v, diff_576020_427450#_port_1);
  spice_pullup pullup_234(diff_1236700_234890#_v, diff_1236700_234890#_port_0);
  spice_pullup pullup_232(diff_1472420_424130#_v, diff_1472420_424130#_port_3);
  spice_pullup pullup_233(diff_1033350_312080#_v, diff_1033350_312080#_port_2);
  spice_pullup pullup_231(diff_1505620_352750#_v, diff_1505620_352750#_port_3);
  spice_pullup pullup_62(diff_751150_712970#_v, diff_751150_712970#_port_4);
  spice_pullup pullup_61(diff_510450_738700#_v, diff_510450_738700#_port_5);
  spice_pullup pullup_68(diff_1125480_939560#_v, diff_1125480_939560#_port_2);
  spice_pullup pullup_69(diff_1257450_846600#_v, diff_1257450_846600#_port_2);
  spice_pullup pullup_166(diff_314570_311250#_v, diff_314570_311250#_port_2);
  spice_pullup pullup_167(diff_517090_234060#_v, diff_517090_234060#_port_0);
  spice_pullup pullup_11(diff_296310_846600#_v, diff_296310_846600#_port_2);
  spice_pullup pullup_28(diff_644910_939560#_v, diff_644910_939560#_port_2);
  spice_pullup pullup_29(diff_776880_846600#_v, diff_776880_846600#_port_2);
  spice_pullup pullup_22(diff_278050_567720#_v, diff_278050_567720#_port_3);
  spice_pullup pullup_220(diff_1566210_789330#_v, diff_1566210_789330#_port_2);
  spice_pullup pullup_96(diff_751150_738700#_v, diff_751150_738700#_port_5);
  spice_pullup pullup_137(diff_576020_519580#_v, diff_576020_519580#_port_0);
  spice_pullup pullup_136(diff_336150_427450#_v, diff_336150_427450#_port_1);
  spice_pullup pullup_186(diff_556100_312080#_v, diff_556100_312080#_port_2);
  spice_pullup pullup_187(diff_756130_234890#_v, diff_756130_234890#_port_0);




  spice_node_3 n_diff_1466610_629970#(eclk, ereset, diff_1466610_629970#_port_2,diff_1466610_629970#_port_3,diff_1466610_629970#_port_0, diff_1466610_629970#_v);
  spice_node_6 n_diff_816720_427450#(eclk, ereset, diff_816720_427450#_port_2,diff_816720_427450#_port_3,diff_816720_427450#_port_0,diff_816720_427450#_port_1,diff_816720_427450#_port_4,diff_816720_427450#_port_5, diff_816720_427450#_v);
  spice_node_1 n_diff_390930_685580#(eclk, ereset, diff_390930_685580#_port_1, diff_390930_685580#_v);
  spice_node_1 n_diff_630800_686410#(eclk, ereset, diff_630800_686410#_port_1, diff_630800_686410#_v);
  spice_node_3 n_diff_1276540_312080#(eclk, ereset, diff_1276540_312080#_port_2,diff_1276540_312080#_port_3,diff_1276540_312080#_port_4, diff_1276540_312080#_v);
  spice_node_2 n_serial_out(eclk, ereset, serial_out_port_0,serial_out_port_1, serial_out_v);
  spice_node_2 n_diff_1236700_234890#(eclk, ereset, diff_1236700_234890#_port_0,diff_1236700_234890#_port_1, diff_1236700_234890#_v);
  spice_node_1 n_diff_684750_321210#(eclk, ereset, diff_684750_321210#_port_0, diff_684750_321210#_v);
  spice_node_1 n_diff_1137100_433260#(eclk, ereset, diff_1137100_433260#_port_1, diff_1137100_433260#_v);
  spice_node_1 n_diff_773560_682260#(eclk, ereset, diff_773560_682260#_port_0, diff_773560_682260#_v);
  spice_node_2 n_diff_634950_673960#(eclk, ereset, diff_634950_673960#_port_0,diff_634950_673960#_port_1, diff_634950_673960#_v);
  spice_node_1 n_diff_1352070_704670#(eclk, ereset, diff_1352070_704670#_port_1, diff_1352070_704670#_v);
  spice_node_2 n_diff_275560_234060#(eclk, ereset, diff_275560_234060#_port_0,diff_275560_234060#_port_1, diff_275560_234060#_v);
  spice_node_6 n_diff_510450_712970#(eclk, ereset, diff_510450_712970#_port_2,diff_510450_712970#_port_3,diff_510450_712970#_port_0,diff_510450_712970#_port_1,diff_510450_712970#_port_4,diff_510450_712970#_port_5, diff_510450_712970#_v);
  spice_node_1 n_diff_1013430_682260#(eclk, ereset, diff_1013430_682260#_port_0, diff_1013430_682260#_v);
  spice_node_5 n_diff_510450_738700#(eclk, ereset, diff_510450_738700#_port_2,diff_510450_738700#_port_3,diff_510450_738700#_port_0,diff_510450_738700#_port_4,diff_510450_738700#_port_5, diff_510450_738700#_v);
  spice_node_2 n_diff_341130_652380#(eclk, ereset, diff_341130_652380#_port_9,diff_341130_652380#_port_10, diff_341130_652380#_v);
  spice_node_2 n_diff_1466610_1008450#(eclk, ereset, diff_1466610_1008450#_port_2,diff_1466610_1008450#_port_1, diff_1466610_1008450#_v);
  spice_node_2 n_data_in(eclk, ereset, data_in_port_2,data_in_port_0, data_in_v);
  spice_node_2 n_diff_395080_711310#(eclk, ereset, diff_395080_711310#_port_0,diff_395080_711310#_port_1, diff_395080_711310#_v);
  spice_node_6 n_diff_751150_712970#(eclk, ereset, diff_751150_712970#_port_2,diff_751150_712970#_port_3,diff_751150_712970#_port_0,diff_751150_712970#_port_1,diff_751150_712970#_port_4,diff_751150_712970#_port_5, diff_751150_712970#_v);
  spice_node_6 n_diff_576020_427450#(eclk, ereset, diff_576020_427450#_port_2,diff_576020_427450#_port_3,diff_576020_427450#_port_0,diff_576020_427450#_port_1,diff_576020_427450#_port_4,diff_576020_427450#_port_5, diff_576020_427450#_v);
  spice_node_3 n_diff_1509770_516260#(eclk, ereset, diff_1509770_516260#_port_2,diff_1509770_516260#_port_3,diff_1509770_516260#_port_0, diff_1509770_516260#_v);
  spice_node_3 n_diff_296310_846600#(eclk, ereset, diff_296310_846600#_port_2,diff_296310_846600#_port_0,diff_296310_846600#_port_1, diff_296310_846600#_v);
  spice_node_1 n_diff_1111370_685580#(eclk, ereset, diff_1111370_685580#_port_1, diff_1111370_685580#_v);
  spice_node_6 n_diff_1231720_712970#(eclk, ereset, diff_1231720_712970#_port_2,diff_1231720_712970#_port_3,diff_1231720_712970#_port_0,diff_1231720_712970#_port_1,diff_1231720_712970#_port_4,diff_1231720_712970#_port_5, diff_1231720_712970#_v);
  spice_node_1 n_diff_1254960_682260#(eclk, ereset, diff_1254960_682260#_port_0, diff_1254960_682260#_v);
  spice_node_3 n_diff_1472420_424130#(eclk, ereset, diff_1472420_424130#_port_2,diff_1472420_424130#_port_3,diff_1472420_424130#_port_0, diff_1472420_424130#_v);
  spice_node_1 n_diff_754470_429110#(eclk, ereset, diff_754470_429110#_port_1, diff_754470_429110#_v);
  spice_node_5 n_diff_336150_519580#(eclk, ereset, diff_336150_519580#_port_2,diff_336150_519580#_port_3,diff_336150_519580#_port_0,diff_336150_519580#_port_1,diff_336150_519580#_port_5, diff_336150_519580#_v);
  spice_node_2 n_diff_994340_234060#(eclk, ereset, diff_994340_234060#_port_0,diff_994340_234060#_port_1, diff_994340_234060#_v);
  spice_node_3 n_diff_314570_311250#(eclk, ereset, diff_314570_311250#_port_2,diff_314570_311250#_port_3,diff_314570_311250#_port_4, diff_314570_311250#_v);
  spice_node_5 n_diff_816720_520410#(eclk, ereset, diff_816720_520410#_port_2,diff_816720_520410#_port_3,diff_816720_520410#_port_0,diff_816720_520410#_port_1,diff_816720_520410#_port_5, diff_816720_520410#_v);
  spice_node_2 n_diff_544480_499660#(eclk, ereset, diff_544480_499660#_port_0,diff_544480_499660#_port_1, diff_544480_499660#_v);
  spice_node_1 n_diff_871500_685580#(eclk, ereset, diff_871500_685580#_port_1, diff_871500_685580#_v);
  spice_node_2 n_diff_1552100_502150#(eclk, ereset, diff_1552100_502150#_port_0,diff_1552100_502150#_port_1, diff_1552100_502150#_v);
  spice_node_1 n_diff_1273220_771900#(eclk, ereset, diff_1273220_771900#_port_1, diff_1273220_771900#_v);
  spice_node_5 n_diff_1231720_738700#(eclk, ereset, diff_1231720_738700#_port_2,diff_1231720_738700#_port_3,diff_1231720_738700#_port_0,diff_1231720_738700#_port_4,diff_1231720_738700#_port_5, diff_1231720_738700#_v);
  spice_node_1 n_diff_1376970_433260#(eclk, ereset, diff_1376970_433260#_port_1, diff_1376970_433260#_v);
  spice_node_2 n_diff_322040_502150#(eclk, ereset, diff_322040_502150#_port_0,diff_322040_502150#_port_1, diff_322040_502150#_v);
  spice_node_2 n_diff_517090_234060#(eclk, ereset, diff_517090_234060#_port_0,diff_517090_234060#_port_1, diff_517090_234060#_v);
  spice_node_1 n_diff_896400_434090#(eclk, ereset, diff_896400_434090#_port_1, diff_896400_434090#_v);
  spice_node_2 n_diff_1621820_879800#(eclk, ereset, diff_1621820_879800#_port_2,diff_1621820_879800#_port_1, diff_1621820_879800#_v);
  spice_node_1 n_diff_924620_321210#(eclk, ereset, diff_924620_321210#_port_0, diff_924620_321210#_v);
  spice_node_1 n_diff_512940_454840#(eclk, ereset, diff_512940_454840#_port_1, diff_512940_454840#_v);
  spice_node_2 n_diff_563570_456500#(eclk, ereset, diff_563570_456500#_port_0,diff_563570_456500#_port_1, diff_563570_456500#_v);
  spice_node_1 n_diff_551950_771900#(eclk, ereset, diff_551950_771900#_port_1, diff_551950_771900#_v);
  spice_node_1 n_diff_512940_429940#(eclk, ereset, diff_512940_429940#_port_1, diff_512940_429940#_v);
  spice_node_1 n_diff_1352070_685580#(eclk, ereset, diff_1352070_685580#_port_1, diff_1352070_685580#_v);
  spice_node_2 n_diff_258130_451520#(eclk, ereset, diff_258130_451520#_port_0,diff_258130_451520#_port_1, diff_258130_451520#_v);
  spice_node_2 n_diff_1534670_282200#(eclk, ereset, diff_1534670_282200#_port_2,diff_1534670_282200#_port_0, diff_1534670_282200#_v);
  spice_node_2 n_diff_1505620_931260#(eclk, ereset, diff_1505620_931260#_port_2,diff_1505620_931260#_port_3, diff_1505620_931260#_v);
  spice_node_2 n_diff_1284840_456500#(eclk, ereset, diff_1284840_456500#_port_0,diff_1284840_456500#_port_1, diff_1284840_456500#_v);
  spice_node_2 n_diff_1365350_939560#(eclk, ereset, diff_1365350_939560#_port_2,diff_1365350_939560#_port_1, diff_1365350_939560#_v);
  spice_node_1 n_diff_993510_429110#(eclk, ereset, diff_993510_429110#_port_1, diff_993510_429110#_v);
  spice_node_1 n_diff_993510_454010#(eclk, ereset, diff_993510_454010#_port_1, diff_993510_454010#_v);
  spice_node_3 n_diff_232400_451520#(eclk, ereset, diff_232400_451520#_port_8,diff_232400_451520#_port_9,diff_232400_451520#_port_1, diff_232400_451520#_v);
  spice_node_2 n_diff_1566210_789330#(eclk, ereset, diff_1566210_789330#_port_2,diff_1566210_789330#_port_1, diff_1566210_789330#_v);
  spice_node_1 n_diff_1405190_321210#(eclk, ereset, diff_1405190_321210#_port_0, diff_1405190_321210#_v);
  spice_node_6 n_diff_336150_427450#(eclk, ereset, diff_336150_427450#_port_2,diff_336150_427450#_port_3,diff_336150_427450#_port_0,diff_336150_427450#_port_1,diff_336150_427450#_port_4,diff_336150_427450#_port_5, diff_336150_427450#_v);
  spice_node_3 n_diff_1016750_846600#(eclk, ereset, diff_1016750_846600#_port_2,diff_1016750_846600#_port_0,diff_1016750_846600#_port_1, diff_1016750_846600#_v);
  spice_node_1 n_diff_292990_681430#(eclk, ereset, diff_292990_681430#_port_0, diff_292990_681430#_v);
  spice_node_1 n_diff_1235040_454010#(eclk, ereset, diff_1235040_454010#_port_1, diff_1235040_454010#_v);
  spice_node_3 n_diff_795140_312080#(eclk, ereset, diff_795140_312080#_port_2,diff_795140_312080#_port_3,diff_795140_312080#_port_4, diff_795140_312080#_v);
  spice_node_2 n_q1(eclk, ereset, q1_port_0,q1_port_1, q1_v);
  spice_node_2 n_q0(eclk, ereset, q0_port_0,q0_port_1, q0_v);
  spice_node_2 n_q3(eclk, ereset, q3_port_0,q3_port_1, q3_v);
  spice_node_2 n_q2(eclk, ereset, q2_port_0,q2_port_1, q2_v);
  spice_node_2 n_q5(eclk, ereset, q5_port_0,q5_port_1, q5_v);
  spice_node_2 n_q4(eclk, ereset, q4_port_0,q4_port_1, q4_v);
  spice_node_2 n_q7(eclk, ereset, q7_port_0,q7_port_1, q7_v);
  spice_node_2 n_q6(eclk, ereset, q6_port_0,q6_port_1, q6_v);
  spice_node_2 n_q9(eclk, ereset, q9_port_0,q9_port_1, q9_v);
  spice_node_2 n_q8(eclk, ereset, q8_port_0,q8_port_1, q8_v);
  spice_node_1 n_diff_871500_704670#(eclk, ereset, diff_871500_704670#_port_0, diff_871500_704670#_v);
  spice_node_2 n_diff_1588620_812570#(eclk, ereset, diff_1588620_812570#_port_2,diff_1588620_812570#_port_1, diff_1588620_812570#_v);
  spice_node_5 n_diff_1297290_428280#(eclk, ereset, diff_1297290_428280#_port_2,diff_1297290_428280#_port_3,diff_1297290_428280#_port_0,diff_1297290_428280#_port_1,diff_1297290_428280#_port_5, diff_1297290_428280#_v);
  spice_node_2 n_diff_634950_712140#(eclk, ereset, diff_634950_712140#_port_0,diff_634950_712140#_port_1, diff_634950_712140#_v);
  spice_node_6 n_diff_278050_567720#(eclk, ereset, diff_278050_567720#_port_2,diff_278050_567720#_port_3,diff_278050_567720#_port_0,diff_278050_567720#_port_1,diff_278050_567720#_port_4,diff_278050_567720#_port_5, diff_278050_567720#_v);
  spice_node_3 n_diff_1466610_655700#(eclk, ereset, diff_1466610_655700#_port_2,diff_1466610_655700#_port_0,diff_1466610_655700#_port_1, diff_1466610_655700#_v);
  spice_node_2 n_diff_1540480_996000#(eclk, ereset, diff_1540480_996000#_port_0,diff_1540480_996000#_port_1, diff_1540480_996000#_v);
  spice_node_1 n_diff_312080_771900#(eclk, ereset, diff_312080_771900#_port_1, diff_312080_771900#_v);
  spice_node_2 n_diff_1477400_740360#(eclk, ereset, diff_1477400_740360#_port_2,diff_1477400_740360#_port_0, diff_1477400_740360#_v);
  spice_node_5 n_diff_576020_519580#(eclk, ereset, diff_576020_519580#_port_2,diff_576020_519580#_port_3,diff_576020_519580#_port_0,diff_576020_519580#_port_1,diff_576020_519580#_port_5, diff_576020_519580#_v);
  spice_node_2 n_diff_804270_456500#(eclk, ereset, diff_804270_456500#_port_0,diff_804270_456500#_port_1, diff_804270_456500#_v);
  spice_node_6 n_diff_1056590_427450#(eclk, ereset, diff_1056590_427450#_port_2,diff_1056590_427450#_port_3,diff_1056590_427450#_port_0,diff_1056590_427450#_port_1,diff_1056590_427450#_port_4,diff_1056590_427450#_port_5, diff_1056590_427450#_v);
  spice_node_2 n_cp(eclk, ereset, cp_port_2,cp_port_0, cp_v);
  spice_node_3 n_diff_273900_560250#(eclk, ereset, diff_273900_560250#_port_8,diff_273900_560250#_port_9,diff_273900_560250#_port_1, diff_273900_560250#_v);
  spice_node_4 n_diff_1297290_520410#(eclk, ereset, diff_1297290_520410#_port_2,diff_1297290_520410#_port_3,diff_1297290_520410#_port_0,diff_1297290_520410#_port_1, diff_1297290_520410#_v);
  spice_node_3 n_diff_776880_846600#(eclk, ereset, diff_776880_846600#_port_2,diff_776880_846600#_port_0,diff_776880_846600#_port_1, diff_776880_846600#_v);
  spice_node_5 n_diff_751150_738700#(eclk, ereset, diff_751150_738700#_port_2,diff_751150_738700#_port_3,diff_751150_738700#_port_0,diff_751150_738700#_port_4,diff_751150_738700#_port_5, diff_751150_738700#_v);
  spice_node_2 n_diff_786010_499660#(eclk, ereset, diff_786010_499660#_port_0,diff_786010_499660#_port_1, diff_786010_499660#_v);
  spice_node_1 n_diff_1235040_429110#(eclk, ereset, diff_1235040_429110#_port_1, diff_1235040_429110#_v);
  spice_node_6 n_diff_991020_712970#(eclk, ereset, diff_991020_712970#_port_2,diff_991020_712970#_port_3,diff_991020_712970#_port_0,diff_991020_712970#_port_1,diff_991020_712970#_port_4,diff_991020_712970#_port_5, diff_991020_712970#_v);
  spice_node_1 n_diff_415830_432430#(eclk, ereset, diff_415830_432430#_port_1, diff_415830_432430#_v);
  spice_node_1 n_diff_630800_705500#(eclk, ereset, diff_630800_705500#_port_0, diff_630800_705500#_v);
  spice_node_2 n_diff_395080_673960#(eclk, ereset, diff_395080_673960#_port_0,diff_395080_673960#_port_1, diff_395080_673960#_v);
  spice_node_1 n_diff_278050_543650#(eclk, ereset, diff_278050_543650#_port_0, diff_278050_543650#_v);
  spice_node_2 n_diff_644910_939560#(eclk, ereset, diff_644910_939560#_port_2,diff_644910_939560#_port_1, diff_644910_939560#_v);
  spice_node_1 n_diff_1111370_704670#(eclk, ereset, diff_1111370_704670#_port_0, diff_1111370_704670#_v);
  spice_node_1 n_diff_289670_464800#(eclk, ereset, diff_289670_464800#_port_0, diff_289670_464800#_v);
  spice_node_1 n_diff_532860_681430#(eclk, ereset, diff_532860_681430#_port_0, diff_532860_681430#_v);
  spice_node_3 n_diff_536180_846600#(eclk, ereset, diff_536180_846600#_port_2,diff_536180_846600#_port_0,diff_536180_846600#_port_1, diff_536180_846600#_v);
  spice_node_2 n_diff_1483210_498830#(eclk, ereset, diff_1483210_498830#_port_2,diff_1483210_498830#_port_1, diff_1483210_498830#_v);
  spice_node_2 n_diff_1355390_674790#(eclk, ereset, diff_1355390_674790#_port_0,diff_1355390_674790#_port_1, diff_1355390_674790#_v);
  spice_node_3 n_diff_1505620_352750#(eclk, ereset, diff_1505620_352750#_port_2,diff_1505620_352750#_port_3,diff_1505620_352750#_port_1, diff_1505620_352750#_v);
  spice_node_1 n_diff_1548780_494680#(eclk, ereset, diff_1548780_494680#_port_1, diff_1548780_494680#_v);
  spice_node_2 n_diff_305440_456500#(eclk, ereset, diff_305440_456500#_port_0,diff_305440_456500#_port_1, diff_305440_456500#_v);
  spice_node_1 n_diff_656530_432430#(eclk, ereset, diff_656530_432430#_port_1, diff_656530_432430#_v);
  spice_node_2 n_diff_207500_451520#(eclk, ereset, diff_207500_451520#_port_9,diff_207500_451520#_port_10, diff_207500_451520#_v);
  spice_node_2 n_diff_1355390_712140#(eclk, ereset, diff_1355390_712140#_port_0,diff_1355390_712140#_port_1, diff_1355390_712140#_v);
  spice_node_5 n_diff_991020_738700#(eclk, ereset, diff_991020_738700#_port_2,diff_991020_738700#_port_3,diff_991020_738700#_port_0,diff_991020_738700#_port_4,diff_991020_738700#_port_5, diff_991020_738700#_v);
  spice_node_2 n_diff_1115520_712140#(eclk, ereset, diff_1115520_712140#_port_0,diff_1115520_712140#_port_1, diff_1115520_712140#_v);
  spice_node_1 n_diff_754470_454010#(eclk, ereset, diff_754470_454010#_port_1, diff_754470_454010#_v);
  spice_node_2 n_diff_404210_938730#(eclk, ereset, diff_404210_938730#_port_2,diff_404210_938730#_port_1, diff_404210_938730#_v);
  spice_node_2 n_diff_1125480_939560#(eclk, ereset, diff_1125480_939560#_port_2,diff_1125480_939560#_port_1, diff_1125480_939560#_v);
  spice_node_3 n_diff_1033350_312080#(eclk, ereset, diff_1033350_312080#_port_2,diff_1033350_312080#_port_3,diff_1033350_312080#_port_4, diff_1033350_312080#_v);
  spice_node_1 n_diff_792650_771900#(eclk, ereset, diff_792650_771900#_port_1, diff_792650_771900#_v);
  spice_node_5 n_diff_273900_607560#(eclk, ereset, diff_273900_607560#_port_2,diff_273900_607560#_port_3,diff_273900_607560#_port_1,diff_273900_607560#_port_4,diff_273900_607560#_port_5, diff_273900_607560#_v);
  spice_node_2 n_diff_1115520_674790#(eclk, ereset, diff_1115520_674790#_port_0,diff_1115520_674790#_port_1, diff_1115520_674790#_v);
  spice_node_2 n_diff_1043310_456500#(eclk, ereset, diff_1043310_456500#_port_0,diff_1043310_456500#_port_1, diff_1043310_456500#_v);
  spice_node_2 n_diff_1266580_499660#(eclk, ereset, diff_1266580_499660#_port_0,diff_1266580_499660#_port_1, diff_1266580_499660#_v);
  spice_node_3 n_diff_1257450_846600#(eclk, ereset, diff_1257450_846600#_port_2,diff_1257450_846600#_port_0,diff_1257450_846600#_port_1, diff_1257450_846600#_v);
  spice_node_2 n_diff_875650_712140#(eclk, ereset, diff_875650_712140#_port_0,diff_875650_712140#_port_1, diff_875650_712140#_v);
  spice_node_2 n_diff_1025050_499660#(eclk, ereset, diff_1025050_499660#_port_0,diff_1025050_499660#_port_1, diff_1025050_499660#_v);
  spice_node_1 n_diff_444050_322040#(eclk, ereset, diff_444050_322040#_port_0, diff_444050_322040#_v);
  spice_node_2 n_diff_875650_674790#(eclk, ereset, diff_875650_674790#_port_0,diff_875650_674790#_port_1, diff_875650_674790#_v);
  spice_node_3 n_diff_556100_312080#(eclk, ereset, diff_556100_312080#_port_2,diff_556100_312080#_port_3,diff_556100_312080#_port_4, diff_556100_312080#_v);
  spice_node_3 n_diff_1472420_449860#(eclk, ereset, diff_1472420_449860#_port_2,diff_1472420_449860#_port_0,diff_1472420_449860#_port_1, diff_1472420_449860#_v);
  spice_node_1 n_diff_1165320_321210#(eclk, ereset, diff_1165320_321210#_port_0, diff_1165320_321210#_v);
  spice_node_2 n_e(eclk, ereset, e_port_2,e_port_1, e_v);
  spice_node_1 n_diff_390930_703840#(eclk, ereset, diff_390930_703840#_port_0, diff_390930_703840#_v);
  spice_node_2 n_diff_756130_234890#(eclk, ereset, diff_756130_234890#_port_0,diff_756130_234890#_port_1, diff_756130_234890#_v);
  spice_node_5 n_diff_1056590_520410#(eclk, ereset, diff_1056590_520410#_port_2,diff_1056590_520410#_port_3,diff_1056590_520410#_port_0,diff_1056590_520410#_port_1,diff_1056590_520410#_port_5, diff_1056590_520410#_v);
  spice_node_1 n_diff_1032520_771900#(eclk, ereset, diff_1032520_771900#_port_1, diff_1032520_771900#_v);
  spice_node_2 n_diff_884780_939560#(eclk, ereset, diff_884780_939560#_port_2,diff_884780_939560#_port_1, diff_884780_939560#_v);

endmodule

module spice_node_0(input eclk,ereset, output signed [`W-1:0] v);
  assign v = 0;
endmodule

module spice_node_1(input eclk,ereset, input signed [`W-1:0] i0, output reg signed [`W-1:0] v);
  wire signed [`W-1:0] i = i0;

  always @(posedge eclk)
    if (ereset)
      v <= 0;
    else
      v <= v + i;

endmodule

module spice_node_2(input eclk,ereset, input signed [`W-1:0] i0,i1, output reg signed [`W-1:0] v);
  wire signed [`W-1:0] i = i0+i1;

  always @(posedge eclk)
    if (ereset)
      v <= 0;
    else
      v <= v + i;

endmodule

module spice_node_3(input eclk,ereset, input signed [`W-1:0] i0,i1,i2, output reg signed [`W-1:0] v);
  wire signed [`W-1:0] i = i0+i1+i2;

  always @(posedge eclk)
    if (ereset)
      v <= 0;
    else
      v <= v + i;

endmodule

module spice_node_4(input eclk,ereset, input signed [`W-1:0] i0,i1,i2,i3, output reg signed [`W-1:0] v);
  wire signed [`W-1:0] i = i0+i1+i2+i3;

  always @(posedge eclk)
    if (ereset)
      v <= 0;
    else
      v <= v + i;

endmodule

module spice_node_5(input eclk,ereset, input signed [`W-1:0] i0,i1,i2,i3,i4, output reg signed [`W-1:0] v);
  wire signed [`W-1:0] i = i0+i1+i2+i3+i4;

  always @(posedge eclk)
    if (ereset)
      v <= 0;
    else
      v <= v + i;

endmodule

module spice_node_6(input eclk,ereset, input signed [`W-1:0] i0,i1,i2,i3,i4,i5, output reg signed [`W-1:0] v);
  wire signed [`W-1:0] i = i0+i1+i2+i3+i4+i5;

  always @(posedge eclk)
    if (ereset)
      v <= 0;
    else
      v <= v + i;

endmodule

