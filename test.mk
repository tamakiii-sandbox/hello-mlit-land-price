.PHONY: list test

list:
	@$(MAKE) -pRrq -f $(lastword $(MAKEFILE_LIST)) : 2>/dev/null | awk -v RS= -F: '/^# File/,/^# Finished Make data base/ {if ($$1 !~ "^[#.]") {print $$1}}' | sort | egrep -v -e '^[^[:alnum:]]' | egrep -v -e '^$@$$'

LIST := a: b:bb,bbb

VAR := a:
info:
	echo $(call target,$(VAR))
	echo $(call prerequisites,$(VAR))

, := ,
target = $(word 1,$(subst :, ,$1))
prerequisites = $(subst $(,), ,$(word 2,$(subst :, ,$1)))


define download-rule

$1: $2
	echo $$@

$2:
	echo $$@

endef

$(foreach l,$(LIST),$(eval \
      $(call download-rule,$(call target,$l),$(call prerequisites,$l)) \
))







# $(eval $(call download-rule,ch01-bogus-tab,ch01-bogus-tab.zip))

# LIST := (a:) (b: bb) (c: cc ccc)
#
# $(foreach list,$(LIST),$(eval \
#       $(call download-rule,ch01-bogus-tab,ch01-bogus-tab.zip) \
# ))


# $(eval $(call generic-program-example,example-directory))

# # $(call generic-program-example,example-directory)
# #   Create the rules to build a generic example.
# define generic-program-example
#   $(eval $1_dir	:= $(OUTPUT_DIR)/$1)
#   $(eval $1_make_out := $($1_dir)/make.out)
#   $(eval $1_run_out  := $($1_dir)/run.out)
#   $(eval $1_clean    := $($1_dir)/clean)
#   $(eval $1_run_make := $($1_dir)/run-make)
#   $(eval $1_run_run  := $($1_dir)/run-run)
#   $(eval $1_sources  := $(filter-out %/CVS, $(wildcard $(EXAMPLES_DIR)/$1/*)))
#   $($1_run_out): $($1_make_out) $($1_run_run)
#	   $$(call run-script-example, $($1_run_run), $$@)
# 
#   $($1_make_out): $($1_clean) $($1_run_make)
#	   $$(call run-script-example, $($1_run_make), $$@)
# 
#   $($1_clean): $($1_sources) Makefile
#	   $(RM) -r $($1_dir)
#	   $(MKDIR) $($1_dir)
#	   $(LNDIR) -silent ../../$(EXAMPLES_DIR)/$1 $($1_dir)
#	   $(TOUCH) $$@
# 
#   $($1_run_make):
#	   printf "#! /bin/bash -x\nmake\n" > $$@
# endef
