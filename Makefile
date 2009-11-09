# auto generated - do not edit

default: all

all:\
local ctxt/bindir.o ctxt/ctxt.a ctxt/dlibdir.o ctxt/incdir.o ctxt/repos.o \
ctxt/slibdir.o ctxt/version.o deinstaller deinstaller.o install-core.o \
install-error.o install-posix.o install-win32.o install.a installer installer.o \
instchk instchk.o insthier.o jack-ada-conf jack-ada-conf.o jack-ada.a jack-enum \
jack-enum.o jack-thin.ali jack-thin.o jack.ali jack.o

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

# Mkf-local
local: flags-jack libs-jack flags-c_string libs-c_string-S
	./check-deps

local_pre:
local_clean:

# Mkf-test
tests:
	(cd UNIT_TESTS && make)
tests_clean:
	(cd UNIT_TESTS && make clean)

#----------------------------------------------------------------------
# SYSDEPS start

flags-c_string:
	@echo SYSDEPS c_string-flags run create flags-c_string 
	@(cd SYSDEPS && ./sd-run modules/c_string-flags)
libs-c_string-S:
	@echo SYSDEPS c_string-libs-S run create libs-c_string-S 
	@(cd SYSDEPS && ./sd-run modules/c_string-libs-S)
flags-jack:
	@echo SYSDEPS jack-flags run create flags-jack 
	@(cd SYSDEPS && ./sd-run modules/jack-flags)
libs-jack:
	@echo SYSDEPS jack-libs run create libs-jack 
	@(cd SYSDEPS && ./sd-run modules/jack-libs)


c_string-flags_clean:
	@echo SYSDEPS c_string-flags clean flags-c_string 
	@(cd SYSDEPS && ./sd-clean modules/c_string-flags)
c_string-libs-S_clean:
	@echo SYSDEPS c_string-libs-S clean libs-c_string-S 
	@(cd SYSDEPS && ./sd-clean modules/c_string-libs-S)
jack-flags_clean:
	@echo SYSDEPS jack-flags clean flags-jack 
	@(cd SYSDEPS && ./sd-clean modules/jack-flags)
jack-libs_clean:
	@echo SYSDEPS jack-libs clean libs-jack 
	@(cd SYSDEPS && ./sd-clean modules/jack-libs)


sysdeps_clean:\
c_string-flags_clean \
c_string-libs-S_clean \
jack-flags_clean \
jack-libs_clean \



# SYSDEPS end
#----------------------------------------------------------------------

ada-bind:\
conf-adabind conf-systype conf-adatype conf-adabflags conf-adafflist flags-cwd \
	flags-c_string

ada-compile:\
conf-adacomp conf-adatype conf-systype conf-adacflags conf-adafflist flags-cwd \
	flags-c_string

ada-link:\
conf-adalink conf-adatype conf-systype conf-adaldflags conf-aldfflist \
	libs-c_string-S libs-jack

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
cc-slib jack-ada.sld jack.o jack-thin.o
	./cc-slib jack-ada jack.o jack-thin.o

jack-enum:\
cc-link jack-enum.ld jack-enum.o
	./cc-link jack-enum jack-enum.o

jack-enum.o:\
cc-compile jack-enum.c
	./cc-compile jack-enum.c

# jack-thin.ads.mff
jack-thin.ads:  \
jack-thin.ads.0 \
jack-thin.ads.N \
jack_types.dat  \
jack_names.dat  \
jack_const.dat  \
jack-enum       \
jack-mkconst.sh \
types.dat       \
block-comment   \
jack-mkapi.lua
	rm -f jack-thin.ads.tmp
	cat jack-thin.ads.0 >> jack-thin.ads.tmp
	./block-comment "Constants" >> jack-thin.ads.tmp
	./jack-mkconst.sh jack_const.dat >> jack-thin.ads.tmp
	./block-comment "API" >> jack-thin.ads.tmp
	./jack-mkapi.lua jack_types.dat jack_names.dat types.dat >> jack-thin.ads.tmp
	./block-comment "Statistics" >> jack-thin.ads.tmp
	./jack-mkapi.lua jack_statistics_types.dat jack_statistics_names.dat types.dat >> jack-thin.ads.tmp
	./block-comment "Intclient" >> jack-thin.ads.tmp
	./jack-mkapi.lua jack_intclient_types.dat jack_intclient_names.dat types.dat >> jack-thin.ads.tmp
	cat jack-thin.ads.N >> jack-thin.ads.tmp
	mv jack-thin.ads.tmp jack-thin.ads

jack-thin.o jack-thin.ali:\
ada-compile jack-thin.ads
	./ada-compile jack-thin.ads

jack.o jack.ali:\
ada-compile jack.ads jack.ads
	./ada-compile jack.ads

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

clean-all: sysdeps_clean tests_clean local_clean obj_clean ext_clean
clean: obj_clean
obj_clean:
	rm -f ctxt/bindir.c ctxt/bindir.o ctxt/ctxt.a ctxt/dlibdir.c ctxt/dlibdir.o \
	ctxt/incdir.c ctxt/incdir.o ctxt/repos.c ctxt/repos.o ctxt/slibdir.c \
	ctxt/slibdir.o ctxt/version.c ctxt/version.o deinstaller deinstaller.o \
	install-core.o install-error.o install-posix.o install-win32.o install.a \
	installer installer.o instchk instchk.o insthier.o jack-ada-conf \
	jack-ada-conf.o jack-ada.a jack-enum jack-enum.o jack-thin.ads jack-thin.ali \
	jack-thin.o jack.ali jack.o
ext_clean:
	rm -f conf-adatype conf-cctype conf-ldtype conf-sosuffix conf-systype mk-ctxt

regen:\
ada-srcmap ada-srcmap-all
	./ada-srcmap-all
	cpj-genmk > Makefile.tmp && mv Makefile.tmp Makefile
