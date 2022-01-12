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

_hasGradleDependency() {
  if ./gradlew > /dev/null > /dev/null 2>&1; then
    echo "Using this project's Gradle wrapper"
    cmd="./gradlew"
  else
    echo "no Gradle wrapper, using PATH"
    cmd="gradle"
  fi
  $cmd dependencies --configuration=runtimeClasspath \
    $(./gradlew -q projects \
      | grep -Fe ---\ Project \
      | sed -Ee "s/^.+--- Project '([^']+)'.*/\1:dependencies --configuration=runtimeClasspath/"
    ) | grep $1
}

_hasMvnDependency() {
  if ./mvnw > /dev/null 2>&1; then
    echo "Using this project's Maven wrapper"
    cmd="./mvnw"
  else
    echo "no Maven wrapper, using PATH"
    cmd="mvn"
  fi

  mvn dependency:tree -Dverbose | grep $1
}
