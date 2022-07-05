# MAEKFILE for generating the doc

# set the directories
SRC_DIR := src
DOC_DIR := doc
OBJ_DIR := obj
BIN_DIR := bin

ML =    $(SRC_DIR)/compare.ml \
        $(SRC_DIR)/test.ml

MLI =   $(SRC_DIR)/compare.mli \
		$(SRC_DIR)/test.mli

CMI = 	$(OBJ_DIR)/compare.cmi \
        $(OBJ_DIR)/test.cmi

CMO = 	$(OBJ_DIR)/compare.cmo \
        $(OBJ_DIR)/test.cmo

TESTS := $(BIN_DIR)/tests.byte #name your executable file

# set the compiler
COMP := ocamlc
FIND := ocamlfind
DOCMKR := ocamldoc 
DEPND = ocamldep

# set the modules deps
PACKAGES := vg,gg

# set the flags
COMPFLAGS := -w -8 -g
LFLAGS    := -linkpkg
THREAD    := -thread
FINDFLAGS := -package $(PACKAGES)
HTMLFLAGS := -html -colorize-code -charset utf-8
DOCFLAGS := $(HTMLFLAGS) -warn-error -verbose

CLEAN := clean_obj clean_bin clean_doc

.PHONY: all test doc dir clean clean_cmi clean_cmo clean_obj clean_bin clean_doc mrproper

# default recipe
all: dir test doc
	@echo -e "\nEverything has compiled successfully\n"

test: $(CMI) $(CMO)
	@echo -e "\nGenerating test"
	@echo "LINKING" $@
	@echo "$(FIND) $(COMP) $(COMPFLAGS) $(FINDFLAGS) $(LFLAGS) $(THREAD) -o $(TESTS) str.cma $(CMO)"
	@$(FIND) $(COMP) $(COMPFLAGS) $(FINDFLAGS) $(LFLAGS) $(THREAD) -o $(TESTS) str.cma $(CMO) || clean_obj
	@echo -e "Done\n"

# recipe for building object files
$(CMO): $(ML)
	@echo -e "\nGenerating cmo files"
	@echo "$(FIND) $(COMP) $(COMPFLAGS) $(FINDFLAGS) -c $(ML)"
	@$(FIND) $(COMP) $(COMPFLAGS) $(FINDFLAGS) -c -I $(SRC_DIR) -I $(OBJ_DIR) $(ML) || make clean_cmo
	@echo "mv $(SRC_DIR)/*.cmo $(OBJ_DIR)/."
	@mv $(SRC_DIR)/*.cmo $(OBJ_DIR)/.
	@echo -e "Done\n"

# recipe for building header files
$(CMI): $(MLI)
	@echo -e "\nGenerating cmi files"
	@echo "$(FIND) $(COMP) $(COMPFLAGS) $(FINDFLAGS) -c $(MLI)"
	@$(FIND) $(COMP) $(COMPFLAGS) $(FINDFLAGS) -c -I $(SRC_DIR) -I $(OBJ_DIR) $(MLI) || make clean_cmi
	@echo "mv $(SRC_DIR)/*.cmi $(OBJ_DIR)/."
	@mv $(SRC_DIR)/*.cmi $(OBJ_DIR)/.
	@echo -e "Done\n"


# create directories
dir:
	mkdir -p $(OBJ_DIR)
	mkdir -p $(BIN_DIR)


# generate doc
doc: clean_doc
	@echo -e "\nGenerating doc"
	@echo "$(FIND) $(DOCMKR) $(FINDFLAGS) $(DOCFLAGS) -I $(SRC_DIR) -d $(DOC_DIR) $(MLI)"
	@$(FIND) $(DOCMKR) $(FINDFLAGS) $(DOCFLAGS) -I $(SRC_DIR) -d $(DOC_DIR) $(MLI)
	@echo -e "Done\n"


# recipes to clean the workspace
clean_doc:
	@echo -e "\nCleaning doc"
	@echo "rm -f $(DOC_DIR)/*"
	@rm -f $(DOC_DIR)/*
	@echo -e "Done\n"

clean_cmi:
	@echo -e "\nCleaning cmi"
	@echo "rm -f $(BIN_DIR)/*cmi"
	@rm -f $(BIN_DIR)/*cmi
	@echo "rm -f $(SRC_DIR)/*.cmi"
	@rm -f $(SRC_DIR)/*.cmi
	@echo -e "Done\n"

clean_cmo:
	@echo -e "\nCleaning cmo"
	@echo "rm -f $(BIN_DIR)/*cmo"
	@rm -f $(BIN_DIR)/*cmo
	@echo "rm -f $(SRC_DIR)/*.cmo"
	@rm -f $(SRC_DIR)/*.cmo
	@echo -e "Done\n"

clean_obj:
	@echo -e "\nCleaning obj"
	@echo "rm -f $(OBJ_DIR)/*"
	@rm -f $(OBJ_DIR)/*
	@make clean_cmi
	@make clean_cmo
	@echo -e "Done\n"

clean_bin:
	@echo -e "\nCleaning bin"
	@echo "rm -f $(BIN_DIR)/*"
	@rm -f $(BIN_DIR)/*
	@echo -e "Done\n"	

clean: 
	@echo -e "\nClean bin and objs"
	@make clean_bin
	@make clean_obj
	@echo -e "Done\n"

mrproper: $(CLEAN)
	@echo -e "\nCleaning everything"
	@echo -e "Done\n"