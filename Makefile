SRC = Serial.cpp echo.cpp
OBJ = $(SRC:.cpp=.o)

CC = g++
LINK = g++

CFLAGS = -O3 -Wall -Wextra -Wpedantic -std=c++11
CXXFLAGS = $(CFLAGS)

TARGET = echo

all: $(TARGET)

$(TARGET): $(OBJ)
	$(LINK) -o $@ $^ $(CFLAGS)

.cpp:
	$(CC) -o $@ $@.cpp

clean:
	rm -rf *.o *.so *.gch *.orig $(TARGET)

format:
	astyle --indent=spaces --style=allman *.h *.cpp
	
install:
	g++ -fPIC -shared Serial.cpp -o libserial.so
	sudo cp ./Serial.h /usr/include/Serial.h
	if [ -d "/usr/lib64" ]; then sudo cp ./libserial.so /usr/lib64/libserial.so; fi 
	if [ -d "/usr/lib" ]; then sudo cp ./libserial.so /usr/lib/libserial.so; fi 
