# Statement 2

Once Jenkis is started, create new project and add gitrepo for clone 
https://github.com/spring-projects/spring-petclinic.git

# Build section

```
./mvnw package
```


# Post-build Actions

Build another new project :  *spring-petclinic-copyartifact*

```
spring-petclinic-copyartifact
```

Now, create a new project and name it as *spring-petclinic-copyartifact* which will copy artifact from current *target/.war* to some desired location. 


# spring-petclinic-copyartifact

# Build section

which build: Copy from WORKSPACE of latest completed build

Artifcats to Copy: target/spring-petclinic-2.2.0.BUILD-SNAPSHOT.jar
Target directory: /mnt/artefact

Completed !





