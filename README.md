
# cicd_with_jenkins

### CICD
# Continuous Integration (CI)
![diagram](continuous_integration.png?raw=true "Continuous Integration")
  - developers merge code to main branch multiple times a day and there is an automated build and test process which gives instant feedback
    - faster software builds
    - customer satisfaction by deploying on time
    - small code changes make fault isolation simpler and quicker
# Continuous Delivery (CD)
![diagram](continuousDelivery.png?raw=true "Continuous Integration and Continuous Delivery")
  - CD extends CI by automating the release process so we can deploy our applications at any point of time with the click of a button

# Continuous Deployment (CDE)
![diagram](continuousDeployment.png?raw=true "Continuous Integration and Continuous Deployment")
  - With CDE we go one step further than continuous delivery by deploying to our customers after every development change, fully automated without even clicking a button

# Difference between CD & CDE
  - In continuous delivery the deployment is done manually and in continuous deployment it happens automatically.

# Jenkins and the benefits of using it
  - open-source automation server in which the central build and CI process takes place.
    - great range of plugins
    - supports building, deploying, and automating for projects
    - easy installation
    - simple and user-friendly interface
    - extensible with huge community-contributed plugin resource
    - easy environment configuration in UI
    - supports distributed builds with master-slave architecture

# SDLC using Jenkins
  - SDLC is the unique phases a software project journeys through from birth to release.
    - planning, engineering, test, release
  - Jenkins integrates SDLC processes of all kinds like build, test, document, deploy, stage, static analysis and much more. Jenkins increases the scale of automation and is rapidly gaining popularity in DevOps circle.

# Tools available in industry for CICD
  - Jenkins 
  - Circle ci
  - Team City
  - Bamboo
  - Git Lab

### Building CI
![diagram](JenkinsDiagram.png?raw=true "Jenkins")
# create a ssh connection from our localhost to github
  - generate new ssh key pair on our localhost
    - with gitbash open as administrator, in our .ssh folder, enter the command: `ssh-keygen -t rsa -b 4096 -C "bswenson@globalsparta.com"`
    - it will ask us where to save the file.  Here we enter the name of the file - `eng110_bens`
    - we can select `enter` twice because we don't need a passphrase
    - check in the .ssh folder to be sure the key pair has been created, one private and the other with a .pub suffix 
- go into the .pub file with `cat eng110_bens.pub`
  - copy the entire key
- go to github and navigate to the repo and in the top right corner click on user button for dropdown menu where we can select `Settings`
- On the left hand side, select `SSH and GPG keys`
- under SSH keys, select `new key`
- add the name of the key
- paste the .pub key into the box
- select `Add SSH key`
 
# Build first tests in Jenkins

- sign in to Jenkins
  - provided url: http://18.135.28.156:8080/login?from=%2F
  - username: devopslondon
  - password: DevOpsAdmin
- select `New Item`
- choose name: eng110-bens-test1 
- choose `Freestyle Project`
  - enter description: testing Jenkins Master on AWS for CICD
  - select `Discard old builds`
  - enter 3 maximum builds 
  - scroll down to 'Build'
    - select `Add build step`
    - select `execute shell`
    - First we want to find out which OS does it support
      - enter the command `uname -a`
    - Next we want to find out the date
      - enter the command `date`
- At this stage, we'd like to trigger the next job, to list environment variables, upon success of the previous job. 
-  select `New Item`
-  enter name: eng110_bens_checking_env_var
-  select `Freestyle project`
-  click `ok`
-  enter description if you like
-  check the `Discard old builds` checkbox
-  enter 3 for Max # of builds to keep
-  toward the bottom, under 'Build', select `Add build setup`
-  select `Execute shell`
-  enter command: `printenv`
-  `save`
-  Now go back to the main page
-  click the arrow next to the first job created and in the dropdown menu select `Configure`
-  toward the bottom under 'Post-build Actions' select `Add post-build action`
-  in the dropdown menu select `build other projects`
-  in 'Projects to build' choose the second job created
-  select the checkbox `Trigger only if build is stable` 
-  `save`
-  test if the automation is working by selecting from the first job's arrow dropdown menu `build now`
-  click on the link of the job name
-  on the left hand side in 'Build History' choose the arrow dropdown menu of the job number to select `Console Output` to reveal 
-  we can carry on in this fashion for as many jobs as are needed
  
