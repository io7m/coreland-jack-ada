# auto generated - do not edit

default: all

all:\
UNIT_TESTS/ada_size UNIT_TESTS/ada_size.ali UNIT_TESTS/ada_size.o \
UNIT_TESTS/c_size UNIT_TESTS/c_size.o jack-ada.a jack-client.ali jack-client.o \
jack-error.ali jack-error.o jack-port.ali jack-port.o jack-sample.ali \
jack-sample.o jack-server.ali jack-server.o jack-time.ali jack-time.o \
jack-transport.ali jack-transport.o jack-types.ali jack-types.o jack.ali jack.o

# -- SYSDEPS start
flags-jack:
	@echo SYSDEPS jack-flags run create flags-jack 
	@(cd SYSDEPS/modules/jack-flags && ./run)
libs-jack:
	@echo SYSDEPS jack-libs run create libs-jack 
	@(cd SYSDEPS/modules/jack-libs && ./run)


jack-flags_clean:
	@echo SYSDEPS jack-flags clean flags-jack 
	@(cd SYSDEPS/modules/jack-flags && ./clean)
jack-libs_clean:
	@echo SYSDEPS jack-libs clean libs-jack 
	@(cd SYSDEPS/modules/jack-libs && ./clean)


sysdeps_clean:\
jack-flags_clean \
jack-libs_clean \


# -- SYSDEPS end


UNIT_TESTS/ada_size:\
ada-bind ada-link UNIT_TESTS/ada_size.ald UNIT_TESTS/ada_size.ali \
jack-client.ali jack-error.ali jack-port.ali jack-sample.ali jack-server.ali \
jack-time.ali jack-transport.ali jack-types.ali jack.ali jack-ada.a
	./ada-bind UNIT_TESTS/ada_size.ali
	./ada-link UNIT_TESTS/ada_size UNIT_TESTS/ada_size.ali jack-ada.a

UNIT_TESTS/ada_size.ali:\
ada-compile UNIT_TESTS/ada_size.adb jack.ads jack-transport.ads jack-types.ads
	./ada-compile UNIT_TESTS/ada_size.adb

UNIT_TESTS/ada_size.o:\
UNIT_TESTS/ada_size.ali

UNIT_TESTS/c_size:\
cc-link UNIT_TESTS/c_size.ld UNIT_TESTS/c_size.o
	./cc-link UNIT_TESTS/c_size UNIT_TESTS/c_size.o

UNIT_TESTS/c_size.o:\
cc-compile UNIT_TESTS/c_size.c
	./cc-compile UNIT_TESTS/c_size.c

ada-bind:\
conf-adabind conf-systype conf-adatype conf-adabflags conf-adafflist flags-cwd

ada-compile:\
conf-adacomp conf-adatype conf-systype conf-adacflags conf-adafflist flags-cwd

ada-link:\
conf-adalink conf-adatype conf-systype conf-adaldflags conf-aldfflist libs-jack

ada-srcmap:\
conf-adacomp conf-adatype conf-systype

ada-srcmap-all:\
ada-srcmap conf-adacomp conf-adatype conf-systype

cc-compile:\
conf-cc conf-cctype conf-systype conf-ccfflist flags-jack

cc-link:\
conf-ld conf-ldtype conf-systype conf-ldfflist libs-jack

cc-slib:\
conf-systype

conf-adatype:\
mk-adatype
	./mk-adatype > conf-adatype.tmp && mv conf-adatype.tmp conf-adatype

conf-cctype:\
conf-cc mk-cctype
	./mk-cctype > conf-cctype.tmp && mv conf-cctype.tmp conf-cctype

conf-ldtype:\
conf-ld mk-ldtype
	./mk-ldtype > conf-ldtype.tmp && mv conf-ldtype.tmp conf-ldtype

conf-systype:\
mk-systype
	./mk-systype > conf-systype.tmp && mv conf-systype.tmp conf-systype

jack-ada.a:\
cc-slib jack-ada.sld jack-client.o jack-error.o jack-port.o jack-sample.o \
jack-server.o jack-time.o jack-transport.o jack-types.o jack.o
	./cc-slib jack-ada jack-client.o jack-error.o jack-port.o jack-sample.o \
	jack-server.o jack-time.o jack-transport.o jack-types.o jack.o

jack-client.ads:\
jack-types.ads jack-transport.ads

jack-client.ali:\
ada-compile jack-client.adb jack-client.ads
	./ada-compile jack-client.adb

jack-client.o:\
jack-client.ali

jack-error.ali:\
ada-compile jack-error.adb jack-error.ads
	./ada-compile jack-error.adb

jack-error.o:\
jack-error.ali

jack-port.ads:\
jack-types.ads jack-transport.ads

jack-port.ali:\
ada-compile jack-port.adb jack-port.ads
	./ada-compile jack-port.adb

jack-port.o:\
jack-port.ali

jack-sample.ali:\
ada-compile jack-sample.ads jack-sample.ads
	./ada-compile jack-sample.ads

jack-sample.o:\
jack-sample.ali

jack-server.ads:\
jack-types.ads jack-transport.ads

jack-server.ali:\
ada-compile jack-server.adb jack-server.ads
	./ada-compile jack-server.adb

jack-server.o:\
jack-server.ali

jack-time.ali:\
ada-compile jack-time.ads jack-time.ads jack-types.ads jack-transport.ads
	./ada-compile jack-time.ads

jack-time.o:\
jack-time.ali

jack-transport.ali:\
ada-compile jack-transport.ads jack-transport.ads jack-types.ads
	./ada-compile jack-transport.ads

jack-transport.o:\
jack-transport.ali

jack-types.ali:\
ada-compile jack-types.ads jack-types.ads jack-sample.ads
	./ada-compile jack-types.ads

jack-types.o:\
jack-types.ali

jack.ali:\
ada-compile jack.ads jack.ads
	./ada-compile jack.ads

jack.o:\
jack.ali

mk-adatype:\
conf-adacomp conf-systype

mk-cctype:\
conf-cc conf-systype

mk-ctxt:\
mk-mk-ctxt
	./mk-mk-ctxt

mk-ldtype:\
conf-ld conf-systype conf-cctype

mk-mk-ctxt:\
conf-cc

mk-systype:\
conf-cc

clean-all: sysdeps_clean obj_clean ext_clean
clean: obj_clean
obj_clean:
	rm -f UNIT_TESTS/ada_size UNIT_TESTS/ada_size.ali UNIT_TESTS/ada_size.o \
	UNIT_TESTS/c_size UNIT_TESTS/c_size.o jack-ada.a jack-client.ali jack-client.o \
	jack-error.ali jack-error.o jack-port.ali jack-port.o jack-sample.ali \
	jack-sample.o jack-server.ali jack-server.o jack-time.ali jack-time.o \
	jack-transport.ali jack-transport.o jack-types.ali jack-types.o jack.ali jack.o
ext_clean:
	rm -f conf-adatype conf-cctype conf-ldtype conf-systype mk-ctxt

regen:\
ada-srcmap ada-srcmap-all
	./ada-srcmap-all
	cpj-genmk > Makefile.tmp && mv Makefile.tmp Makefile
