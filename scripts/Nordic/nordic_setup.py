import os
import urllib2
import zipfile

#Create project architecture
try: 
    os.makedirs("sources")
except OSError:
    if not os.path.isdir("source"):
        print("Create sources folder")
        raise
    else: 
        print("sources folder already exist!")

try: 
    os.makedirs("includes")
except OSError:
    if not os.path.isdir("includes"):
        print("Create includes folder")
        raise
    else: 
        print("includes folder already exist!")

try: 
    os.makedirs("libs/nRF5_SDK")
except OSError:
    if not os.path.isdir("libs/nRF5_SDK"):
        print("Create sdk folder in libs")
        raise
    else: 
        print("sdk folder already exist!")     

#Download Nordic SDK
url = 'https://developer.nordicsemi.com/nRF5_SDK/nRF5_SDK_v15.x.x/nRF5_SDK_15.0.0_a53641a.zip'

print "Downloading Nordic SDK"
f = urllib2.urlopen(url)
data = f.read()
with open("sdk.zip", "wb") as code:
    code.write(data)

zip_ref = zipfile.ZipFile('sdk.zip', 'r')
zip_ref.extractall("libs/nRF5_SDK")
zip_ref.close()
os.remove('sdk.zip')