# Ghostscript layer for AWS lambda
This ghostscript layer is intended for the aws lambda 2 environment. It should be deployed as a custom layer.
Both ``x86_x64`` and ``arm64`` architecture is supported.

## How to build the layer
The following command will initiate the build process. You should end up with a ghostscript.zip file after the build process.
```bash
./build.sh
```

### Build for arm64
Currently, the build process builds for ``x86_x64`` only. If you want to change this and build for another platform such as ``arm64`` you can change the ``--plaform`` attribute in the ``.build.sh`` file.

## Deploying the layer
1. Go to the aws console -> lambda -> layers
2. Select the layer that you wish to deploy the new version to
3. Click on "create version"
4. Upload the zip file
5. Add/update your lambda function with the newly deployed layer