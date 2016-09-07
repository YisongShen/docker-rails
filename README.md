This is an example to migrate a simplest rails server with sqlite3 into a docker in CentOS. And the rails server will be started automatically after docker run.

You need to install ruby 2.3.0 and rails first. 

The rails is created by command 'rails new yourprojectname', and I add the dockerfile and modify the gemfile to dockerize the rails.

For the gemfile, I added the 'gem 'therubyracer'' to avoid the error:
"There was an error while trying to load the gem 'uglifier'. (Bundler::GemRequireError)
Gem Load Error is: Could not find a JavaScript runtime. See https://github.com/rails/execjs for a list of available runtimes."

And you can check the code in dockerfile to know how to write dockerfile.

If you want to use, you need to first cd to the path of dockerfile
Then:
$docker build -t demo .

If you do all this step in your local machine, you can connect to server by:
$docker run -d demo
$curl localhost:3000

You have another two ways to connect to the server in docker. (Both can be used in your local machine or a virtual machine)
One way: 
First run the container
$docker run -d demo or $docker run -it demo
Then check the process
$docker ps
Identify the container IP
$docker inspect yourcontainerID
You can find your container ID, then
$curl yourcontainerID:3000

Another way:
First run the container
$docker run -itP demo
Then check the process
$docker ps
This time you may see the the ports is "0.0.0.0:port(this is a number)->3000/tcp"
Then you can directly connect by:
$curl 0.0.0.0:port
