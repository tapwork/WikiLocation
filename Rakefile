desc "Bootstraps the repo"
task :bootstrap do
  sh 'export LANG=en_US.UTF-8'
  sh 'bundle'
end

desc "Runs the specs"
task :spec do
  sh 'xcodebuild -project WikiLocation.xcodeproj -scheme \'WikiLocation\' -destination \'platform=iOS Simulator,name=iPhone 6\' clean test -sdk iphonesimulator | xcpretty -tc && exit ${PIPESTATUS[0]}'
end
