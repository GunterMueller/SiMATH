#!/usr/bin/awk -f
#
# usage: awk -f Makemakefile.awk *.S
#        This should be run in library directories.
#


BEGIN{
  mesout="/dev/stderr";
  Makefile="Makefile";
  "pwd" | getline PWD;
  exist= !system("test -e Makemakefile.awk");
  if(exist){
    print "Makemakefile: cannot run in current directory", PWD  > mesout;
    print "Makemakefile: Makefile unchanged"                    > mesout;
    exit;
  }

  ("basename " PWD) | getline LIB;
  print "Makemakefile: generating Makefile for", LIB, "..."     > mesout;

  system("rm -f " Makefile);
}
FNR==1{
  append=1;
}
FNR<=10 && /MACRO/{
  print "Makemakefile: skipping", FILENAME, "..."               > mesout;
  append=0;
}
FNR==11 && append{
  print "Makemakefile: appending", FILENAME, "..."              > mesout;
  if (FILENAME ~ /_lo\./) {
    LoList[++m]=substr(FILENAME,1,length(FILENAME)-1) "o";
  }
  else {
    List[++n]=substr(FILENAME,1,length(FILENAME)-1) "o";
  }
}
END{
  print "include ../../Makefile.flags"                >> Makefile;
  print "\n"                                          >> Makefile;
  print "SMBIN = ../../bin"                           >> Makefile;
  print "\n"                                          >> Makefile;

  print "LO_OBJECTS = \\"                             >> Makefile;
  for(i=1;i<m;i++){
    printf "  %s \\\n", LoList[i]                     >> Makefile;
  }
  print "  " LoList[m]                                >> Makefile;
  print "\n"                                          >> Makefile;

  print "OBJECTS = \\"                                >> Makefile;
  for(i=1;i<n;i++){
    printf "  %s \\\n", List[i]                       >> Makefile;
  }
  print "  " List[n]                                  >> Makefile;
  print "\n"                                          >> Makefile;

  printf "LIB= ../../lib/lib_%s.a\n", LIB             >> Makefile;
  print "\n"                                          >> Makefile;

  print "all: ${LIB}"                                 >> Makefile;
  print "\n"                                          >> Makefile;

  print "clean:"                                      >> Makefile;
  print "\trm -f *.P *.c *.o *~"                      >> Makefile;
  print "\n"                                          >> Makefile;
  
  print "veryclean: clean"                            >> Makefile;
  print "\trm -f ${LIB}"                              >> Makefile;
  print "\n"                                          >> Makefile;

  print "${LIB}: ${LO_OBJECTS} ${OBJECTS}"            >> Makefile;
  print "\t${AR} rc $@ $^"                            >> Makefile;
  print "\t- ${RANLIB} ${LIB}"                        >> Makefile;
}
