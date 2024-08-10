vlib work
vlog *.v
vsim -voptargs=+acc work.SPI_tb
add wave *
add wave -position insertpoint  \
sim:/SPI_tb/spi_wrapper/spi_slave/tx_valid \
sim:/SPI_tb/spi_wrapper/spi_slave/tx_data \
sim:/SPI_tb/spi_wrapper/spi_slave/rx_data \
sim:/SPI_tb/spi_wrapper/spi_slave/rx_valid \
sim:/SPI_tb/spi_wrapper/spi_slave/ns \
sim:/SPI_tb/spi_wrapper/spi_slave/cs \
sim:/SPI_tb/spi_wrapper/spi_slave/data_add \
sim:/SPI_tb/spi_wrapper/spi_slave/counter \
add wave -position insertpoint  \
sim:/SPI_tb/spi_wrapper/ram/mem
add wave -position insertpoint  \
sim:/SPI_tb/spi_wrapper/ram/write_address \
sim:/SPI_tb/spi_wrapper/ram/read_address
run -all
#quit -sim