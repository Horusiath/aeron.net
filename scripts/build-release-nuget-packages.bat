@echo off
pushd %~dp0..
SET nuget_source=https://api.nuget.org/v3/index.json
SET myget_source=https://www.myget.org/F/aeron/api/v2/package

del nupkgs\*.nupkg

call dotnet pack src\Adaptive.Aeron\Adaptive.Aeron.csproj                -c Release --output ..\..\nupkgs
call dotnet pack src\Adaptive.Agrona\Adaptive.Agrona.csproj              -c Release --output ..\..\nupkgs
call dotnet pack src\Adaptive.Cluster\Adaptive.Cluster.csproj            -c Release --output ..\..\nupkgs
call dotnet pack src\Adaptive.Archiver\Adaptive.Archiver.csproj          -c Release --output ..\..\nupkgs
call .\scripts\nuget pack .\driver\Aeron.Driver.nuspec                   -OutputDirectory nupkgs

call dotnet nuget push nupkgs\Agrona.*.nupkg -s %nuget_source%
call dotnet nuget push nupkgs\Aeron.Client.*.nupkg -s %nuget_source%
call dotnet nuget push nupkgs\Aeron.Archiver.*.nupkg -s %nuget_source%
call dotnet nuget push nupkgs\Aeron.Driver.*.nupkg -s %nuget_source%
call dotnet nuget push nupkgs\Aeron.Cluster.*.nupkg -s %myget_source%

popd