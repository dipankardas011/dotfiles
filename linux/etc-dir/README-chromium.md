```bash
sed 's/GRAPHIC_DRIVER=default/GRAPHIC_DRIVER=nvidia/' /etc/chromium/chromium.conf
```
```conf
# system wide chromium flags

ARCH="$(arch)"

# GRAPHIC_DRIVER=[amd|intel|nvidia|default]
GRAPHIC_DRIVER=nvidia

# WEB_DARKMODE=[on|off]
WEB_DARKMODE=off

# NATIVE_WAYLAND=[on|off]
NATIVE_WAYLAND=on

CHROMIUM_FLAGS=""
if [ "$NATIVE_WAYLAND" == "off" ] ; then
   CHROMIUM_FLAGS+=" --enable-native-gpu-memory-buffers"
   CHROMIUM_FLAGS+=" --enable-gpu-memory-buffer-video-frames"
   CHROMIUM_FLAGS+=" --enable-zero-copy"
   CHROMIUM_FLAGS+=" --ignore-gpu-blocklist --disable-gpu-driver-bug-workaround"
   CHROMIUM_FLAGS+=" --enable-chrome-browser-cloud-management"
   CHROMIUM_FLAGS+=" --enable-gpu-rasterization"
else
   CHROMIUM_FLAGS+=" --enable-features=UseOzonePlatform"
   CHROMIUM_FLAGS+=" --ozone-platform=wayland"
fi

FEATURES=""

case "$GRAPHIC_DRIVER" in
   amd|intel)
      # Need new mesa with AMD multi planes support, is supported in fedora >= 40 (mesa-24.1.1 or newer)
      # see https://gitlab.freedesktop.org/mesa/mesa/-/merge_requests/26165
      CHROMIUM_FLAGS+=" --use-gl=angle --use-angle=vulkan --enable-accelerated-video-decode"
      FEATURES+="Vulkan,VulkanFromANGLE,DefaultANGLEVulkan,VaapiIgnoreDriverChecks,VaapiVideoDecoder,UseMultiPlaneFormatForHardwareVideo"
      ;;
   nvidia)
      # The NVIDIA VaAPI drivers are known to not support Chromium
      # see https://crbug.com/1492880. This feature switch is
      # provided for developers to test VaAPI drivers on NVIDIA GPUs
      CHROMIUM_FLAGS+=" --use-gl=angle --use-angle=gl"
      FEATURES+="VaapiVideoDecodeLinuxGL,VaapiVideoEncoder,VaapiOnNvidiaGPUs"
      ;;
   *)
      CHROMIUM_FLAGS+=" --use-gl=angle --use-angle=gl"
      FEATURES+="VaapiVideoEncoder,VaapiVideoDecodeLinuxGL"
      ;;
esac
       
# Web Dark mode
if [ "$WEB_DARKMODE" == "on" ] ; then
   darktype="WebContentsForceDark:inversion_method/cielab_based/image_behavior/none/foreground_lightness_threshold/150/background_lightness_threshold/205"
   FEATURES+=",$darktype"
fi

if [ "$ARCH" == "x86_64" ] ; then
   CHROMIUM_FLAGS+=" --enable-features=$FEATURES"
fi
```
