# serial
A serial class to vastly simplify serial comms between a Linux computer and an Arduino

## Interface:

This is a simple serial communications class. It exposes the following interface:

```c++
Serial(string serial_port="/dev/ttyACM0", int baud=9600);
~Serial();
void clear();
ssize_t Write(const char* msg, size_t bytes);
ssize_t Read(char* buffer, size_t bytes);
size_t ReadBlocking(char* buffer, size_t bytes);
```

## Arduino Code:

The Arduino code in `serial_test/serial_test/.ino` is simple: it reads in a byte and writes it right back. The net effect is that it will echo anything to send back at you.

## Usage:

You use the class like this:

```c++
// initialize, open `/dev/ttyACM0` with a buadrate of 9600
Serial serial_port = Serial("/dev/ttyACM0", 9600);

// write 11 bytes to the serial port
ssize_t num_written_bytes = serial_port.Write("hello world", 11);

char buffer[512] = "";
// read up to 512 bytes from the serial port
// Note you may need to add a small sleep here.
// usleep(5000);
ssize_t num_read_bytes = serial_port.Read(buffer, sizeof(buffer));

// zero out the buffer
bzero(buffer, sizeof(buffer));
// wait until we've read exactly 4 bytes from the serial port.
// note that this returns `size_t` rather than `ssize_t`.
size_t num_read_bytes = serial_port.ReadBlocking(buffer, 4);

// take whatever's hanging out in the buffer and nuke it.
serial_port.clear();
```

There is a functional example in `echo.cpp` provided the Arduino is running the code found in `serial_test/`. It compiles with the given makefile and is run like so: `./echo /dev/ttyACM0 115200`.

Remington's non OOPified Easy Serial library that this is based off of can be found in `easy_serial.h`.
