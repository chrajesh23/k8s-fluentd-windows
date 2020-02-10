# escape=`
FROM mcr.microsoft.com/windows/servercore:ltsc2019 
SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue';"]

WORKDIR /fluentd

RUN Invoke-WebRequest -UseBasicParsing -Uri http://packages.treasuredata.com.s3.amazonaws.com/3/windows/td-agent-3.5.1-0-x64.msi -out tdagent.msi; `
    Start-Process msiexec.exe -ArgumentList '-i', 'tdagent.msi', '/quiet', '/passive' -NoNewWindow -Wait; `
    Remove-Item tdagent.msi;

RUN  C:/opt/td-agent/embedded/bin/fluent-gem install fluent-plugin-cloudwatch-logs -v 0.8.0; `
    C:/opt/td-agent/embedded/bin/fluent-gem install fluent-plugin-multi-format-parser -v 1.0.0; `
    C:/opt/td-agent/embedded/bin/fluent-gem install fluent-plugin-concat -v 2.4.0

COPY fluent.conf /fluent/conf/fluent.conf
COPY custom/ /fluent/config/custom/


ENTRYPOINT ["cmd", "/k", "C:\\opt\\td-agent\\embedded\\bin\\fluentd", "-c", "C:\\fluent\\conf\\fluent.conf"]