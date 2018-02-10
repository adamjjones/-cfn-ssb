Creating a just cluster is ECS is not hard, basically it is a form. It asks what type of instances (size) are wanted and how many. If one of the instances die for any reason another one spawns to meet the desired number of instanes.

However, I could not make the instances pass th health checks and they kept dying and respawning.

I decided to move to cloudformation. The following snippet is where the image, type, and keypair are defined. It also installs any software the EC2 instances need to run. The desired capacity, max and min cluster size is defined in AutoScaling group definition.

 Properties:
      ImageId: ami-08111162
      InstanceType: t2.micro
      KeyName: adam-jones-keypair
      SecurityGroups:
      - Ref: WordpressAutoScalingSecurityGroup
      UserData:
        Fn::Base64:
          Fn::Sub: |
            #!/bin/bash -xe
            sleep 5
            curl -o /tmp/get-pip.py https://bootstrap.pypa.io/get-pip.py
            python /tmp/get-pip.py
:CloudFormation::Init:
 67         config:
            /usr/local/bin/pip install https://s3.amazonaws.com/cloudformation-examples/aws-cfn-bootstrap-ltest.tar.gz
            yum -y install httpd php php-mysql telnet mysql
            cd /var/www/html
            /bin/rm -rf ./*
            curl -sL https://wordpress.org/latest.tar.gz | tar xfz -
            /bin/mv wordpress/* .
            chown -R root:root wordpress
            sed -e 's/wp_/ssb_/g' -e 's/database_name_here/sunshinewp/g' -e 's/username_here/root/g' -e 's/assword_here/cornet13/g' -e 's/localhost/capstone-db.cgfvjmb9egc7.us-east-1.rds.amazonaws.com/g' < wp-confi-sample.php > wp-config.php


The line that starts with - Ref: WordpressAutoScalingSecurityGroup defines the incoming ports that traffic can enter though, which is 22 and 8 defines the incoming ports that traffic can enter though, which is 22 and 80.

