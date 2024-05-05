# remote work
# Download the remote script using curl
curl -O https://github.com/abikesa/do/raw/main/hello.do

# Run Stata in batch mode with the downloaded script
export PATH=$PATH:/applications/stata/statamp.app/contents/macos/
stata-mp -b hello.do