import serial
import struct
import time

def send_data(serial_port, matrix_a, matrix_b):
    """
    Sends matrix size and two 3x3 matrices to the FPGA over UART.
    The matrices are serialized row by row.
    """
    rows = len(matrix_a)
    cols = len(matrix_a[0])
    if rows != 3 or cols != 3 or len(matrix_b) != 3 or len(matrix_b[0]) != 3:
        raise ValueError("This script only supports 3x3 matrices.")

    # Send matrix size (fixed at 3 for a 3x3 matrix)
    serial_port.write(struct.pack("B", rows))
    
    # Send Matrix A elements
    for row in matrix_a:
        for elem in row:
            serial_port.write(struct.pack("B", elem))
            time.sleep(0.2)
    
    # Send Matrix B elements
    for row in matrix_b:
        for elem in row:
            serial_port.write(struct.pack("B", elem))
            time.sleep(0.2)


def receive_matrix(serial_port, size):
    """
    Receives a 3x3 matrix from the FPGA over UART.
    """
    while True:
        data = serial_port.read(1)  # Read 1 byte
        num = struct.unpack("B", data)[0]
        print(num)
    # matrix = []
    # for i in range(size):
    #     row = []
    #     for j in range(size):
    #         data = serial_port.read(1)  # Read 1 byte
    #         if data:
    #             row.append(struct.unpack("B", data)[0])
    #         else:
    #             raise TimeoutError("Timeout waiting for data from FPGA.")
    #     matrix.append(row)
    # return matrix


def main():
    # Configuration for the serial port
    serial_port_name = "/dev/ttyUSB0"  # Change to your port (e.g., COM3, /dev/ttyUSB0)
    baud_rate = 9600
    timeout = 1  # Timeout for UART read in seconds

    # Example 3x3 matrices
    matrix_a = [
        [1, 2, 3],
        [4, 5, 6],
        [7, 8, 9]
    ]
    matrix_b = [
        [9, 8, 7],
        [6, 5, 4],
        [3, 2, 1]
    ]

    # Open serial port
    with serial.Serial(serial_port_name, baud_rate, timeout=timeout) as ser:
        time.sleep(2)  # Wait for the serial connection to initialize

        print("Sending Matrix Size and Data:")
        send_data(ser, matrix_a, matrix_b)

        print("\nMatrix A:")
        for row in matrix_a:
            print(row)

        print("\nMatrix B:")
        for row in matrix_b:
            print(row)

        # Assuming the FPGA sends back the result matrix after computation
        size = 3  # Fixed size for 3x3 matrices
        print("\nWaiting for the result matrix...")
        result_matrix = receive_matrix(ser, size)

        print("\nReceived Result Matrix:")
        for row in result_matrix:
            print(row)


if __name__ == "__main__":
    main()
