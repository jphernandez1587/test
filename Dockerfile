
#IMAGE: Get the base image for Liberty
FROM websphere-liberty:webProfile7

#BINARIES: Add in all necessary application binaries
COPY ./server.xml /config
COPY ./binary/application/* /config/dropins/


#FEATURES: Install any features that are required
RUN apt-get update && apt-get dist-upgrade -y \
&& rm -rf /var/lib/apt/lists/*
RUN /opt/ibm/wlp/bin/installUtility install  --acceptLicense \
	jsp-2.3 \
	wasJmsServer-1.0 \
	wasJmsClient-2.0 \
	mdb-3.2 \
	jdbc-4.1; exit 0

