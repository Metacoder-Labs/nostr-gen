#!/bin/bash

WORKING_DIR='/home/nodeops/nostr-gen'
RELEASE_DIR='/home/nodeops/jnsdao/.well-known'
CONFIG_FILE='nostr.json'

## go to working dir
cd $WORKING_DIR

## gen config file according to blockchain data
node index.js

## check diff
DIFF=$(diff $RELEASE_DIR/$CONFIG_FILE $CONFIG_FILE)
echo $DIFF

if [ "$DIFF" != "" ]
then
	cp $CONFIG_FILE $RELEASE_DIR/$CONFIG_FILE

	cd $RELEASE_DIR
	git pull
	git status

	git commit -a -m 'update nostr config'
	git push

fi

