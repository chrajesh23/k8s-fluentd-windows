FROM mcr.microsoft.com/powershell:7.0.0-rc.2-nanoserver-1803

ENV mb 1
ENV runforever false
ENV delay 1
COPY generate.ps1 .

ENTRYPOINT [ "pwsh", "-File", "C:\\generate.ps1" ]