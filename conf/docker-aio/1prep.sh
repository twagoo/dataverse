#!/bin/bash

# move things necessary for integration tests into build context.
# this was based off the phoenix deployment; and is likely uglier and bulkier than necessary in a perfect world

set -ex

MAVEN_VERSION='3.8.8'

mkdir -p testdata/doc/sphinx-guides/source/_static/util/
cp ../solr/8.11.1/schema*.xml testdata/
cp ../solr/8.11.1/solrconfig.xml testdata/
cp ../jhove/jhove.conf testdata/
cp ../jhove/jhoveConfig.xsd testdata/
cd ../../
cp -r scripts conf/docker-aio/testdata/
cp doc/sphinx-guides/source/_static/util/createsequence.sql conf/docker-aio/testdata/doc/sphinx-guides/source/_static/util/

if ! [ -d 'maven' ]; then
	wget -q "https://downloads.apache.org/maven/maven-3/${MAVEN_VERSION}/binaries/apache-maven-${MAVEN_VERSION}-bin.tar.gz"
	tar xfz "apache-maven-${MAVEN_VERSION}-bin.tar.gz"
	mkdir -p maven
	mv "apache-maven-${MAVEN_VERSION}"/* maven/
	echo "export JAVA_HOME=${JAVA_HOME:-/usr/lib/jvm/jre-openjdk}" > maven/maven.sh
	echo "export M2_HOME=../maven" >> maven/maven.sh
	echo "export MAVEN_HOME=../maven" >> maven/maven.sh
	echo "export PATH=../maven/bin:${PATH}" >> maven/maven.sh
	chmod 0755 maven/maven.sh
fi

# not using dvinstall.zip for setupIT.bash; but still used in install.bash for normal ops
source maven/maven.sh && mvn clean
./scripts/installer/custom-build-number
source maven/maven.sh && mvn package -DskipTests=true
cd scripts/installer
make clean
make
mkdir -p ../../conf/docker-aio/dv/install
cp dvinstall.zip ../../conf/docker-aio/dv/install/

# ITs sometimes need files server-side
# yes, these copies could be avoided by moving the build root here. but the build 
#  context is already big enough that it seems worth avoiding.
cd ../../
cp src/test/java/edu/harvard/iq/dataverse/makedatacount/sushi_sample_logs.json conf/docker-aio/testdata/
