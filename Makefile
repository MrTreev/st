# dwm - dynamic menu

include config.mk

MANSYS     = $(SYS)/$(MANDIR)
MANPREFIX  = $(PREFIX)/$(MANDIR)
BINFILE    = $(SYS)/bin/$(BINNAME)
CFILES     = $(SRC)/$(BINNAME).c $(DEPS)
OFILES     = $(patsubst $(SRC)%.c,$(BLD)%.o,$(CFILES))
MFILES     = $(MANSYS)/man1/$(BINNAME).1
INSTALLED  = $(DESTDIR)$(PREFIX)/bin/$(BINNAME) $(DESTDIR)$(MANPREFIX)/man1/$(BINNAME).1

.PHONY: all man install dist
all: $(BINFILE) man
dist: clean
install: install-bin install-man
man: $(MFILES)

$(BLD)/%.o: $(CFILES)
	mkdir -p $(BLD)
	$(CC) $(CFLAGS) -o $@ -c $(@:$(BLD)%.o=$(SRC)%.c)

$(BINFILE): $(OFILES) $(WATCH)
	mkdir -p $(SYS)/bin
	$(CC) $(LDFLAGS) -o $@ $(filter %.o,$^)
	chmod 755 $@

$(MFILES): $(MAN)/$(BINNAME).1
	mkdir -p $(MANSYS)/man1/
	sed "s/VERSION/$(VERSION)/g" < $(@:$(MANSYS)/man1/%=$(MAN)/%) > $@
	chmod 644 $@

.PHONY: install-bin
install-bin: $(BINFILE) $(TOINSTALL)
	mkdir -p "$(DESTDIR)$(PREFIX)"
	cp -ft $(DESTDIR)$(PREFIX)/bin $^

.PHONY: install-man
install-man: $(MFILES)
	mkdir -p "$(DESTDIR)$(MANPREFIX)"
	cp -ft $(DESTDIR)$(MANPREFIX) $^

.PHONY: uninstall
uninstall: $(INSTALLED)
	rm -f $^

.PHONY: clean
clean:
	rm -rf  $(BLD) $(SYS)
