
powershell -Command "Set-ExecutionPolicy Bypass -Scope Process -Force; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))"

cd C:\ProgramData\chocolatey\bin

choco install -y ruby --version 2.6.5.1 --params "'/InstallDir:C:\ruby26'"  && choco install -y msys2 --version 20180531.0.0 --no-progress --params "'/NoPath /NoUpdate /InstallDir:C:\ruby26\msys64'"


 refreshenv  && ridk install 2 3 && echo gem: --no-document >> C:\ProgramData\gemrc && gem install cool.io -v 1.5.4 --platform ruby && gem install oj -v 3.3.10 && gem install json -v 2.2.0 && gem install fluentd -v 1.9.1  && gem install win32-service -v 1.0.1  && gem install win32-ipc -v 0.7.0  && gem install win32-event -v 0.6.3  && gem install windows-pr -v 1.2.6  && gem install kubeclient -v 4.6.0  && gem install fluent-plugin-kubernetes_metadata_filter -v 0.7.0  && gem install fluent-plugin-multi-format-parser -v 1.0.0  && gem install fluent-plugin-cloudwatch-logs -v 0.8.0  && gem sources --clear-all 
 
 
 powershell -Command "Remove-Item -Force C:\ruby26\lib\ruby\gems\2.6.0\cache\*.gem; Remove-Item -Recurse -Force 'C:\ProgramData\chocolatey'"
 