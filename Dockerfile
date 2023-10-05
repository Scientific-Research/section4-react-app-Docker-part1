# this is the link: https://hub.docker.com/_/node/tags?page=1&name=14.16.0-alpine3.13, where i got the value for FROM section
FROM node:14.16.0-alpine3.13 
# create the user and group of this user in a single line command
RUN addgroup app && adduser -S -G app app
# and then set the user
USER app
# COPY package.json README.md /app/
# COPY package*.json /app/
# copy everything in our current directory to the app directory: using .
# we are using absolute path because it starts with / => /path
# we can use the relative path, if we set the working directory first: 
WORKDIR /app
# COPY . /app/
# . means the destination is current directory like source
# if we have the file with space like hello world.txt and we want to copy it into the destination? we use the
# array form of COPY => COPY["","",""]
# COPY ["hello world.txt", "."]
# COPY . .
COPY package*.json .
# with ADD, we have two more features: we can add URL to our image:
# ADD http://.../file.json . : first feature
# ADD file.zip . : second feature => ADD will automatically uncompress it into the directory
# but in normal situation, we use always COPY and when we need these two extra feature, we can use the ADD feature.

# we can run any command with the RUN command that we run it normally in Terminal.
RUN npm install
COPY . .
# or run any windows or Linux command, for example, we want to install python on this image as well!
# but when we run this command, we get an error, because alpine linux doesn't have apt package 
# manager and has apk package manager. So, we don't need to do this in this lesson, that's why 
# i comment it.
# RUN apt install python

# environment variable for example for an API
ENV API_URL = http://api.myapp.com/

# Exposing Ports => what port on this container will be listening on? answer: port 3000
# but this is only documentation, and later we have to map 300 port in host to the port in conainer
EXPOSE 3000

# we supply a default command to be executed and we don't need anymore to repeat this command in our
# $ docker run react-app npm start => make it simple => docker run react-app
# this is the shell form of command 
# docker will execute this command in a separate shell, that's why it called shell form
# on linux it located in /bin/sh(original shell)
# on windows it located in cmd(command prompt)
# CMD npm start

# another form is Exec form which takes an array of string
# the comman best practice is to use below form: Exec form, because it will excuted directly
# and not in a separate shell - and easier and faster to clean up the resources when we stop the container
# ALWAYS USE EXEC FORM(BELOW FORM)
CMD ["npm", "start"]
# shell form of entrypoint
# ENTRYPONIT npm start
# Exec form -  we can always overwrite the default command when we start a container
# we can run this command: docker run react-app echo hello => it will overwrite our default command: npm start
# but if we want to overwrite an entrypoint, we have to use --entrypoint
# docker run react-app --entryponit 
# if we are sure that this is the program or command that will be started whatever we start the container.
# there is no exception. in this case, we use the ENTRYPOINT
# but with CMD, we have a bit more flexibility and we can always overwrite it.
# with both of these commands, we can supply the default command. 
# this is the matter of personal perference. I prefer to use CMD personally.
# ENTRYPONIT ["npm","start"]


