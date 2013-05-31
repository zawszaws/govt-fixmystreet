MD_FILES=install.md install-manual.md fmg-overview.md


GEN_DIR=generated-files/
INSTALL_MANUAL_MD=$(GEN_DIR)/install-manual.md
GEN_SRC=$(INSTALL_MANUAL_MD)
PDF_FILES=$(GEN_SRC:.md=.pdf)

#
# Rules for pdf and html generation
#
%.pdf:%.md
	pandoc  -N -o $@ $<

all: $(PDF_FILES)

$(INSTALL_MANUAL_MD):
	-mkdir -p $(GEN_DIR)
	cp  install-manual.md     $@
	cat fmg-overview.md    >> $@ 
	cat install.md         >> $@ 


$(PDF_FILES): $(GEN_SRC) $(MD_FILES)

all: $(PDF_FILES)
