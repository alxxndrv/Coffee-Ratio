import os
os.system("""xcodebuild -project ./Ratios/Ratios.xcodeproj \
           -scheme "Ratios" \
            -sdk iphonesimulator \
           -destination 'platform=iOS Simulator,name=iPhone 11 Pro,OS=15.2' \
           test \
            | xcbeautify""")
