/@(#)depend.sed	8.4/s//@(#)depend.sed	8.4/
s/:.*include[ 	]*/:/
/\.c/s/\.c/.o/
/\.y/s/\.y/.o/
/\.q/s/\.q/.o/
/"sccs.h"/s;"\(.*\)".*;\$H/\1;p
/"protos.h"/s;"\(.*\)".*;\$H/\1;p
/"endian.h"/s;"\(.*\)".*;\$H/\1;p
/"useful.h"/s;"\(.*\)".*;\$H/\1;p
/"tree.h"/s;"\(.*\)".*;\$H/\1;p
/"ingres.h"/s;"\(.*\)".*;\$H/\1;p
/"sre.h"/s;"\(.*\)".*;\$H/\1;p
/"version.h"/s;"\(.*\)".*;\$H/\1;p
/"gconst.h"/s;"\(.*\)".*;\$H/\1;p
/<access.h>/s;<\(.*\)>.*;\$H/\1;p
/<aux.h>/s;<\(.*\)>.*;\$H/\1;p
/<batch.h>/s;<\(.*\)>.*;\$H/\1;p
/<btree.h>/s;<\(.*\)>.*;\$H/\1;p
/<catalog.h>/s;<\(.*\)>.*;\$H/\1;p
/<errors.h>/s;<\(.*\)>.*;\$H/\1;p
/<func.h>/s;<\(.*\)>.*;\$H/\1;p
/<ildr.h>/s;<\(.*\)>.*;\$H/\1;p
/<ingres.h>/s;<\(.*\)>.*;\$H/\1;p
/<lock.h>/s;<\(.*\)>.*;\$H/\1;p
/<pmon.h>/s;<\(.*\)>.*;\$H/\1;p
/<pv.h>/s;<\(.*\)>.*;\$H/\1;p
/<range.h>/s;<\(.*\)>.*;\$H/\1;p
/<resp.h>/s;<\(.*\)>.*;\$H/\1;p
/<sccs.h>/s;<\(.*\)>.*;\$H/\1;p
/<symbol.h>/s;<\(.*\)>.*;\$H/\1;p
/<trace.h>/s;<\(.*\)>.*;\$H/\1;p
/<tree.h>/s;<\(.*\)>.*;\$H/\1;p
/<useful.h>/s;<\(.*\)>.*;\$H/\1;p
/<version.h>/s;<\(.*\)>.*;\$H/\1;p
/"\([^"]*\).*/s//\1/gp