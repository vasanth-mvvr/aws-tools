## Jenkins
# ** plugins: **
* pipeline stage 
* AnsiColor
* Pipeline utility steps
* nexus artifact uploader
* Rebuilder
* SonarQube
configure aws in the normal user    

## WebHooks 
Provide the webhook in the github 
payload url : http://<ip address>:8080/github-webhook/
content type: json
event: pushes

## Jenkins
Triggers : github hook trigger