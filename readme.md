# GCI_Bash
Barebones semi-idempotent bash script for deploying Google Cloud stuff

## Some background

While this script was made for a second year assignment at Karel De Grote University College in May 2022, the logic/approach dates back to my stay at Pfizer Manufacturing around September 2021.

At Pfizer my job consisted of automating manual installation procedures in Powershell within a GMP environment, this included installation procedures but also installation checks. Hence the "Test -> Install -> Test" logic.

When I started the assignment at KdG the adaption from Powershell to Bash was surprisingly easy, most of the work turned out to be adapting the tests to Bash (returning and using values across script files is kind of finicky in Bash, if you are used to Powershell) and getting used to Google's Cloud Shell


If you want to read the original readme.md of the assignment delivery, you can view it below


## Integration Project Group 1 - Google Cloud GCI Deployment

This is the script that handles the entire Google Cloud deployment, this script also uses the original deployment script included in deploy_app.
Additional parameters are inserted in cloudapp_deploy.sh that are needed to make the GC deployment work

### Prerequisites

- UNIX based host
- GCI is installed
- The correct project is selected in GCI
- All variables in variables.sh and systemd.service files are set correctly

### Possible improvements
- Give parameters with functions
    - Certainly possible with smaller functions:
        - Tests
        - Removes
        - Small creates
    - Impossible with larger ones (E.G: )
- More extensive testing (entity values/properties)
- Insert alterations of existing entities
- ~~HTTP to HTTPS Redirection for the load balancer~~ ( ͡° ͜ʖ ͡°)
- Recursive removes (E.G: Firewall rules, subnets, etc..)
- Google Cloud Metadata Server to systemd environment variables
- Image building for rapid deployment in production
- SELinux exception for MVC/API
- SQL Database via VPC only (why create another IP range, it should be a MANAGED service? Thanks Google)
- SQL Database connection via SSL cert
- Automatic SQL User creation


### Notes
- I use my own set up NFS server within the VPC, If the faculty has money for GCloud Filestore shares just let me know ($300+/month)
- Why do I use CI/CD? This saves me a huge amount of work, this is more appropriate for a staging environment instead of a a production env (ex: snapshot/image deployment)


# Post Scriptum
Feel free to draw inspiration (or even just yoink it)
