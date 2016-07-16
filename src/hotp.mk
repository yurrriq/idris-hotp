LIB = target/release/libhotp.dylib
# LIB = target/release/libhotp.a

.PHONY: all clean $(LIB)

all: $(LIB)

clean:
	@rm -f *.a *.dylib

$(LIB):
	@make -C .. lib
	@cp ../$(LIB) .
