FROM microsoft/dotnet:2.2-runtime AS base
WORKDIR /app

FROM microsoft/dotnet:2.2-sdk AS build
WORKDIR /src
COPY ["AKS Demo.csproj", "./"]
RUN dotnet restore "./AKS Demo.csproj"
COPY . .
WORKDIR "/src/."
RUN dotnet build "AKS Demo.csproj" -c Release -o /app

FROM build AS publish
RUN dotnet publish "AKS Demo.csproj" -c Release -o /app

FROM base AS final
WORKDIR /app
COPY --from=publish /app .
ENTRYPOINT ["dotnet", "AKS Demo.dll"]
