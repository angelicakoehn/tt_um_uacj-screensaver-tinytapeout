`default_nettype none

module bitmap_rom (
    input  wire [6:0] x,   // 0..127
    input  wire [6:0] y,   // 0..127
    output wire       pixel
);

    // ============================================================
    //  LETRAS U A C J (fila superior)
    // ============================================================

    // U
    wire letra_U =
        ((x >= 8  && x <= 12) && (y >= 10 && y <= 45)) ||
        ((x >= 27 && x <= 31) && (y >= 10 && y <= 45)) ||
        ((y >= 40 && y <= 45) && (x >= 8 && x <= 31));

    // A (corregida: espacio central abierto)
    wire letra_A =
        // columnas laterales
        ((x >= 40 && x <= 44) && (y >= 10 && y <= 45)) ||
        ((x >= 59 && x <= 63) && (y >= 10 && y <= 45)) ||
        // barra horizontal
        ((y >= 25 && y <= 29) && (x >= 40 && x <= 63)) ||
        // punta superior
        ((y >= 10 && y <= 14) && (x >= 48 && x <= 55));

    // C
    wire letra_C =
        ((y >= 10 && y <= 14) && (x >= 72 && x <= 95)) ||
        ((y >= 41 && y <= 45) && (x >= 72 && x <= 95)) ||
        ((x >= 72 && x <= 76) && (y >= 10 && y <= 45));

    // J
    wire letra_J =
        ((y >= 10 && y <= 14) && (x >= 104 && x <= 127)) ||
        ((x >= 119 && x <= 123) && (y >= 10 && y <= 40)) ||
        ((y >= 36 && y <= 40) && (x >= 108 && x <= 123)) ||
        ((x >= 104 && x <= 108) && (y >= 36 && y <= 45));

    wire letras_superior = letra_U || letra_A || letra_C || letra_J;

    // ============================================================
    //  TEXTO A.M.G (fila inferior)
    // ============================================================

    wire in_text = (y >= 85 && y <= 105);
    wire [6:0] xt = x;

    wire txt_A =
        (((xt >= 20 && xt <= 23) || (xt >= 32 && xt <= 35)) && in_text) ||
        ((y >= 92 && y <= 95) && (xt >= 20 && xt <= 35)) ||
        ((y >= 85 && y <= 89) && (xt >= 26 && xt <= 29)); // punta superior

    wire txt_dot1 = (xt >= 38 && xt <= 40) && (y >= 98 && y <= 101);

    wire txt_M =
        (((xt >= 45 && xt <= 48) || (xt >= 62 && xt <= 65)) && in_text) ||
        ((xt - 45 == y - 85) && (xt >= 45 && xt <= 53) && in_text) ||
        ((65 - xt == y - 85) && (xt >= 57 && xt <= 65) && in_text);

    wire txt_dot2 = (xt >= 68 && xt <= 70) && (y >= 98 && y <= 101);

    wire txt_G =
        ((y >= 85 && y <= 88) && (xt >= 75 && xt <= 100)) ||
        ((y >= 101 && y <= 105) && (xt >= 75 && xt <= 100)) ||
        ((xt >= 75 && xt <= 79) && (y >= 85 && y <= 105)) ||
        ((xt >= 90 && xt <= 100) && (y >= 95 && y <= 99));

    wire texto_inferior = txt_A || txt_dot1 || txt_M || txt_dot2 || txt_G;

    // ============================================================
    //  PIXEL FINAL
    // ============================================================

    assign pixel = letras_superior || texto_inferior;

endmodule
