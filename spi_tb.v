module SPI_tb ();
    reg MOSI,SCK,SS_n,rst_n;

    wire MISO;

    spi_wrapper spi_wrapper (MOSI,MISO,SCK,SS_n,rst_n);
    initial begin
        SCK=0;
        forever begin
            #10;
            SCK=~SCK;
        end
    end
    initial begin
        rst_n=0;
        repeat(2)
        @(negedge SCK);
        rst_n=1;
        SS_n=1;
        repeat(2)
        @(negedge SCK);
        SS_n=0;
        MOSI=0;
        repeat(2)
        @(negedge SCK);
        MOSI=0;
        @(negedge SCK);
        MOSI=0;
        @(negedge SCK);
        MOSI=1;
        @(negedge SCK);
        MOSI=1;
        @(negedge SCK);
        MOSI=1;
        @(negedge SCK);
        MOSI=1;
        @(negedge SCK);
        MOSI=1;
        @(negedge SCK);
        MOSI=1;
        @(negedge SCK);
        MOSI=1;
        @(negedge SCK);
        MOSI=1;
        @(negedge SCK);
        SS_n=1;
    repeat(2)
        @(negedge SCK);
        SS_n=0;
        MOSI=0;
        repeat(2)
        @(negedge SCK);
        MOSI=0;
        @(negedge SCK);
        MOSI=1;
        @(negedge SCK);
        MOSI=0;
        @(negedge SCK);
        MOSI=1;
        @(negedge SCK);
        MOSI=0;
        @(negedge SCK);
        MOSI=1;
        @(negedge SCK);
        MOSI=0;
        @(negedge SCK);
        MOSI=1;
        @(negedge SCK);
        MOSI=0;
        @(negedge SCK);
        MOSI=1;
        @(negedge SCK);
        SS_n=1;
    repeat(2)
        @(negedge SCK);
        SS_n=0;
        MOSI=1;
        repeat(2)
        @(negedge SCK);
        MOSI=1;
        @(negedge SCK);
        MOSI=0;
        @(negedge SCK);
        MOSI=1;
        @(negedge SCK);
        MOSI=1;
        @(negedge SCK);
        MOSI=1;
        @(negedge SCK);
        MOSI=1;
        @(negedge SCK);
        MOSI=1;
        @(negedge SCK);
        MOSI=1;
        @(negedge SCK);
        MOSI=1;
        @(negedge SCK);
        MOSI=1;
        @(negedge SCK);
        SS_n=1;
    repeat(2)
        @(negedge SCK);
        SS_n=0;
        MOSI=1;
        repeat(2)
        @(negedge SCK);
        MOSI=1;
        @(negedge SCK);
        MOSI=1;
        @(negedge SCK);
        MOSI=0;
        @(negedge SCK);
        MOSI=0;
        @(negedge SCK);
        MOSI=1;
        @(negedge SCK);
        MOSI=1;
        @(negedge SCK);
        MOSI=1;
        @(negedge SCK);
        MOSI=0;
        @(negedge SCK);
        MOSI=1;
        @(negedge SCK);
        MOSI=1;
        repeat(9)
        @(negedge SCK);
        SS_n=1;
         repeat(3)
        @(negedge SCK);
    $stop;
    end
endmodule