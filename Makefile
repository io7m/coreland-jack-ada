# auto generated - do not edit

default: all

all:\
UNIT_TESTS/ada_size UNIT_TESTS/ada_size.ali UNIT_TESTS/ada_size.o \
UNIT_TESTS/c_size UNIT_TESTS/c_size.o ctxt/bindir.o ctxt/ctxt.a ctxt/dlibdir.o \
ctxt/incdir.o ctxt/repos.o ctxt/slibdir.o ctxt/version.o deinstaller \
deinstaller.o install-core.o install-error.o install-posix.o install-win32.o \
install.a installer installer.o instchk instchk.o insthier.o jack-ada-conf \
jack-ada-conf.o jack-ada.a jack-client.ali jack-client.o jack-error.ali \
jack-error.o jack-port.ali jack-port.o jack-sample.ali jack-sample.o \
jack-server.ali jack-server.o jack-time.ali jack-time.o jack-transport.ali \
jack-transport.o jack-types.ali jack-types.o jack.ali jack.o

# Mkf-deinstall
deinstall: deinstaller conf-sosuffix
	./deinstaller
deinstall-dryrun: deinstaller conf-sosuffix
	./deinstaller dryrun

# Mkf-install
install: installer postinstall conf-sosuffix
	./installer
	./postinstall

install-dryrun: installer conf-sosuffix
	./installer dryrun

# Mkf-instchk
install-check: instchk conf-sosuffix
	./instchk

# Mkf-test
tests:
	(cd UNIT_TESTS && make)
tests_clean:
	(cd UNIT_TESTS && make clean)

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
conf-cc conf-cc mk-cctype
	./mk-cctype > conf-cctype.tmp && mv conf-cctype.tmp conf-cctype

conf-ldtype:\
conf-ld conf-ld mk-ldtype
	./mk-ldtype > conf-ldtype.tmp && mv conf-ldtype.tmp conf-ldtype

conf-sosuffix:\
mk-sosuffix
	./mk-sosuffix > conf-sosuffix.tmp && mv conf-sosuffix.tmp conf-sosuffix

conf-systype:\
mk-systype
	./mk-systype > conf-systype.tmp && mv conf-systype.tmp conf-systype

# ctxt/bindir.c.mff
ctxt/bindir.c: mk-ctxt conf-bindir
	rm -f ctxt/bindir.c
	./mk-ctxt ctxt_bindir < conf-bindir > ctxt/bindir.c

ctxt/bindir.o:\
cc-compile ctxt/bindir.c
	./cc-compile ctxt/bindir.c

ctxt/ctxt.a:\
cc-slib ctxt/ctxt.sld ctxt/bindir.o ctxt/dlibdir.o ctxt/incdir.o ctxt/repos.o \
ctxt/slibdir.o ctxt/version.o
	./cc-slib ctxt/ctxt ctxt/bindir.o ctxt/dlibdir.o ctxt/incdir.o ctxt/repos.o \
	ctxt/slibdir.o ctxt/version.o

# ctxt/dlibdir.c.mff
ctxt/dlibdir.c: mk-ctxt conf-dlibdir
	rm -f ctxt/dlibdir.c
	./mk-ctxt ctxt_dlibdir < conf-dlibdir > ctxt/dlibdir.c

ctxt/dlibdir.o:\
cc-compile ctxt/dlibdir.c
	./cc-compile ctxt/dlibdir.c

# ctxt/incdir.c.mff
ctxt/incdir.c: mk-ctxt conf-incdir
	rm -f ctxt/incdir.c
	./mk-ctxt ctxt_incdir < conf-incdir > ctxt/incdir.c

ctxt/incdir.o:\
cc-compile ctxt/incdir.c
	./cc-compile ctxt/incdir.c

# ctxt/repos.c.mff
ctxt/repos.c: mk-ctxt conf-repos
	rm -f ctxt/repos.c
	./mk-ctxt ctxt_repos < conf-repos > ctxt/repos.c

ctxt/repos.o:\
cc-compile ctxt/repos.c
	./cc-compile ctxt/repos.c

