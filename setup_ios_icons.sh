#!/bin/bash

# High-performance iOS icon setup untuk multi-flavor
# Generates all icon sizes and copies to correct AppIcon sets

set -e

IOS_PATH="ios/Runner/Assets.xcassets"

# Sizes required by iOS
SIZES=(20 29 40 60 76 83.5 1024)
SCALES=(1 2 3)

generate_icons() {
    local flavor=$1
    local source=$2
    local appicon_path="$IOS_PATH/${flavor}AppIcon.appiconset"
    
    echo "📱 Processing $flavor icons..."
    
    # Create AppIcon directory
    mkdir -p "$appicon_path"
    
    # Generate Contents.json
    cat > "$appicon_path/Contents.json" << 'EOF'
{
  "images": [
    {"size": "20x20", "idiom": "iphone", "filename": "icon-20@2x.png", "scale": "2x"},
    {"size": "20x20", "idiom": "iphone", "filename": "icon-20@3x.png", "scale": "3x"},
    {"size": "29x29", "idiom": "iphone", "filename": "icon-29@2x.png", "scale": "2x"},
    {"size": "29x29", "idiom": "iphone", "filename": "icon-29@3x.png", "scale": "3x"},
    {"size": "40x40", "idiom": "iphone", "filename": "icon-40@2x.png", "scale": "2x"},
    {"size": "40x40", "idiom": "iphone", "filename": "icon-40@3x.png", "scale": "3x"},
    {"size": "60x60", "idiom": "iphone", "filename": "icon-60@2x.png", "scale": "2x"},
    {"size": "60x60", "idiom": "iphone", "filename": "icon-60@3x.png", "scale": "3x"},
    {"size": "20x20", "idiom": "ipad", "filename": "icon-20.png", "scale": "1x"},
    {"size": "20x20", "idiom": "ipad", "filename": "icon-20@2x.png", "scale": "2x"},
    {"size": "29x29", "idiom": "ipad", "filename": "icon-29.png", "scale": "1x"},
    {"size": "29x29", "idiom": "ipad", "filename": "icon-29@2x.png", "scale": "2x"},
    {"size": "40x40", "idiom": "ipad", "filename": "icon-40.png", "scale": "1x"},
    {"size": "40x40", "idiom": "ipad", "filename": "icon-40@2x.png", "scale": "2x"},
    {"size": "76x76", "idiom": "ipad", "filename": "icon-76.png", "scale": "1x"},
    {"size": "76x76", "idiom": "ipad", "filename": "icon-76@2x.png", "scale": "2x"},
    {"size": "83.5x83.5", "idiom": "ipad", "filename": "icon-83.5@2x.png", "scale": "2x"},
    {"size": "1024x1024", "idiom": "ios-marketing", "filename": "icon-1024.png", "scale": "1x"}
  ],
  "info": {"version": 1, "author": "xcode"}
}
EOF
    
    # Generate all sizes using sips (macOS native - super fast)
    sips -z 40 40 "$source" --out "$appicon_path/icon-20@2x.png" >/dev/null 2>&1 &
    sips -z 60 60 "$source" --out "$appicon_path/icon-20@3x.png" >/dev/null 2>&1 &
    sips -z 20 20 "$source" --out "$appicon_path/icon-20.png" >/dev/null 2>&1 &
    sips -z 58 58 "$source" --out "$appicon_path/icon-29@2x.png" >/dev/null 2>&1 &
    sips -z 87 87 "$source" --out "$appicon_path/icon-29@3x.png" >/dev/null 2>&1 &
    sips -z 29 29 "$source" --out "$appicon_path/icon-29.png" >/dev/null 2>&1 &
    sips -z 80 80 "$source" --out "$appicon_path/icon-40@2x.png" >/dev/null 2>&1 &
    sips -z 120 120 "$source" --out "$appicon_path/icon-40@3x.png" >/dev/null 2>&1 &
    sips -z 40 40 "$source" --out "$appicon_path/icon-40.png" >/dev/null 2>&1 &
    sips -z 120 120 "$source" --out "$appicon_path/icon-60@2x.png" >/dev/null 2>&1 &
    sips -z 180 180 "$source" --out "$appicon_path/icon-60@3x.png" >/dev/null 2>&1 &
    sips -z 76 76 "$source" --out "$appicon_path/icon-76.png" >/dev/null 2>&1 &
    sips -z 152 152 "$source" --out "$appicon_path/icon-76@2x.png" >/dev/null 2>&1 &
    sips -z 167 167 "$source" --out "$appicon_path/icon-83.5@2x.png" >/dev/null 2>&1 &
    sips -z 1024 1024 "$source" --out "$appicon_path/icon-1024.png" >/dev/null 2>&1 &
    
    wait
    echo "✅ $flavor done"
}

# Generate parallel untuk speed
generate_icons "dev" "assets/icons/ic_launch_dev.png" &
generate_icons "uat" "assets/icons/ic_launch_uat.png" &
generate_icons "prod" "assets/icons/ic_launch_prod.png" &

wait

echo ""
echo "✅ All iOS icons generated!"
echo ""
echo "📝 Next steps:"
echo "1. Open ios/Runner.xcworkspace in Xcode"
echo "2. Select Runner target"
echo "3. Go to Build Settings > Asset Catalog Compiler"
echo "4. Add schemes:"
echo "   - dev scheme: use devAppIcon"
echo "   - uat scheme: use uatAppIcon" 
echo "   - prod scheme: use prodAppIcon"