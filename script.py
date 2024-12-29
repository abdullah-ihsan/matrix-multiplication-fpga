import serial
import threading
import time

# Configuration for the serial connection
PORT = '/dev/ttyUSB0'  # Replace with the appropriate COM port or device path
BAUDRATE = 9600  # Match the FPGA's baud rate
TIMEOUT = 1  # Timeout for serial read (in seconds)

def send_byte(ser, byte):
    """
    Sends a single byte to the FPGA.
    """
    ser.write(bytes([byte]))
    print(f"Sent: {byte}")

def listen_to_serial(ser):
    """
    Continuously listens for data on the serial port and prints it in decimal.
    Runs in a separate thread.
    """
    while True:
        if ser.in_waiting > 0:
            byte = ser.read(2)
            if byte:
                print(f"Received: {ord(byte)}")  # Convert byte to decimal
        time.sleep(0.01)  # Short delay to avoid excessive CPU usage

def send_matrix(ser, matrix):
    """
    Sends a matrix to the FPGA row by row.
    """
    for row in matrix:
        for value in row:
            send_byte(ser, value)

def main():
    # Define matrices for testing
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


    try:
        # Open the serial connection
        with serial.Serial(PORT, BAUDRATE, timeout=TIMEOUT) as ser:
            print(f"Connected to {PORT} at {BAUDRATE} baud.")
            
            # Start the listener thread
            listener_thread = threading.Thread(target=listen_to_serial, args=(ser,), daemon=True)
            listener_thread.start()
            
             # Send matrix size (3 for 3x3)
            send_byte(ser, 3)
            
            # Send Matrix A
            print("Sending Matrix A:")
            send_matrix(ser, matrix_a)
            
            # Send Matrix B
            print("Sending Matrix B:")
            send_matrix(ser, matrix_b)
            
            # Keep the main thread running to allow the listener to work
            print("Main thread running. Press Ctrl+C to exit.")
            while True:
                time.sleep(1)

    except serial.SerialException as e:
        print(f"Serial error: {e}")
    except KeyboardInterrupt:
        print("Exiting program.")
    except Exception as e:
        print(f"An error occurred: {e}")

if __name__ == "__main__":
    main()
