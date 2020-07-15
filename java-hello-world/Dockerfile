FROM adoptopenjdk/openjdk8-openj9:latest 
COPY . /
WORKDIR / 
ENV MALLOC_ARENA_MAX=1
RUN ln -s /usr/lib/jvm/java-8-openjdk-amd64/jre/lib/amd64/jli/libjli.so /usr/local/lib/
RUN ln -s /usr/lib/jvm/java-8-openjdk-amd64/jre/ /usr/jre
RUN cd src && javac $(find . -name '*.java') -nowarn
CMD ["java","-cp","src/", "-XX:CompressedClassSpaceSize=16m", "-Xnojit","-Xnoaot","-XX:ReservedCodeCacheSize=16m", "-XX:-UseCompiler", "-XX:+UseSerialGC", "-XX:-UsePerfData", "HelloWorld","--scan-class-path"]


