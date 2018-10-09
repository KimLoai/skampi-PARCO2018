#!/bin/sh

# Script for automatic generation of Makefile dependencies
# Receives list of .c files as arguments

echo "# Created by makedep.sh, do not edit" > Makefile.dep
echo "" >> Makefile.dep

for x in $@
do
  if ! $CPP $CPPFLAGS -E -MG -MM $x >> Makefile.dep ; then
    rm -f Makefile.dep
    exit 1
  fi
  echo "\t\$(MPICC) -c \$(CFLAGS) $x" >> Makefile.dep
done

echo "skampi_pure: $OBJECTS"   >> Makefile.dep
echo "\t\$(MPICC) -o skampi_pure $OBJECTS -lm" >> Makefile.dep
echo "skampi_profiler: $OBJECTS"   >> Makefile.dep
echo "\t\$(MPICC) $OBJECTS libdang.a -lm -o skampi_profiler" >> Makefile.dep
