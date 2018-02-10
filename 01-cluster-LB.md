Creating just a cluster in ECS is basically a form. It asks what type of instances (size) are wanted and how many. If one of the instances die for any reason another one spawns to meet the desired number of instanes.

However, I could not make the instances pass the health checks and they kept dying and respawning.

I decided to move to cloudformation. It is a file where you describe what you want in your stack. Cloudformation uses a YAML file to describe what you want and cloudformation figures out everything else.

In lines 8-32 describe the autoscaling group, which defines the desired capacity, minimum, and maximum number of EC2 instances. It also defines the the different availability zones. The create and termination policies are also defined.

https://github.com/adamjjones/cfn-ssb/blob/master/sunshinebrass-stack.yaml#L8-L32

In lines 33-49 defines that the EC2 instances created by the ASG will allow incoming requests on ports 22 and 80

https://github.com/adamjjones/cfn-ssb/blob/master/sunshinebrass-stack.yaml#L33-L49

In lines 53-92 I defined the WordPressLaunchConfig which contains a autoscaling launch configuration this means that I specified the image, instance type and keypair, incoming security groups and a long installation script. It also installs any software the EC2 instances need to run. The desired capacity, max and min cluster size is defined in AutoScaling group definition.

https://github.com/adamjjones/cfn-ssb/blob/master/sunshinebrass-stack.yaml#L53-L92

The load balancer comes in 4 kind of objects
	* The load balancer itself, which does not listen on a port
	* The LB Listener listens on a port 80 in this case, it is separate because you can have more than one listener
	* The LB Listener Rule, you get a default rule already included, it is separate because you can have more than one rule per listener.
	* The Target Group and it belongs with each listener rule. It tells the load balancer how to tell if a instance is haelthy enough to handle requests.
		The autoscaling group points to the target group and that is how the load balancer knows where to route requests to.

https://github.com/adamjjones/cfn-ssb/blob/master/sunshinebrass-stack.yaml#L97-L133		
