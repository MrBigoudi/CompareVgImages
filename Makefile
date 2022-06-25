# MAEKFILE for generating the doc

# set the directories
SRC_DIR := src
DOC_DIR := doc

SRCS := $(wildcard $(SRC_DIR)/*.mli)

# set the compiler
FIND := ocamlfind
DOCMKR := ocamldoc 

# set the modules deps
PACKAGES := vg

# set the flags
FINDFLAGS := -package $(PACKAGES)
HTMLFLAGS := -html -colorize-code -charset utf-8
DOCFLAGS := $(HTMLFLAGS) -warn-error -verbose

CLEAN := clean_doc

.PHONY: all doc clean_doc clean

# default recipe
all: doc

doc: clean_doc
	@echo -e "\nGenerating doc"
	@echo -e "$(FIND) $(DOCMKR) $(FINDFLAGS) $(DOCFLAGS) -I $(SRC_DIR) -d $(DOC_DIR) $(SRCS)"
	@$(FIND) $(DOCMKR) $(FINDFLAGS) $(DOCFLAGS) -I $(SRC_DIR) -d $(DOC_DIR) $(SRCS)
	@echo -e "Done\n"

# recipes to clean the workspace
clean_doc:
	@echo -e "\nCleaning doc"
	@echo -e "rm -rvf $(DOC_DIR)/*"
	@rm -rvf $(DOC_DIR)/*
	@echo -e "Done\n"

clean: $(CLEAN)
	@echo -e "\nCleaning everything"
	@echo -e "Done\n"
