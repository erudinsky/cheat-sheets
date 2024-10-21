# Azure Storage Blob bash uploader

1. Create Azure Storage
2. Create Container (Blob)
3. Generate shared access signature (see image below)
4. Create script (see code block below)

![](./.attachments/shared-access-signature.png)

Shell script to upload file to Azure Storage (Blob) using SAS (shared access signature): 

```bash
#!/bin/bash

FILE=$1
STORAGE=mystorage
CONTAINER=mycontainer
SAS=

curl -H "x-ms-blob-type: BlockBlob" --upload-file $FILE --url "https://$STORAGE.blob.core.windows.net/$CONTAINER/$FILE?$SAS"

```

## How to use


```bash

touch file.txt
bash uploader.sh file.txt

```