/*
    Verilog database LUT for playing a RTTL ringtone on a Piezo Speaker

    Copyright 2022 Milosch Meriac <milosch@meriac.com>
    Copyright 2022 Jiaxun Yang <jiaxun.yang@flygoat.com>

    Redistribution and use in source and binary forms, with or without
    modification, are permitted provided that the following conditions
    are met:

    1. Redistributions of source code must retain the above copyright
       notice, this list of conditions and the following disclaimer.

    2. Redistributions in binary form must reproduce the above copyright
       notice, this list of conditions and the following disclaimer in the
       documentation and/or other materials provided with the distribution.

    3. Neither the name of the copyright holder nor the names of its
       contributors may be used to endorse or promote products derived
       from this software without specific prior written permission.

    THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
    "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
    LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
    A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
    HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
    SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
    LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
    DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
    THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
    (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
    OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

*/

module flygoat_tune_db (
    input wire [6:0] address,
    output reg [10:0] db_entry
);
    always @(*) begin
        case(address)
            // Song: FlyGoat
            // One timer-tick equals 50ms
            // Per-note clock dividers assume 10000Hz clock
            // Bottom-nibble is tick-count per note, upper nibbles are the per-note clock dividers
            0: db_entry = 11'h223; // d8  (293.66Hz, 150ms,  3 ticks)
            1: db_entry = 11'h003; // p8  (pause   , 150ms,  3 ticks)
            2: db_entry = 11'h223; // d8  (293.66Hz, 150ms,  3 ticks)
            3: db_entry = 11'h003; // p8  (pause   , 150ms,  3 ticks)
            4: db_entry = 11'h221; // d8  (293.66Hz,  50ms,  1 ticks)
            5: db_entry = 11'h003; // p8  (pause   , 150ms,  3 ticks)
            6: db_entry = 11'h223; // d8  (293.66Hz, 150ms,  3 ticks)
            7: db_entry = 11'h003; // p8  (pause   , 150ms,  3 ticks)
            8: db_entry = 11'h002; // p8  (pause   , 100ms,  2 ticks)
            9: db_entry = 11'h223; // d8  (293.66Hz, 150ms,  3 ticks)
            10: db_entry = 11'h003; // p8  (pause   , 150ms,  3 ticks)
            11: db_entry = 11'h221; // d8  (293.66Hz,  50ms,  1 ticks)
            12: db_entry = 11'h003; // p8  (pause   , 150ms,  3 ticks)
            13: db_entry = 11'h223; // d8  (293.66Hz, 150ms,  3 ticks)
            14: db_entry = 11'h003; // p8  (pause   , 150ms,  3 ticks)
            15: db_entry = 11'h223; // d8  (293.66Hz, 150ms,  3 ticks)
            16: db_entry = 11'h003; // p8  (pause   , 150ms,  3 ticks)
            17: db_entry = 11'h002; // p8  (pause   , 100ms,  2 ticks)
            18: db_entry = 11'h221; // d8  (293.66Hz,  50ms,  1 ticks)
            19: db_entry = 11'h003; // p8  (pause   , 150ms,  3 ticks)
            20: db_entry = 11'h223; // d8  (293.66Hz, 150ms,  3 ticks)
            21: db_entry = 11'h003; // p8  (pause   , 150ms,  3 ticks)
            22: db_entry = 11'h221; // d8  (293.66Hz,  50ms,  1 ticks)
            23: db_entry = 11'h003; // p8  (pause   , 150ms,  3 ticks)
            24: db_entry = 11'h221; // d8  (293.66Hz,  50ms,  1 ticks)
            25: db_entry = 11'h003; // p8  (pause   , 150ms,  3 ticks)
            26: db_entry = 11'h002; // p8  (pause   , 100ms,  2 ticks)
            27: db_entry = 11'h221; // d8  (293.66Hz,  50ms,  1 ticks)
            28: db_entry = 11'h003; // p8  (pause   , 150ms,  3 ticks)
            29: db_entry = 11'h221; // d8  (293.66Hz,  50ms,  1 ticks)
            30: db_entry = 11'h003; // p8  (pause   , 150ms,  3 ticks)
            31: db_entry = 11'h223; // d8  (293.66Hz, 150ms,  3 ticks)
            32: db_entry = 11'h003; // p8  (pause   , 150ms,  3 ticks)
            33: db_entry = 11'h002; // p8  (pause   , 100ms,  2 ticks)
            34: db_entry = 11'h221; // d8  (293.66Hz,  50ms,  1 ticks)
            35: db_entry = 11'h003; // p8  (pause   , 150ms,  3 ticks)
            36: db_entry = 11'h221; // d8  (293.66Hz,  50ms,  1 ticks)
            37: db_entry = 11'h003; // p8  (pause   , 150ms,  3 ticks)
            38: db_entry = 11'h221; // d8  (293.66Hz,  50ms,  1 ticks)
            39: db_entry = 11'h003; // p8  (pause   , 150ms,  3 ticks)
            40: db_entry = 11'h002; // p8  (pause   , 100ms,  2 ticks)
            41: db_entry = 11'h223; // d8  (293.66Hz, 150ms,  3 ticks)
            42: db_entry = 11'h003; // p8  (pause   , 150ms,  3 ticks)
            43: db_entry = 11'h221; // d8  (293.66Hz,  50ms,  1 ticks)
            44: db_entry = 11'h003; // p8  (pause   , 150ms,  3 ticks)
            45: db_entry = 11'h002; // p8  (pause   , 100ms,  2 ticks)
            46: db_entry = 11'h221; // d8  (293.66Hz,  50ms,  1 ticks)
            47: db_entry = 11'h003; // p8  (pause   , 150ms,  3 ticks)
            48: db_entry = 11'h002; // p8  (pause   , 100ms,  2 ticks)
            49: db_entry = 11'h002; // p8  (pause   , 100ms,  2 ticks)
            50: db_entry = 11'h002; // p8  (pause   , 100ms,  2 ticks)
            51: db_entry = 11'h002; // p8  (pause   , 100ms,  2 ticks)
            52: db_entry = 11'h002; // p8  (pause   , 100ms,  2 ticks)
            53: db_entry = 11'h002; // p8  (pause   , 100ms,  2 ticks)
            54: db_entry = 11'h001; // unused
            55: db_entry = 11'h001; // unused
            56: db_entry = 11'h001; // unused
            57: db_entry = 11'h001; // unused
            58: db_entry = 11'h001; // unused
            59: db_entry = 11'h001; // unused
            60: db_entry = 11'h001; // unused
            61: db_entry = 11'h001; // unused
            62: db_entry = 11'h001; // unused
            63: db_entry = 11'h001; // unused
            64: db_entry = 11'h001; // unused
            65: db_entry = 11'h001; // unused
            66: db_entry = 11'h001; // unused
            67: db_entry = 11'h001; // unused
            68: db_entry = 11'h001; // unused
            69: db_entry = 11'h001; // unused
            70: db_entry = 11'h001; // unused
            71: db_entry = 11'h001; // unused
            72: db_entry = 11'h001; // unused
            73: db_entry = 11'h001; // unused
            74: db_entry = 11'h001; // unused
            75: db_entry = 11'h001; // unused
            76: db_entry = 11'h001; // unused
            77: db_entry = 11'h001; // unused
            78: db_entry = 11'h001; // unused
            79: db_entry = 11'h001; // unused
            80: db_entry = 11'h001; // unused
            81: db_entry = 11'h001; // unused
            82: db_entry = 11'h001; // unused
            83: db_entry = 11'h001; // unused
            84: db_entry = 11'h001; // unused
            85: db_entry = 11'h001; // unused
            86: db_entry = 11'h001; // unused
            87: db_entry = 11'h001; // unused
            88: db_entry = 11'h001; // unused
            89: db_entry = 11'h001; // unused
            90: db_entry = 11'h001; // unused
            91: db_entry = 11'h001; // unused
            92: db_entry = 11'h001; // unused
            93: db_entry = 11'h001; // unused
            94: db_entry = 11'h001; // unused
            95: db_entry = 11'h001; // unused
            96: db_entry = 11'h001; // unused
            97: db_entry = 11'h001; // unused
            98: db_entry = 11'h001; // unused
            99: db_entry = 11'h001; // unused
            default:    
                db_entry = 11'h000;
        endcase

    end

endmodule
