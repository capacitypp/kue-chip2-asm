OBJS=Main.o
OBJPATHS=$(addprefix $(BUILDPATH)/, $(OBJS))
CPPFLAGS=$(INCLUDE) -Wall -O2 -std=c++14 -MMD
LDFLAGS=
BUILDPATH=./build
CXX=ccache clang++
TARGET=kc2asm

all : makefolder $(OBJPATHS) macro_expansion
	$(CXX) -o $(TARGET) $(LDFLAGS) $(OBJPATHS)

macro_expansion : macro_expansion_bison macro_expansion_lex
	gcc -o macro_expansion macro_expansion.tab.c macro_expansion.yy.c -lfl

macro_expansion_lex : macro_expansion.l macro_expansion.tab.h
	flex -o macro_expansion.yy.c macro_expansion.l

macro_expansion_bison : macro_expansion.y
	bison -dv macro_expansion.y

$(BUILDPATH)/%.o : %.cpp
	@mkdir -p $(dir $@)
	$(CXX) $(CPPFLAGS) -o $@ -c $<

makefolder :
	@mkdir -p $(BUILDPATH)

clean :
	$(RM) $(TARGET)
	$(RM) -r -f $(BUILDPATH)
	$(RM) *.tab.c
	$(RM) *.tab.h
	$(RM) *.yy.c
	$(RM) *.output

-include $(BUILDPATH)/*.d

