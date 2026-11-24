`default_nettype none

module tt_um_hex_7seg (
    input  wire [7:0] ui_in,    // Entradas dedicadas
    output wire [7:0] uo_out,   // Salidas dedicadas
    input  wire [7:0] uio_in,   // IOs: Ruta de entrada
    output wire [7:0] uio_out,  // IOs: Ruta de salida
    output wire [7:0] uio_oe,   // IOs: Habilitación (0 = entrada, 1 = salida)
    input  wire       ena,      // Siempre 1 cuando el diseño está encendido
    input  wire       clk,      // Reloj
    input  wire       rst_n     // Reset activo en bajo
);

  // Mapeo de entradas según tu esquemático de Wokwi
  wire z = ui_in[0]; // bit 0 (LSB)
  wire y = ui_in[1]; // bit 1
  wire x = ui_in[2]; // bit 2
  wire w = ui_in[3]; // bit 3 (MSB)

  // Ecuaciones booleanas exactas extraídas de tu red de compuertas
  wire a = (w & ~z) | (~x & ~z) | (w & ~x & ~y) | (~w & x & z) | (~w & ~x & y) | (x & y & z);
  wire b = (~w & ~x) | (~x & ~z) | (w & ~y & z) | (~w & y & z) | (~w & ~y & ~z);
  wire c = (w & ~x) | (~w & x) | (~w & ~y) | (~w & z) | (~y & z);
  wire d = (w & ~y & ~z) | (~w & ~x & ~z) | (x & y & ~z) | (x & ~y & z) | (~x & y & z);
  wire e = (w & x) | (w & y) | (~x & ~z) | (y & ~z);
  wire f = (w & ~x) | (w & y) | (x & ~z) | (~y & ~z) | (~w & x & ~y);
  wire g = (w & ~x) | (w & z) | (~x & y) | (y & ~z) | (~w & x & ~y);

  // Salidas hacia los segmentos a..g (uo_out[0..6])
  assign uo_out[0] = a;
  assign uo_out[1] = b;
  assign uo_out[2] = c;
  assign uo_out[3] = d;
  assign uo_out[4] = e;
  assign uo_out[5] = f;
  assign uo_out[6] = g;
  assign uo_out[7] = 1'b0; // Punto decimal (DP) sin lógica asociada

  // Pines bidireccionales sin usar
  assign uio_out = 8'b0;
  assign uio_oe  = 8'b0;

  // Silenciar advertencias por puertos no utilizados
  wire _unused = &{ena, clk, rst_n, ui_in[7:4], uio_in, 1'b0};

endmodule
