#!/bin/sh
s3cmd --recursive --exclude-from=.s3ignore sync ~/Development/* s3://rafaqueque-development/
