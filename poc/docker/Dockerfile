# escape=`
FROM mcr.microsoft.com/windows/servercore:ltsc2019 AS base
SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue';"]

WORKDIR /fluentd

RUN Invoke-WebRequest -UseBasicParsing -Uri http://packages.treasuredata.com.s3.amazonaws.com/3/windows/td-agent-3.5.1-0-x64.msi -out tdagent.msi; `
    Start-Process msiexec.exe -ArgumentList '-i', 'tdagent.msi', '/quiet', '/passive' -NoNewWindow -Wait; `
    Remove-Item tdagent.msi;

FROM mcr.microsoft.com/windows/servercore:ltsc2019
COPY --from=base ["C:\\opt\\td-agent", "C:\\opt\\td-agent"]

COPY fluent.conf /fluent/conf/fluent.conf
COPY custom/ /fluent/config/custom/

RUN C:/opt/td-agent/embedded/bin/fluent-gem install fluent-plugin-kubernetes_metadata_filter && `
    C:/opt/td-agent/embedded/bin/fluent-gem install fluent-plugin-multi-format-parser && `
    C:/opt/td-agent/embedded/bin/fluent-gem install fluent-plugin-cloudwatch-logs
    
# we need to install cloudwatch plugin 
# fluent-plugin-cloudwatch-logs
# aws-sdk-cloudwatchlogs

ENTRYPOINT ["cmd", "/k", "C:\\opt\\td-agent\\embedded\\bin\\fluentd", "-c", "C:\\fluent\\conf\\fluent.conf"]