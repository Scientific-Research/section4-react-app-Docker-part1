# this is the link: https://hub.docker.com/_/node/tags?page=1&name=14.16.0-alpine3.13, where i got the value for FROM section
FROM node:14.16.0-alpine3.13 
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
COPY . .
# with ADD, we have two more features: we can add URL to our image:
# ADD http://.../file.json . : first feature
# ADD file.zip . : second feature => ADD will automatically uncompress it into the directory
# but in normal situation, we use always COPY and when we need these two extra feature, we can use the ADD feature.

# we can run any command with the RUN command that we run it normally in Terminal.
RUN npm install
# or run any windows or Linux command, for example, we want to install python on this image as well!
# but when we run this command, we get an error, because alpine linux doesn't have apt package 
# manager and has apk package manager. So, we don't need to do this in this lesson, that's why 
# i comment it.
# RUN apt install python

