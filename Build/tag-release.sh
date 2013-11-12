#!/bin/bash

#
# Tags a release in the base distribution, BuildEssentials and all
# framework packages. Requirements in composer manifests are adjusted
# as needed.
#
# Needs the following parameters
#
# VERSION          the version that is "to be released"
# BRANCH           the branch that is worked on
# BUILD_URL        used in commit message
#

source $(dirname ${BASH_SOURCE[0]})/BuildEssentials/ReleaseHelpers.sh

if [ -z "$1" ] ; then
	echo >&2 "No version specified (e.g. 2.1.*) as first parameter"
	exit 1
fi
VERSION=$1

if [ -z "$2" ] ; then
	echo >&2 "No branch specified (e.g. 2.1) as second parameter"
	exit 1
fi
BRANCH=$2

if [ -z "$3" ] ; then
	echo >&2 "No build URL specified as third parameter"
	exit 1
fi
BUILD_URL=$3

$(dirname ${BASH_SOURCE[0]})/set-dependencies.sh ${VERSION} ${BRANCH} "${BUILD_URL}"

tag_version ${VERSION} ${BRANCH} "${BUILD_URL}"
push_branch ${BRANCH}
push_tag ${VERSION}

tag_version ${VERSION} ${BRANCH} "${BUILD_URL}" "Packages/Sites/NeosDemoTypo3Org"
push_branch ${BRANCH} "Packages/Sites/NeosDemoTypo3Org"
push_tag ${VERSION} "Packages/Sites/NeosDemoTypo3Org"

for PACKAGE in TYPO3.Neos TYPO3.Neos.NodeTypes TYPO3.SiteKickstarter TYPO3.TYPO3CR TYPO3.TypoScript TYPO3.Imagine TYPO3.Media TYPO3.Setup ; do
	tag_version ${VERSION} ${BRANCH} "${BUILD_URL}" "Packages/Application/${PACKAGE}"
	push_branch ${BRANCH} "Packages/Application/${PACKAGE}"
	push_tag ${VERSION} "Packages/Application/${PACKAGE}"
done
