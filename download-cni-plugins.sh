set -e -x
case $TARGETPLATFORM in
    linux/amd64)  platform=linux-amd64 ;;
    linux/arm64*) platform=linux-arm64 ;;
    linux/arm*)  platform=linux-arm ;;
    *) 
        echo "Unsupported TARGETPLATFORM=$TARGETPLATFORM"
        exit 1 ;;
esac
wget https://github.com/containernetworking/plugins/releases/download/$version/cni-plugins-$platform-$version.tgz
wget https://github.com/containernetworking/plugins/releases/download/$version/cni-plugins-$platform-$version.tgz.sha512
sha512sum -c cni-plugins-$platform-$version.tgz.sha512
tar xvzf cni-plugins-$platform-$version.tgz
rm cni-plugins-$platform-$version.tgz cni-plugins-$platform-$version.tgz.sha512