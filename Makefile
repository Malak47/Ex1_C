CC = gcc
AR = ar
FLAGS = -Wall -g
OBJECT_BASICLOOP = basicClassification.o advancedClassificationLoop.o
OBJECT_BASICRECURSION = basicClassification.o advancedClassificationRecursion.o

all: mains maindloop maindrec loops loopd recursives recursived

loops: libclassloops.a

libclassloops.a: $(OBJECT_BASICLOOP)
	$(AR) -rsc libclassloops.a $(OBJECT_BASICLOOP)

basicClassification.o: basicClassification.c
	$(CC) $(FLAGS) -c basicClassification.c -lm

advancedClassificationLoop.o: advancedClassificationLoop.c
	$(CC) $(FLAGS) -c advancedClassificationLoop.c -lm


loopd: libclassloops.so

libclassloops.so: $(OBJECT_BASICLOOP)
	$(CC) -shared -o libclassloops.so $(OBJECT_BASICLOOP)

recursives: libclassrec.a

libclassrec.a: $(OBJECT_BASICRECURSION)
	$(AR) -rsc libclassrec.a $(OBJECT_BASICRECURSION)

advancedClassificationRec.o: advancedClassificationRec.c
	$(CC) $(FLAGS) -c advancedClassificationRec.c

recursived: libclassrec.so

libclassrec.so: $(OBJECT_BASICRECURSION)
	$(CC) -shared -o libclassrec.so $(OBJECT_BASICRECURSION)

mains: main.o libclassrec.a
	$(CC) $(FLAGS) -o mains main.o libclassrec.a -lm

maindloop: main.o libclassloops.so
	$(CC) $(FLAGS) -o maindloop main.o ./libclassloops.so -lm

maindrec: main.o libclassrec.so
	$(CC) $(FLAGS) -o maindrec main.o ./libclassrec.so -lm

main.o: main.c NumClass.h
	$(CC) $(FLAGS) -c main.c

clean:
	rm -f *.o *.a *.so mains maindloop maindrec
