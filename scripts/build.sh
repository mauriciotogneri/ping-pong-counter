#!/bin/sh

set -e

flutter clean
flutter build web --web-renderer canvaskit

OUTPUT="./hosting/public"
rm -r ${OUTPUT}
mkdir ${OUTPUT}
cp -r build/web/** ${OUTPUT}

cd ./hosting
firebase deploy --only hosting
cd ..