# ctxt/slibdir.c.mff
ctxt/slibdir.c: mk-ctxt conf-slibdir
	rm -f ctxt/slibdir.c
	./mk-ctxt ctxt_slibdir < conf-slibdir > ctxt/slibdir.c

ctxt/slibdir.o:\
cc-compile ctxt/slibdir.c
	./cc-compile ctxt/slibdir.c

# ctxt/version.c.mff
ctxt/version.c: mk-ctxt VERSION
	rm -f ctxt/version.c
	./mk-ctxt ctxt_version < VERSION > ctxt/version.c

ctxt/version.o:\
cc-compile ctxt/version.c
	./cc-compile ctxt/version.c

deinstaller:\
cc-link deinstaller.ld deinstaller.o insthier.o install.a ctxt/ctxt.a
	./cc-link deinstaller deinstaller.o insthier.o install.a ctxt/ctxt.a

deinstaller.o:\
cc-compile deinstaller.c install.h
	./cc-compile deinstaller.c

install-core.o:\
cc-compile install-core.c install.h
	./cc-compile install-core.c

install-error.o:\
cc-compile install-error.c install.h
	./cc-compile install-error.c

install-posix.o:\
cc-compile install-posix.c install.h
	./cc-compile install-posix.c

install-win32.o:\
cc-compile install-win32.c install.h
	./cc-compile install-win32.c

install.a:\
cc-slib install.sld install-core.o install-posix.o install-win32.o \
install-error.o
	./cc-slib install install-core.o install-posix.o install-win32.o \
	install-error.o

install.h:\
install_os.h

installer:\
cc-link installer.ld installer.o insthier.o install.a ctxt/ctxt.a
	./cc-link installer installer.o insthier.o install.a ctxt/ctxt.a

installer.o:\
cc-compile installer.c install.h
	./cc-compile installer.c

instchk:\
cc-link instchk.ld instchk.o insthier.o install.a ctxt/ctxt.a
	./cc-link instchk instchk.o insthier.o install.a ctxt/ctxt.a

instchk.o:\
cc-compile instchk.c install.h
	./cc-compile instchk.c

insthier.o:\
cc-compile insthier.c ctxt.h install.h
	./cc-compile insthier.c

jack-ada-conf:\
cc-link jack-ada-conf.ld jack-ada-conf.o ctxt/ctxt.a
	./cc-link jack-ada-conf jack-ada-conf.o ctxt/ctxt.a

jack-ada-conf.o:\
cc-compile jack-ada-conf.c ctxt.h
	./cc-compile jack-ada-conf.c

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
conf-cc conf-ld

mk-sosuffix:\
conf-systype

mk-systype:\
conf-cc conf-ld

clean-all: sysdeps_clean tests_clean obj_clean ext_clean
clean: obj_clean
obj_clean:
	rm -f UNIT_TESTS/ada_size UNIT_TESTS/ada_size.ali UNIT_TESTS/ada_size.o \
	UNIT_TESTS/c_size UNIT_TESTS/c_size.o ctxt/bindir.c ctxt/bindir.o ctxt/ctxt.a \
	ctxt/dlibdir.c ctxt/dlibdir.o ctxt/incdir.c ctxt/incdir.o ctxt/repos.c \
	ctxt/repos.o ctxt/slibdir.c ctxt/slibdir.o ctxt/version.c ctxt/version.o \
	deinstaller deinstaller.o install-core.o install-error.o install-posix.o \
	install-win32.o install.a installer installer.o instchk instchk.o insthier.o \
	jack-ada-conf jack-ada-conf.o jack-ada.a jack-client.ali jack-client.o \
	jack-error.ali jack-error.o jack-port.ali jack-port.o jack-sample.ali \
	jack-sample.o jack-server.ali jack-server.o jack-time.ali jack-time.o \
	jack-transport.ali jack-transport.o jack-types.ali jack-types.o jack.ali jack.o
ext_clean:
	rm -f conf-adatype conf-cctype conf-ldtype conf-sosuffix conf-systype mk-ctxt

regen:\
ada-srcmap ada-srcmap-all
	./ada-srcmap-all
	cpj-genmk > Makefile.tmp && mv Makefile.tmp Makefile
