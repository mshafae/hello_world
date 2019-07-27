
TARGET=hello_world
CFILES=hello_world.c
OBJECTS=$(CFILES:.c=.o)
DEP=$(CFILES:.c=.d)

default all: $(TARGET)

$(TARGET): $(OBJECTS)
	$(CC) -o $(TARGET) $(OBJECTS)

-include $(DEP)

%.d: %.c
	set -e; $(CC) -MM $(CFLAGS) $< \
	        | sed 's/\($*\)\.o[ :]*/\1.o $@ : /g' > $@; \
	        [ -s $@ ] || rm -f $@

%.o: %.c
	$(CC) $(CFLAGS) -c $<

clean:
	-rm -f $(OBJECTS) $(TARGET) $(DEP)

