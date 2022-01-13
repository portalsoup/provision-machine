hasJavaDependency() {
  if test -f pom.xml; then
    echo -n "Maven pomfile found... "
    _hasMvnDependency $1
  elif test -f build.gradle || test -f build.gradle.kts; then
      echo -n "Gradle file found... "

    _hasGradleDependency $1
  else
    echo "No build system recognized"
  fi
}

listGradleDependencies() {
  if test -f gradlew; then
    chmod +x gradlew # sometimes gradlew is not executable for a project
  fi

  if ./gradlew </dev/null > /dev/null 2>&1; then
    echo "Using this project's Gradle wrapper"
    cmd="./gradlew"
  else
    echo "no Gradle wrapper, using PATH"
    cmd="gradle"
  fi

  $cmd dependencies --configuration=runtimeClasspath \
    $(./gradlew -q projects </dev/null \
      | grep -Fe ---\ Project \
      | sed -Ee "s/^.+--- Project '([^']+)'.*/\1:dependencies --configuration=runtimeClasspath/"
    ) </dev/null
}

listMavenDependencies() {
  if test -f mvnw; then
    chmod +x mvnw # sometimes gradlew is not executable for a project
  fi

  if ./mvnw > /dev/null 2>&1; then
    echo "Using this project's Maven wrapper"
    cmd="./mvnw"
  else
    echo "no Maven wrapper, using PATH"
    cmd="mvn"
  fi

  mvn dependency:tree -Dverbose
}

_hasGradleDependency() {
  listGradleDependencies | grep $1
}

_hasMvnDependency() {
  listMavenDependencies | grep $1
}

# Map each dependency in the mvn dependency tree from a file to an space delineated string containing the
# groupid, artifact and version. Removes unrelated lines and sorts the output removing duplicates.
# Looks for lines such as the following:
#   [INFO] |  +- org.apache.lucene:lucene-core:jar:7.7.2:compile
#
# $1 - Input file containing a maven dependency tree
function tokenizeMvnDepTree() {
  sed -Ee 's/\[INFO\].*-[[:blank:]]([^:\s]+):([^:\s]+):[^:\s]+:([^:]+):*.*$/\1 \2 \3/gp;d' < "$1" | sort -u
}

# Map each dependency in the mvn dependency tree from a file to an space delineated string containing the
# groupid, artifact and version. Removes unrelated lines and sorts the output removing duplicates.
# Looks for lines such as the following:
#    \--- io.netty:netty-common:4.1.59.Final
#
# $1 - Input file containing a maven dependency tree
function tokenizeGradleDepTree() {
  sed -Ee 's/.*---[[:space:]](.*):(.*):([^[:space:]]+).*/\1 \2 \3/gp;d' < "$1" | sort -u
}

# Map tokenized dependencies from a file from "group artifact version" to "group:artifact:version" and return the result
#
# $1 - Input file containing tokenized dependencies
function joinTokenizedMvnDependencies() {
  sed -Ee "s/^([^[:space:]]+)[[:space:]]([^[:space:]]+)[[:space:]]([^[:space:]]+)$/\1:\2:\3/" "$1"
}