FROM mcr.microsoft.com/dotnet/sdk:3.1 AS builder
WORKDIR /src
COPY ./Docker_Demo.csproj .
RUN dotnet restore Docker_Demo.csproj
COPY . .
RUN dotnet build Docker_Demo.csproj -c Debug -o /src/out
# using ASP.NET Core SDK to run the image inside the container
FROM mcr.microsoft.com/dotnet/aspnet:3.1
WORKDIR /app
COPY --from=builder /src/out .

EXPOSE 80
ENTRYPOINT [ "dotnet", "Docker_Demo.dll"]