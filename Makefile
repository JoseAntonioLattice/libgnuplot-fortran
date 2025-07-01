libname = gnuplot
FC = gfortran
major = 0
minor = 0
release = 0
version = $(major).$(minor).$(release)
SRCDIR = src
OBJDIR = obj
BUILD = build
SOURCE = gnuplot.f90

OBJECTS = $(patsubst %.f90, $(OBJDIR)/%.o, $(SOURCE))

LIB = $(HOME)/Fortran/lib
INC = $(HOME)/Fortran/include

.PHONY : install all test readme cleanlib

all : install $(LIB)/lib$(libname).so 

$(LIB)/lib$(libname).so.$(version): $(OBJECTS)
	$(FC) -shared -o $@ $^	

$(OBJDIR)/%.o: $(SRCDIR)/%.f90 $(OBJDIR) 
	$(FC) -O3 -fpic -c -J $(INC) $< -o $@

$(LIB)/lib$(libname).so.$(major) : $(LIB)/lib$(libname).so.$(version)
	ln -s $< $@

$(LIB)/lib$(libname).so : $(LIB)/lib$(libname).so.$(major)
	ln -s $< $@

$(OBJDIR):
	mkdir -p $@

install:
	./install.sh

test: $(BUILD) 
	@$(FC) -I$(INC) test/test.f90 -o $(BUILD)/$@ -L$(LIB) -l$(libname) -lmat -lnum2str
	@LD_LIBRARY_PATH=$(LIB) $(BUILD)/$@

$(BUILD):
	mkdir -p $@

readme:
	pandoc -f gfm README.md -o README.pdf

cleanlib:
	rm -r $(LIB)/lib$(libname).* $(INC)/lib$(libname).*
