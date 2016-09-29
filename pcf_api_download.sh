#!/bin/sh

# Downloads a product from network.pivotal.io and uploads to ops manager"

# update these for a new product
PRODUCT_NAME="cf-1.8.3-build.1.pivotal"
API_DOWNLOAD_LINK="https://network.pivotal.io/api/v2/products/elastic-runtime/releases/2324/product_files/7227/download"

# These dont need to change
PIVOTAL_NETWORK_API_TOKEN="relace with your network.pivotal.io api key"
OPSMAN="https://ops.yourcompany.com"

# credentials for your ops man admin
OPSPASS="changeme"
OPSUSER="admin"

# Download product as FILENAME
wget -O $PRODUCT_NAME --post-data="" --header="Authorization: Token ${PIVOTAL_NETWORK_API_TOKEN}" $API_DOWNLOAD_LINK

# Get ops man uaa access token
uaac target $OPSMAN/uaa
uaac token owner get opsman $OPSUSER -s "" -p $OPSPASS
UAA_ACCESS_TOKEN="$(uaac context | grep -o -P '(?<=access_token: ).*')"

# upload product to ops man
curl -k "${OPSMAN}/api/v0/available_products" \
    -X POST \
    -H "Authorization: Bearer ${UAA_ACCESS_TOKEN}" \
    -F "product[file]=@./${FILENAME}" \
    --progress-bar --verbose -o pcf_api_upload.txt
