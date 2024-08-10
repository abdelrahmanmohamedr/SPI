module spi_slave (MOSI,MISO,SCK,SS_n,rst_n,rx_data,rx_valid,tx_data,tx_valid);

parameter [2:0]IDLE =3'b000;
parameter [2:0]CHK_CMD =3'b001;
parameter [2:0]WRITE =3'b010;
parameter [2:0]READ_DATA =3'b011;
parameter [2:0]READ_ADD =3'b100;

    input [7:0]tx_data;
    input MOSI,SCK,SS_n,rst_n,tx_valid;

    output reg [9:0]rx_data;
    output reg rx_valid;
    output reg MISO;
    
    (*fsm_encoding = "gray"*)


    reg [2:0]cs,ns;
    reg [9:0]data;
    reg [7:0]counter;
    reg data_add;
    reg opcode_done;

    always @(posedge SCK or negedge rst_n) begin
        if (~rst_n) begin
            rx_data <= 0;
            rx_valid <= 0;
            data_add <= 0;
            opcode_done <= 0;
            cs <= IDLE;
            MISO <= 0;
        end else begin
            counter <= 0;
           case (cs)
           IDLE:begin
                if (SS_n) begin
                    MISO <= 0;
                    cs <= ns;
                end else begin
                    cs <= ns;
                end
            end 
            WRITE:begin
                        if (counter < 10) begin
                            data <= {data[8:0],MOSI};
                            counter <= counter + 1;
                        end
                        if (counter == 10) begin
                            rx_data <= data;
                            rx_valid <= 1;
                            cs <= ns;
                        end
            end 
            READ_ADD:begin
                data_add <= ~data_add;
                        if (counter < 10) begin
                            data <= {data[8:0],MOSI};
                            counter <= counter + 1;
                        end
                        if (counter == 10) begin
                            rx_data <= data;
                            rx_valid <= 1;
                            cs <= ns;
                        end
            end 
            READ_DATA:begin
                 data_add <= ~data_add;
                        if (counter < 10 && ~opcode_done) begin
                            data <= {data[8:0],MOSI};
                            counter <= counter + 1;
                        end
                        if (counter == 10 && ~opcode_done) begin
                            rx_data <= data;
                            rx_valid <= 1;
                            counter <= 0;
                            opcode_done <= 1;
                        end
                        if (counter < 8 && opcode_done) begin
                           
                            MISO <= tx_data[7-counter];
                        
                            counter <= counter + 1;
                        end
                        if (counter == 7 && opcode_done) begin
                            cs <= ns;
                        end
                        
            end 
            default: begin
                cs <= ns;
            end
           endcase
            end
        end

    always @(*) begin
        case (cs)
            IDLE:begin
                if (SS_n) begin
                    ns <= IDLE;
                end else begin
                    ns <= CHK_CMD;
                end
            end 
            CHK_CMD:begin
                if (SS_n) begin
                    ns <= IDLE;
                end else begin
                    if (~MOSI) begin
                        ns <= WRITE;
                    end else if (MOSI) begin
                        if (data_add) begin
                            ns <= READ_DATA;
                        end else begin
                             ns <= READ_ADD;
                        end
                    end  
                end
            end
            WRITE:begin
                if (SS_n) begin
                    ns <= IDLE;
                end else begin
                    ns <= IDLE;
                end
            end 
            READ_ADD:begin
                if (SS_n) begin
                    ns <= IDLE;
                end else begin
                     ns <= IDLE;
                end
            end 
            READ_DATA:begin
                if (SS_n) begin
                    ns <= IDLE;
                end begin
                    ns <= IDLE;
                end
            end 
        endcase
    end

endmodule