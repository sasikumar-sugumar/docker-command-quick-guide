#!/bin/bash
# Ask the user for the folder to upload
#folder to upload
echo 'Hello, what is the folder path to create website?'
read FOLDER_TO_UPLOAD
INDEX_FILE=index.html
ERROR_FILE=error.html
ERROR_FILE_FOUND=true
if [ $FOLDER_TO_UPLOAD == "" ]; then
	echo "Exiting... Upload directory is mandatory"
	exit
fi
#bucket to create
echo 'what is the bucket name? (default use the folder name)'
read BUCKET_NAME
echo "preparing to sync folder, looking for files..."
echo ""
if [ -d $FOLDER_TO_UPLOAD ]; then
	#if default folder should be used as bucket name
	if [ $BUCKET_NAME == "" ]; then
		#get the folder as bucket prefix
		BUCKET_NAME=$(basename $FOLDER_TO_UPLOAD)
		echo "Bucket Name : "$BUCKET_NAME
		echo ""
	fi
	#check if index.html file exists
	if [ ! -r $FOLDER_TO_UPLOAD/$INDEX_FILE ]; then
		#display error
		echo "index.html not found for the website"
		echo "..."
		echo "Exiting..."
		exit
	fi
	if [ ! -r $FOLDER_TO_UPLOAD/$ERROR_FILE_FOUND ]; then
		#flag the variable to exclude error file definition
		ERROR_FILE_FOUND=false
	fi
	#delete the bucket if already existing
	aws s3 rb s3://$BUCKET_NAME --force
	#create bucket
	aws s3 mb s3://$BUCKET_NAME
	echo $BUCKET_NAME' Created'
	#upload the directory to s3
	aws s3 sync $FOLDER_TO_UPLOAD s3://$BUCKET_NAME --acl public-read
	#mark the directory as static website in s3
	if [ $ERROR_FILE_FOUND == true ]; then
		aws s3 website s3://$BUCKET_NAME --index-document $INDEX_FILE error-document $ERROR_FILE
	else
		[ $ERROR_FILE_FOUND == false ]
		aws s3 website s3://$BUCKET_NAME --index-document $INDEX_FILE
	fi
	echo 'Website URL : http://'$BUCKET_NAME'.s3-website-us-east-1.amazonaws.com/'

fi
#echo '$FOLDER_TO_UPLOAD is not a directory'
