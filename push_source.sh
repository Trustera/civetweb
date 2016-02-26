#!/bin/bash
INT_DIR=/tmp/civetweb-src-$1
OUT_FILE=$PWD/civetweb-$1.tgz

mkdir -p $INT_DIR
cp src/*.c $INT_DIR
cp src/*.cpp $INT_DIR
cp src/*.inl $INT_DIR
cp include/*.h $INT_DIR

pushd $INT_DIR
tar -czf $OUT_FILE *
popd

mvn deploy:deploy-file -Durl=http://nexus.trustera.ld:8081/nexus/content/repositories/releases \
	-DrepositoryId=trustera-release -DgroupId=com.trusteracorp.ext -DartifactId=civetweb \
	-Dversion=$1 -Dpackaging=tgz -Dclassifier=source -Dfile=civetweb-$1.tgz
