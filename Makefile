
DEBUG = true
export DEBUG

OBJS = crypto/*.o crypto/encoding/*.o thirdparty/mbedtls/*.o hashmap/hashmap.o


compile: 
	cd crypto; make all;
	cd thirdparty; make all;
	cd hashmap; make all;
	ar rcs libp2p.a $(OBJS)
	
test: compile
	cd test; make all;
	
all: test
	
clean:
	cd crypto; make clean;
	cd hashmap; make clean;
	cd thirdparty; make clean
	cd test; make clean;
	rm -rf libp2p.a
