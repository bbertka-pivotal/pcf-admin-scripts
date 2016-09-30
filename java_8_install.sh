#!/bin/sh

# Installs Java and Maven

sudo apt-get install openjdk-8-jdk

export JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64

export PATH=$PATH:${JAVA_HOME}/bin

sudo apt-get install maven