# Create a ssh connection from Github to Jenkins

  NOTE:
    - GitHub repo - PUBLIC KEY
    - Jenkins - PRIVATE KEY
  - generate new ssh key pair on our localhost
  - with gitbash, in our .ssh folder, enter the command: `ssh-keygen -t rsa -b 4096 -C "bswenson@globalsparta.com"`
  - it will ask us where to save the file.  Here we enter the name of the file - `eng110_cicd_bens`
  - we can select `enter` twice because we don't need a keyphrase
  - check in the .ssh folder to be sure the key pair has been created, one private and the other with a .pub suffix 
  - go into the .pub file with `cat eng110_cicd_bens.pub`
  - copy the entire key
  - go to github and navigate to repo where app is located
  - select `Settings` just above in the middle of the page
  - on the left hand side select `Deploy keys`
  - select `Add deploy key`
  - enter the title of the key
  - paste the key into the box
  - select `Add key`
  - navigate back to the repo page where the app resides
  - select 'Code' button dropdown menu and select `HTTPS` and copy
  - We now need to give this to Jenkins


  - In jenkins, select `New Item`
  - enter name: `bens-continuous-integration`
  - select `Freestyle project`
  - click `ok`
  - add description: building CI with github & localhost using webhooks on github
  - select checkbox `Discard old builds`
  - enter `3` for 'Max # of builds to keep'
  - select checkbox `GitHub project` 
  - In 'Project url' enter the HTTPS url copied from GitHub
  - Now we need to utilize the Agent Node and let the job know where to run this by putting some restrictions in place
    - Under 'Office 365 Connector' select checkbox `Restrict where this project can be run`
    - select the Agent Node name: `sparta-ubuntu-node` - (might need to press backspace and fiddle around with it until it recognises the label)
  - Under 'Source Code Management' select the checkbox `Git`
  - go back to GitHub repo where app is located and select the 'Code' button dropdown menu and choose `SSH` and copy 
  - go back to Jenkins and paste this SSH into `Repository URL`
  - go to .ssh folder and copy the private key
  - go back to Jenkins and in 'Credentials' choose `jenkins`
  - click `Add` button and choose `Jenkins`
  - Under 'Kind' select in the dropdown menu `SSH Username with private key`
  - in 'Username' name the key the same as the file: eng110-bens
  - in 'Private Key' select checkbox `Enter directly`
  - paste key into box
  - click `Add`
  - Once we've added the key we land back to the previous page and under 'Credentials' we can replace 'jenkins' in the dropdown menu with created private key
  - Under 'Branch Specifier' change 'master' to `main`
  - scroll down the page to 'Build Environment' and select checkbox `Provide Node & npm bin/ folder to PATH`
    - 'NodeJS Installation', 'npmrc file' and 'Cache location' have all been allocated by Sparta
  - under 'Build' select `Add build setup` and choose `Execute shell` from dropdown menu
  - Now we need to run the tests in the app
  - Within the app folder review what to expect from the various tests to familiarize 
  - go back to Jenkins and under 'Build' in 'Execute shell' type the following commands:
    - `cd app` (or cd starter-code/app just be sure to provide direct path)
    - `npm install`
    - `npm test`
  - `Save`
  - go back to dashboard
  - locate job in list and select `Build new` from dropdown menu
  - on the left hand side the job is running on the Agent Node
  - back on the middle of the page click on the link of the job
  - under 'Build History' select dropdown menu of job and select `console output`

# Adding a GitHub webhook in your Jenkins Pipeline
  - Edit our build and got to `configure`
  - Under `Build Triggers`, click `Github hook trigger for GITScm polling`.
  - go to project repository
  - go to `settings` in the right corner
  - click on `webhooks`
  - click `Add Webhooks`
  - write the Payload URL as, for example: `http://18.130.133.97:8080/github-webhook` (this is the URL where our Jenkins is running add github-webhooki to tell GitHub that it is a webhook)
  - Click `Let me select individual events`, and select `push` and `pull`.
  - Click `Add webhook`
  - test your webhook by pushing a commit to your GitHub repo. This should automatically trigger the Jenkins job to run.

# CICD/CDE for Jenkins
![diagram](automation_server_jenkins.png?raw=true "Automation Server Jenkins")
- Create a new jenkins item called bens_ci_merge
- create a dev branch on our localhost/GitHub.
- Git push the new change from the dev branch
- When the tests pass, trigger the job to merge the code on dev branch to the main branch
- Create job 3 to clone the code from the main branch and deliver it to AWS EC2 to configure the node app
  - In order to do this, we can SSH into the EC2 instance from Jenkins to install our required dependencies
  - navigate to the app folder
    - run `npm install`
    - run `nohup node app.js > /dev/null 2>&1 &`
- Now the app will be available on the public ip of the EC2 instance.