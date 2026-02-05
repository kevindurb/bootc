#! /bin/bash

SYNCOID_ARGS='--recursive --skip-parent --no-sync-snap --no-privilege-elevation'
SRC='tank/storage'
DEST='rust/backup'

syncoid $SYNCOID_ARGS drone-01:$SRC $DEST
syncoid $SYNCOID_ARGS drone-02:$SRC $DEST
syncoid $SYNCOID_ARGS drone-03:$SRC $DEST
syncoid $SYNCOID_ARGS $SRC $DEST
