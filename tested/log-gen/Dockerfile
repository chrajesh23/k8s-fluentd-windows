FROM mcr.microsoft.com/windows/servercore:ltsc2019

ENV mb 1
ENV runforever false
ENV delay 20
COPY generate.ps1 .

ENTRYPOINT [ "powershell", "-File", "C:\\generate.ps1" ]