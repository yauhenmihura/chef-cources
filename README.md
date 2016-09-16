# Task8 by Yauhen Mihura

* <h3>Created environments (chef-dev)</h3>
![imgs](pic/env.png "imgs")

* <h3>Created Roles(jboss)</h3>
![imgs](pic/roles.png "imgs")

* <h3>Created Data bags (hudson)</h3>

![imgs](pic/Data Bags.png "imgs")

For upload and start i used next commands:
* knife upload cookbooks
* knife bootstrap 192.168.33.13 -x root -P vagrant -r 'role[jboss]' -N mihura -E chef-dev


<h3>Result after start</h3>
*  ```output1.txt``` ([output1.txt](output1.txt))

<h3> Check with curl: </h3>
![imgs](pic/curl.png "imgs")

<h3> Check with nodes at CHef server: <h3>
![imgs](pic/nodes.png "imgs")
