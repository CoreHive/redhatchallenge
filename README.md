Environment Centos 8 ppc64le

## Step 1 - Install Node.js:
```
sudo apt-get install curl
curl -sL https://deb.nodesource.com/setup_12.x | sudo -E bash -

sudo apt-get install nodejs
```

## Step 2 – Install ODBC prerequisite
```
sudo apt-get install unixodbc unixodbc-dev
```

## Step 3 – Install Express.js, Pug, and ODBC
```
npm install express pug odbc
```

## Step 4 – I had to install the Linux IBM I ACS ODBC driver
https://iwm.dhe.ibm.com/sdfdl/v2/regs2/sharee2/iacs-java/v1r1/Xa.2/Xb.Fjx4e5cja3cCTkc34gB00sjgdAUDdX7SBFhLbz0yzSY/Xc.iacs-java/v1r1/IBMiAccess_v1r1_LinuxAP.zip/Xd./Xf.lPr.D1vk/Xg.11015757/Xi.swg-ia/XY.regsrvs/XZ.StxpNON8aUA1xp3EzZlnW47vbeWuDWA7/IBMiAccess_v1r1_LinuxAP.zip

```
dpkg -i ibm-iaccess-1.1.0.14-1.0.amd64.deb
```

## Step 5 – Setup Pages
I created the code to get and post data to the web pages

## Step 6 – Install Body-Parser for Search
```
npm install body-parser
```
