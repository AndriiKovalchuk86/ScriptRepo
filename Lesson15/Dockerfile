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
RUN awget -q -O - https://pkg.jenkins.io/debian-stable/jenkins.io.key
RUN gpg --dearmor -o /usr/share/keyrings/jenkins.gpg
RUN sh -c 'echo deb [signed-by=/usr/share/keyrings/jenkins.gpg] http://pkg.jenkins.io/debian-stable binary/ > /etc/apt/sources.list.d/jenkins.list'
RUN apt install -y jenkins
EXPOSE 8080
ADD https://github.com/AndriiKovalchuk86/ScriptRepo/blob/main/hello_world.sh \
/test
CMD [ "/bin/bash", "/test/hello_world.sh" ]

VOLUME /devops_volume https://github.com/AndriiKovalchuk86/ScriptRepo/blob/main/Lesson7
