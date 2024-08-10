module spi_wrapper (MOSI,MISO,clk,SS_n,rst_n);

    input MOSI,clk,SS_n,rst_n;

    output MISO;
    
    (*fsm_encoding = "gray"*)

    wire [7:0]tx_data;
    wire tx_valid,rx_valid;

    wire [9:0]rx_data;

    spi_slave spi_slave (MOSI,MISO,clk,SS_n,rst_n,rx_data,rx_valid,tx_data,tx_valid);

    ram ram (rx_data,rx_valid,tx_data,tx_valid,clk,rst_n);
endmodule