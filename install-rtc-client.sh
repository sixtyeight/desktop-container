#!/bin/bash

if [ -e /opt/RTC-Client-p2Repo-6.0.4.zip ]
then
	echo "Eclipse RTC Plugin found, installing Plugin now ..."
	mkdir /opt/eclipse-rtc-p2-repo
	cd /opt/eclipse-rtc-p2-repo
	7z x /opt/RTC-Client-p2Repo-6.0.4.zip

	/opt/eclipse/eclipse \
		-clean -purgeHistory \
		-application org.eclipse.equinox.p2.director \
		-noSplash \
		-repository file:/opt/eclipse-rtc-p2-repo \
		-installIUs com.ibm.team.rtc.client.feature.feature.group
else
	echo "Eclipse RTC Plugin not found, skipping this."
fi
