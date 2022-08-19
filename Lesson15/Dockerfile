FROM ubuntu:latest
WORKDIR /my_app_directory
LABEL email="andriy.kovalchuk86@gmail.com"
ENV status="Completed"
ENV date="19.08.2022"
RUN apt update
RUN apt install -y python3
ADD https://github.com/AndriiKovalchuk86/ScriptRepo/blob/main/Lesson12/.Jenkins \
/test
RUN apt install -y net-tools
RUN apt install -y default-jre
RUN apt install -y jenkins
EXPOSE 8080
ADD https://github.com/AndriiKovalchuk86/ScriptRepo/blob/main/hello_world.sh \
/test
CMD [ "/bin/bash", "/test/hello_world.sh" ]

VOLUME /devops_volume https://github.com/AndriiKovalchuk86/ScriptRepo/blob/main/Lesson7
