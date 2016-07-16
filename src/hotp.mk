LIB = target/release/libhotp.a

.PHONY: all clean

all: libhotp.a

clean:
	@rm -f libhotp.a

libhotp.a:
	@make -C .. $(LIB)
	@cp ../$(LIB) .
